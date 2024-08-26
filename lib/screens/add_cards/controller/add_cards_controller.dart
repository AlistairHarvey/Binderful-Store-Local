// ignore_for_file: missing_whitespace_between_adjacent_strings, no_adjacent_strings_in_list, lines_longer_than_80_chars

import 'dart:math';

import 'package:binderful_store/models/card_class.dart';
import 'package:binderful_store/models/card_upload_class.dart';
import 'package:binderful_store/screens/add_cards/controller/add_cards_state.dart';
import 'package:binderful_store/screens/add_cards/service/add_cards_service.dart';
import 'package:flutter/material.dart';

class AddCardController extends ChangeNotifier {
  final state = AddCardState();
  final service = AddCardsService();

  Future<void> selectCard(Pokemon card) async {
    state.results.removeWhere((element) => element != card);
    var setID = card.set.id;
    if (card.set.id.endsWith('tg')) {
      setID = card.set.id.substring(0, card.set.id.length - 2);
    }

    state.price = await service.getPrice(card.number, setID);
    setPrice();
    notifyListeners();
  }

  void addCardToList(
    Pokemon pokemon,
    double value,
    String? condition,
    int quantity,
  ) {
    debugPrint(pokemon.name);
    debugPrint(value.toString());
    state.savedCards.add(
      CardUploadClass.fromPokemon(
        value,
        condition ?? 'NM',
        quantity,
        pokemon,
      ),
    );
    state.total += value * quantity;
    state.results.clear();
    if (!state.isReverseHoloMode) state.cardNoController.clear();
    state.price = null;

    notifyListeners();
  }

  void viewAll() {
    state.isViewAll = true;
    notifyListeners();
  }

  void reverseHoloMode() {
    state.isReverseHoloMode = !state.isReverseHoloMode;
    notifyListeners();
  }

  void tradeInMode() {
    state.isTradeIn = !state.isTradeIn;
    notifyListeners();
  }

  void addMore() {
    state.isViewAll = false;
    notifyListeners();
  }

  void updateCardQunatity(String v, CardUploadClass card) {
    if (int.tryParse(v) != null) {
      final thisCard =
          state.savedCards.firstWhere((element) => element == card);
      final newQuantity = int.parse(v);
      thisCard.quantity = newQuantity;
      updateTotal();
    } else {
      debugPrint('updating ${card.name} quantity failed');
    }
  }

  void updateCardPrice(String v, CardUploadClass card) {
    final newV = v.replaceAll('£', '');
    if (double.tryParse(newV) != null) {
      state.savedCards.firstWhere((element) => element.id == card.id).price =
          double.parse(newV);
      updateTotal();
    } else {
      debugPrint('updating ${card.name} price failed');
    }
  }

  void updateTotal() {
    state.total = state.savedCards.fold(
      0,
      (total, item) => total + (item.quantity * item.price),
    );
    notifyListeners();
  }

  void removeSavedCard(int index) {
    state.savedCards.removeAt(index);
    notifyListeners();
  }

  void setPrice() {
    final prices = state.price;
    final holo = prices?.holoValues.lastOrNull ?? 0;
    final reverse = prices?.reverseHoloValues.lastOrNull ?? 0;
    final common = prices?.nonHoloValues.lastOrNull ?? 0;
    final highest = max(common, max(holo, reverse));
    state.priceController.text = _roundedPrice(highest);
    notifyListeners();
  }

  String _roundedPrice(double price) {
    final roundedValue = (price * 4).ceil() / 4;
    return roundedValue.toString();
  }

  void clear() {
    state.savedCards.clear();
    state.total = 0;
    notifyListeners();
  }
}
