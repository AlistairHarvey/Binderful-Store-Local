import 'package:binderful_store/constants/card_search_type.dart';
import 'package:binderful_store/screens/add_cards/controller/add_cards_controller.dart';
import 'package:flutter/material.dart';

mixin Lookups on AddCardController {
  Future<void> lookupCard() async {
    state.isViewAll = false;

    final regexGG = RegExp(r'^GG(?:[0-6]\d|70)$');
    final regexTG = RegExp(r'^TG(?:0[1-9]|1\d|20|30)$');
    final regexPROMO = RegExp(r'^[A-Za-z]{2,4}\d{2,3}$');
    final regexNormal = RegExp(r'^\d{1,3}/\d{2,3}$');
    final regexSV = RegExp(r'^SV(00[1-9]|0[1-9]\d|1\d\d|200)$');

    final search = state.cardNoController.text.toUpperCase();
    if (search.isEmpty) {
      return;
    } else if (regexGG.hasMatch(search)) {
      await lookupGgCard();
    } else if (regexTG.hasMatch(search)) {
      await lookupTgCard();
    } else if (regexSV.hasMatch(search)) {
      await lookupPromoCard();
    } else if (regexPROMO.hasMatch(search)) {
      await lookupPromoCard();
    } else if (regexNormal.hasMatch(search)) {
      await lookupNormalCard();
    }
    setPrice();
  }

  Future<void> lookupNormalCard() async {
    state.loading = true;
    notifyListeners();
    final search = state.cardNoController.text;
    final index = search.indexOf('/');
    var cardNo = '';
    var setNo = '';
    if (index != -1) {
      //allowing for inputs like 001 where the api would take this as 1
      cardNo = int.parse(search.substring(0, index), radix: 10).toString();
      setNo = search.substring(index + 1);
    } else {
      debugPrint('Delimiter not found in the string.');
      return;
    }

    final results =
        await service.getCard('q=number:$cardNo set.printedTotal:$setNo');

    state.results.clear();
    state.results.addAll(results);
    if (state.results.length == 1) {
      final pokemon = state.results.first;
      state.pokemonImage = pokemon.images.small;
      state.title = pokemon.name;
      state.set = pokemon.set.name;
      state.price = await service.getPrice(pokemon.number, pokemon.set.id);
    }
    state.loading = false;
    notifyListeners();
  }

  Future<void> lookupTgCard() async {
    final cardNo = state.cardNoController.text;

    state.loading = true;
    state.results.clear();
    notifyListeners();
    for (final tg in TgSetsType.values) {
      final results = await service
          .getCard('q=number:$cardNo set.name:"${tg.title} Trainer Gallery"');

      state.results.addAll(results);
    }
    if (state.results.length == 1) {
      final pokemon = state.results.first;
      state.pokemonImage = pokemon.images.small;
      state.title = pokemon.name;
      state.set = pokemon.set.name;
      state.price = await service.getPrice(cardNo, pokemon.id);
    }
    state.cardNoController.text = 'TG';
    state.loading = false;
    notifyListeners();
  }

  Future<void> lookupGgCard() async {
    final cardNo = state.cardNoController.text;

    state.loading = true;
    notifyListeners();
    final results =
        await service.getCard('q=number:$cardNo set.id:swsh12pt5gg');

    state.results.clear();
    state.results.addAll(results);
    if (state.results.length == 1) {
      final pokemon = state.results.first;
      state.pokemonImage = pokemon.images.small;
      state.title = pokemon.name;
      state.set = pokemon.set.name;
      state.price = await service.getPrice(cardNo, 'swsh12pt5');
    }
    state.loading = false;
    notifyListeners();
  }

  Future<void> lookupPromoCard() async {
    final cardNo = state.cardNoController.text;
    late String searchString;
    if (cardNo.toLowerCase().contains('svp')) {
      final number = int.tryParse(cardNo.toLowerCase().replaceAll('svp', ''));
      if (number != null) {
        searchString = 'q=number:$number set.id:svp';
      }
    } else {
      searchString = 'q=number:$cardNo';
    }
    state.loading = true;
    notifyListeners();
    final results = await service.getCard(searchString);

    state.results.clear();
    state.results.addAll(results);
    if (state.results.length == 1) {
      final pokemon = state.results.first;
      state.pokemonImage = pokemon.images.small;
      state.title = pokemon.name;
      state.set = pokemon.set.name;
      state.price = await service.getPrice(cardNo, pokemon.set.id);
    }
    state.loading = false;
    notifyListeners();
  }
}
