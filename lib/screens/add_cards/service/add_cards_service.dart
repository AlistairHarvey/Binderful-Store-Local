//TODO move any services to here.

import 'dart:convert';

import 'package:binderful_store/models/card_class.dart';
import 'package:binderful_store/models/pricing_history_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCardsService {
  Future<PricingHistoryModel?> getPrice(
    String cardNo,
    String setID,
  ) async {
    final response = await http.get(
      Uri.parse(
        'http://localhost:5027/api/Pokemon/PricingHistory/$setID-${cardNo.padLeft(3, '0')}',
      ),
    );

    debugPrint('binderful Response - ${response.body}');

    try {
      return PricingHistoryModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } catch (e) {
      debugPrint('Binderful API error - $e');
    }
    return null;
  }

  Future<List<Pokemon>> getCard(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://api.pokemontcg.io/v2/cards?$query',
      ),
    );
    if (response.statusCode != 200) {
      debugPrint('FAILED');
      return [];
    }

    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    return PokemonData.fromJson(jsonData).data;
  }
}
