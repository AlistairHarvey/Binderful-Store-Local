import 'dart:convert';

import 'package:binderful_store/models/card_class.dart';
import 'package:binderful_store/models/card_raven.dart';
import 'package:binderful_store/models/pokemon_set_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SetMaintenanceService {
  Future<PokemonSetData?> getSetDataFromPokemonApi() async {
    final response = await http.get(
      Uri.parse('https://api.pokemontcg.io/v2/sets'),
    );
    try {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return PokemonSetData.fromJson(jsonData);
    } catch (e) {
      Exception(e);
    }
    return null;
  }

  Future<List<MySetData>?> getSetDataFromRavenDB() async {
    final ravenResponse = await http.get(
      Uri.parse('http://localhost:5001/getSets'),
    );
    try {
      final ravenJsonData = jsonDecode(ravenResponse.body) as List<dynamic>;
      return ravenJsonData
          .map(
            (e) => MySetData.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } catch (e) {
      Exception(e);
    }
    return null;
  }

  Future<PokemonData> setListFromRaven(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://api.pokemontcg.io/v2/cards?$query',
      ),
    );
    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    return PokemonData.fromJson(jsonData);
  }

  Future<bool> removeSet(String setID) async {
    final response =
        await http.delete(Uri.parse('http://localhost:5001/removeData/$setID'));

    if (response.statusCode == 200) {
      debugPrint('Set removed successfully');
      return true;
    } else if (response.statusCode == 404) {
      debugPrint('Set not found');
    } else {
      debugPrint('Error: ${response.statusCode}');
    }
    return false;
  }

  Future<bool> addSet(MySetData set) async {
    final body = json.encode(set.toJson());
    debugPrint(body);
    final ravenResponse = await http.post(
      Uri.parse('http://localhost:5001/addData'),
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return ravenResponse.statusCode == 200;
  }

  Future<void> addCardToRaven(List<CardRaven> cards) async {
    final body = json.encode(CardRaven.toJsonList(cards));
    await http.post(
      Uri.parse('http://localhost:5001/addCard'),
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }

  Future<List<CardRaven>> getCardsFromRaven(String setID) async {
    final ravenResponse = await http.get(
      Uri.parse('http://localhost:5001/cards/$setID'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return readCardsFromJsonFile(ravenResponse.body);
  }

  Future<bool> ravenHasCardsFromSet(String setID) async {
    final ravenResponse = await http.get(
      Uri.parse('http://localhost:5001/cardsContaintsSet/$setID'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (ravenResponse.statusCode == 200) {
      if (int.parse(ravenResponse.body) == 0) return false;
    }
    return true;
  }
}
