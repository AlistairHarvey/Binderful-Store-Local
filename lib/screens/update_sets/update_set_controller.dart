// ignore_for_file: missing_whitespace_between_adjacent_strings, no_adjacent_strings_in_list, lines_longer_than_80_chars

import 'dart:convert';

import 'package:binderful_store/constants/search_sort_enum.dart';
import 'package:binderful_store/models/card_class.dart';
import 'package:binderful_store/models/card_raven.dart';
import 'package:binderful_store/models/pricing_history_model.dart';
import 'package:binderful_store/models/set_ids.dart';
import 'package:binderful_store/screens/update_sets/services/set_maintenance_service.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class UpdateSetController extends ChangeNotifier {
  List<MySetData> setsFromRaven = [];
  List<SetData> setsFromPokemonAPI = [];
  List<Pokemon> setCards = [];
  List<CardRaven> setCardsFromRaven = [];
  String? selectedSetID;
  int setTotal = 0;
  bool loading = false;
  bool apiLoading = false;
  bool loadingSet = false;
  SetScreenEnum screen = SetScreenEnum.setList;
  SortBy sortingBy = SortBy.mostRecent;
  TextEditingController searchTextController = TextEditingController();
  List<SetData> filteredList = [];
  List<PricingHistoryUpdateDates> pricingHistories = [];

  final SetMaintenanceService service = SetMaintenanceService();

  SetId setIDFromCode(String code) {
    return SetId.values.where((element) => element.name == code).first;
  }

  Future<void> populateSetsFromRaven() async {
    loading = true;

    debugPrint('Getting Sets From Pokemon API');

    final setData = await service.getSetDataFromPokemonApi();

    if (setData == null) return;

    debugPrint('Got Sets From Pokemon API ${setData.data.length}');

    setsFromPokemonAPI.clear();
    setsFromPokemonAPI.addAll(setData.data);
    setsFromPokemonAPI
        .removeWhere((e) => e.name.toLowerCase().contains('gallery'));
    sortSets();
    filteredList = setsFromPokemonAPI
        .where(
          (e) =>
              e.series.contains(searchTextController.text) ||
              e.name.contains(searchTextController.text),
        )
        .toList();

    debugPrint('Getting Sets From Pokemon API');

    final ravenSetData = await service.getSetDataFromRavenDB();

    if (ravenSetData == null) return;

    for (final set in ravenSetData) {
      setsFromRaven.add(set);
    }

    //TODO sort this to come from above call
    final setsPricingHistoryDate = await http.get(
      Uri.parse(
        'http://localhost:5027/api/Pokemon/Sets/getAllSetsLastUpdateDates',
      ),
    );

    final ravenSetHistoryData =
        jsonDecode(setsPricingHistoryDate.body) as List<dynamic>;
    pricingHistories = ravenSetHistoryData
        .map(
          (json) => PricingHistoryUpdateDates.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
    debugPrint('Get Sets Complete');
    loading = false;
    notifyListeners();
  }

  Future<void> removeSetFromRaven(String setID) async {
    final success = await service.removeSet(setID);

    if (success) setsFromRaven.removeWhere((e) => e.id == setID);

    notifyListeners();
  }

  Future<void> updateSets(SetData set) async {
    final setsForRaven = <MySetData>[];

    setsForRaven.add(MySetData.fromSetData(set));

    for (final set in setsFromRaven) {
      setsForRaven
          .removeWhere((e) => e.name.toLowerCase() == set.name.toLowerCase());
    }

    for (final set in setsForRaven) {
      final success = await service.addSet(set);
      if (!success) debugPrint('${set.id} failed to upload');
    }

    final ravenSetData = await service.getSetDataFromRavenDB();

    if (ravenSetData == null) return;

    for (final set in ravenSetData) {
      setsFromRaven.add(set);
    }
    loading = false;

    await updateCardsInRaven();

    notifyListeners();
    notifyListeners();
  }

  void setScreen(SetScreenEnum setScreen) {
    screen = setScreen;
    notifyListeners();
  }

  Future<void> popCardList(String setID) async {
    loadingSet = true;
    notifyListeners();
    selectedSetID = setID;
    final pokemonData =
        await service.setListFromRaven('q=set.id:$setID&orderBy=number');

    // Pulls in a max of 250 at a time, no set is over 500 cards.
    if (setsFromRaven
            .firstWhere((e) => e.id.toLowerCase() == setID.toLowerCase())
            .total >
        250) {
      final response2 = await service.setListFromRaven(
        'q=set.id:$setID&orderBy=number&page=2',
      );
      pokemonData.data.addAll(response2.data);
    }

    setCards.clear();
    setCardsFromRaven.clear();
    setCards.addAll(pokemonData.data);
    setTotal = setCards.first.set.printedTotal;
    loading = false;
    await getSetCardsFromRaven(setID);
    loadingSet = false;
    notifyListeners();
  }

  Future<void> uploadAllSetCardsToRaven() async {
    final cardsForRAVEN = <CardRaven>[];
    for (final card in setCards) {
      cardsForRAVEN.add(CardRaven.fromApiClass(card));
    }
    final trips = (cardsForRAVEN.length / 20).ceil();
    for (var i = 0; i < trips; i = i + 1) {
      await service.addCardToRaven(cardsForRAVEN.take(20).toList());
      cardsForRAVEN.removeRange(
        0,
        cardsForRAVEN.length >= 20 ? 20 : cardsForRAVEN.length,
      );
    }
  }

  Future<void> getSetCardsFromRaven(String setID) async {
    final ravenResponse = await service.getCardsFromRaven(setID);
    setCardsFromRaven.addAll(ravenResponse);
  }

  Future<void> updateCardsInRaven() async {
    for (final set in setsFromPokemonAPI) {
      final cardsInRaven = await service.ravenHasCardsFromSet(set.id);
      if (cardsInRaven) {
        await popCardList(set.id).then((value) => uploadAllSetCardsToRaven());
      }
    }
  }

  Future<void> updateSetPricingHistory(SetData? passedInSet) async {
    late final SetData set;
    final setID = passedInSet?.id ?? selectedSetID;

    set = setsFromPokemonAPI.firstWhere((element) => element.id == setID);

    final cardNumbers = <String, List<PricingHistoryData>>{};
    final pricingHistory = <PricingHistoryModel>[];

    var endOfCards = false;
    debugPrint(set.id);
    var i = 1;
    var celCardNo = 1;
    do {
      apiLoading = true;
      notifyListeners();
      final subURL = setIDFromCode(set.id).baseUrl;

      // for (int i = 1; i <= repeatCount; i++) {
      final url = Uri.parse(
        'https://pokecardvalues.co.uk/sets/$subURL?page=$i&q=&holographic=&completion=&edition=&rarity=&got_need=&display=grid',
      );

      // Make an HTTP request to get the HTML content
      final response = await http.get(url);

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the HTML content
        final document = parse(response.body);

        debugPrint(response.toString());

        // Select all elements with class "box-element"
        final cardElements = document.querySelectorAll('.box-element');

        // Iterate through each card element
        for (final element in cardElements) {
          // Extract card details
          final cardNumber = _getCardNumber(
                element.querySelector('.card-title-info')?.text ?? 'N/A',
              ) ??
              'N/A';
          if ((int.tryParse(cardNumber) ?? 0) > set.total &&
              set.id != 'cel25c') {
            break;
          }
          final cardName = _getCardName(
                element.querySelector('.card-title-info')?.text ?? 'N/A',
              ) ??
              'N/A';
          final price = _getCardValue(
                element.querySelector('.price-info')?.text ?? 'N/A',
              ) ??
              '';
          final rarity = _getRarity(
                element.querySelector('.card-holo-edition-info')?.text ?? 'N/A',
              ) ??
              '';

          //Print or store the extracted information
          debugPrint(
            'Card Name: $cardName, '
            'Card Number: $cardNumber, '
            'Price: $price, '
            'rarity: $rarity',
          );
          if (set.id == 'cel25c') {
            cardNumbers.addAll({
              celCardNo.toString(): [
                PricingHistoryData(
                  cardName, rarity, double.tryParse(price) ?? 0.0,
                  // DateTime.now().toString(),
                ),
              ],
            });
            celCardNo += 1;
          } else if (cardNumbers.keys.contains(cardNumber)) {
            cardNumbers[cardNumber]!.add(
              PricingHistoryData(
                cardName,
                rarity,
                double.tryParse(price) ?? 0.0,
                // DateTime.now().toString(),
              ),
            );
          } else {
            cardNumbers.addAll({
              cardNumber: [
                PricingHistoryData(
                  cardName,
                  rarity,
                  double.tryParse(price) ?? 0.0,
                ),
              ],
            });
          }
        }

        final finalCardNo = _getCardNumber(
          cardElements.last.querySelector('.card-title-info')?.text ?? '',
        )!
            .split('/')
            .first;
        if ((((int.tryParse(finalCardNo) ?? 0) >= set.total ||
                    finalCardNo == 'GG70' ||
                    finalCardNo == 'TG30') ||
                finalCardNo.toLowerCase() == 'sv122' ||
                finalCardNo.toLowerCase() == 'sv94' ||
                (set.id == 'sm35' && finalCardNo == '78') &&
                    !(set.id == 'cel25c')) ||
            (set.id == 'cel25c' && cardNumbers.length == 25)) {
          endOfCards = true;
          break;
        }
      } else {
        debugPrint('Failed to fetch data. Status code: ${response.statusCode}');
        break;
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
      i++;
    } while (endOfCards != true);
    cardNumbers.forEach((key, value) {
      final name = '${set.id}-${key.split('/').first}';

      final reverseHoloValue = value
          .where(
            (element) =>
                element.rarity.contains('Reverse Holo') &&
                element.rarity.contains('Unlimited'),
          )
          .firstOrNull
          ?.value;
      final commonValue = value
          .where(
            (element) =>
                element.rarity.contains('Non-Holo') &&
                element.rarity.contains('Unlimited'),
          )
          .firstOrNull
          ?.value;
      final holoValue = value
          .where(
            (element) =>
                !element.rarity.contains('Non-Holo') &&
                !element.rarity.contains('Reverse Holo') &&
                element.rarity.contains('Unlimited'),
          )
          .firstOrNull
          ?.value;

      final firstEditionShadowlessValues = value
          .where(
            (element) => element.rarity.contains('1st Edition Shadowless'),
          )
          .firstOrNull
          ?.value;

      final firstEditionValues = value
          .where(
            (element) =>
                element.rarity.contains('1st Edition') &&
                !element.rarity.contains('Shadowless'),
          )
          .firstOrNull
          ?.value;

      final shadowlessValues = value
          .where(
            (element) =>
                element.rarity.contains('Shadowless') &&
                !element.rarity.contains('1st Edition'),
          )
          .firstOrNull
          ?.value;

      final print1999to2000Values = value
          .where((element) => element.rarity.contains('1999-2000 Print'))
          .firstOrNull
          ?.value;

      pricingHistory.add(
        PricingHistoryModel(
          pricingHistoryID: name,
          setID: set.id,
          holoValues: holoValue != null ? [holoValue] : [],
          reverseHoloValues: reverseHoloValue != null ? [reverseHoloValue] : [],
          nonHoloValues: commonValue != null ? [commonValue] : [],
          updateDates: [DateTime.now().toIso8601String()],
          firstEditionValues:
              firstEditionValues != null ? [firstEditionValues] : [],
          firstEditionShadowlessValues: firstEditionShadowlessValues != null
              ? [firstEditionShadowlessValues]
              : [],
          shadowlessValues: shadowlessValues != null ? [shadowlessValues] : [],
          print1999to2000Values:
              print1999to2000Values != null ? [print1999to2000Values] : [],
        ),
      );
    });
    final apiUrl =
        Uri.parse('http://localhost:5027/api/Pokemon/PricingHistory/add');
    final length = cardNumbers.length;
    for (var i = 0; i < cardNumbers.length; i += 15) {
      var count = 0;
      if (i + 15 > length) {
        count = length - i;
      } else {
        count = 15;
      }
      final batch = pricingHistory.sublist(i, i + count).toList();
      final data = batch
          .map((element) => element.toJson())
          .toList(); // Convert to a list of JSON representations
      final response = await http.post(
        apiUrl,
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          data,
        ),
      );
      debugPrint(response.statusCode.toString());
    }

    await updateUSAPricingHistory(set);
    apiLoading = false;
    notifyListeners();
  }

  String? _getCardNumber(String input) {
    final thisString = input.trim();
    final index = thisString.indexOf(' - ');
    if (index == -1) {
      return null;
    }
    return thisString.substring(index).replaceAll(' ', '').replaceAll('-', '');
  }

  String? _getCardName(String input) {
    final thisString = input.trim();
    final index = thisString.indexOf(' - ');
    if (index == -1) {
      return null;
    }
    return thisString.substring(0, index);
  }

  String? _getCardValue(String input) {
    final regex = RegExp(r'£([\d.]+)');
    final match = regex.firstMatch(input.trim());

    if (match != null && match.groupCount >= 1) {
      final extractedName = match.group(1)!;
      return extractedName.trim();
    } else {
      return null;
    }
  }

  String? _getRarity(String input) {
    return input.trim();
  }

  void changeSetSorting(SortBy value) {
    sortingBy = value;
    sortSets();
    filterList();
    notifyListeners();
  }

  void sortSets() {
    if (sortingBy == SortBy.mostRecent) {
      setsFromPokemonAPI.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
    } else {
      setsFromPokemonAPI.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
    }
  }

  void filterList() {
    filteredList = setsFromPokemonAPI
        .where(
          (e) =>
              e.series
                  .toLowerCase()
                  .contains(searchTextController.text.toLowerCase()) ||
              e.name
                  .toLowerCase()
                  .contains(searchTextController.text.toLowerCase()),
        )
        .toList();
    notifyListeners();
  }

  Future<void> updateUSAPricingHistory(SetData set) async {
    final cards = <Pokemon>[];

    final response = await http.get(
      Uri.parse(
        'https://api.pokemontcg.io/v2/cards?q=set.id:${set.id}&orderBy=number',
      ),
    );
    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    final pokemonData = PokemonData.fromJson(jsonData);
    cards.addAll(pokemonData.data);

    if (pokemonData.totalCount > pokemonData.pageSize) {
      final response = await http.get(
        Uri.parse(
          'https://api.pokemontcg.io/v2/cards?q=set.id:${set.id}&orderBy=number&page2',
        ),
      );
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final pokemonData = PokemonData.fromJson(jsonData);
      cards.addAll(pokemonData.data);
    }
    final tg = _hasTG(set.id.toLowerCase());

    if (tg != null) {
      final response = await http.get(
        Uri.parse(
          'https://api.pokemontcg.io/v2/cards?q=set.id:${set.id + tg}&orderBy=number',
        ),
      );
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final pokemonData = PokemonData.fromJson(jsonData);
      cards.addAll(pokemonData.data);
    }

    // TODO

    // final usaPrices = cards
    //     .map(
    //       (e) => USAPricingHistory(
    //         pricingHistoryID: '${set.id}-${e.number}',
    //         setID: set.id,
    //         updateDates: [DateTime.now().toIso8601String()],
    //         holofoilValues: e.tcgplayer.prices.holofoil != null
    //             ? [e.tcgplayer.prices.holofoil!]
    //             : null,
    //         reverseHolofoilValues: e.tcgplayer.prices.reverseHolofoil != null
    //             ? [e.tcgplayer.prices.reverseHolofoil!]
    //             : null,
    //         normalValues: e.tcgplayer.prices.normal != null
    //             ? [e.tcgplayer.prices.normal!]
    //             : null,
    //       ),
    //     )
    //     .toList();

    // final body = usaPrices.map((e) {
    //   debugPrint(e.pricingHistoryID);
    //   return e.toJson();
    // }).toList();
    // TODO Fix
    // for (int i = 0; i <= cards.length; i + 20) {
    //   final updateResponse = await http.post(
    //     Uri.parse('http://localhost:5027/api/Pokemon/PricingHistory/USA/add'),
    //     body: jsonEncode(
    //       body.sublist(i, i + 20),
    //     ),
    //   );

    //   debugPrint(updateResponse.statusCode.toString());
    // }
  }

  String? _hasTG(String id) {
    if (id.contains('swsh12tg')) {
      return 'gg';
    } else if (id.contains('swsh9') ||
        id.contains('swsh10') ||
        id.contains('swsh11') ||
        id.contains('swsh12')) {
      return 'tg';
    }
    return null;
  }
}

class PricingHistoryData {
  PricingHistoryData(
    this.cardName,
    this.rarity,
    this.value,
    // this.date,
  );
  String cardName;
  String rarity;
  double value;
  // String date;
}

enum SetScreenEnum {
  setList,
  setCards,
}
