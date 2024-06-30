import 'dart:convert';

import 'package:binderful_store/models/card_class.dart';

//Class for mapping to the DB model.

class CardRaven {
  CardRaven({
    required this.cardID,
    required this.name,
    required this.superType,
    required this.subtypes,
    required this.types,
    required this.evolvesTo,
    required this.setID,
    required this.number,
    required this.artist,
    required this.rarity,
    required this.nationalPokedexNumbers,
    required this.images,
    required this.pricingHistoryID,
    this.hp,
    this.level,
  });

  factory CardRaven.fromApiClass(Pokemon card) {
    return CardRaven(
      cardID: card.id,
      name: card.name,
      superType: card.supertype,
      subtypes: card.subtypes,
      types: card.types.isEmpty ? null : card.types,
      evolvesTo: card.evolvesTo.isEmpty ? null : card.evolvesTo,
      setID: card.set.id,
      number: card.number,
      artist: card.artist,
      rarity: card.rarity,
      nationalPokedexNumbers: card.nationalPokedexNumbers,
      images: [card.images.small, card.images.large],
      pricingHistoryID:
          '${card.id}${card.rarity.isNotEmpty ? '-${card.rarity}' : ''}',
    );
  }

  CardRaven.fromJson(Map<String, dynamic> json)
      : cardID = json['cardID'] as String,
        name = json['name'] as String,
        superType = json['superType'] as String,
        subtypes = (json['subtypes'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        level = json['level'] as String?,
        hp = json['hp'] as String?,
        types =
            (json['types'] as List<dynamic>).map((e) => e.toString()).toList(),
        evolvesTo = (json['evolvesTo'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        setID = json['setID'] as String,
        number = json['number'] as String,
        artist = json['artist'] as String,
        rarity = json['rarity'] as String,
        nationalPokedexNumbers =
            (json['nationalPokedexNumbers'] as List<dynamic>)
                .map((e) => int.parse(e.toString()))
                .toList(),
        images =
            (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
        pricingHistoryID = json['pricingHistoryID'] as String;

  String cardID;
  String name;
  String superType;
  List<String> subtypes;
  String? level;
  String? hp;
  List<String>? types;
  List<String>? evolvesTo;
  String setID;
  String number;
  String artist;
  String rarity;
  List<int> nationalPokedexNumbers;
  List<String> images;
  String pricingHistoryID;

  Map<String, dynamic> toJson() {
    return {
      'cardID': cardID,
      'name': name,
      'superType': superType,
      'subtypes': subtypes,
      'level': level,
      'hp': hp,
      'types': types,
      'evolvesTo': evolvesTo,
      'setID': setID,
      'number': number,
      'artist': artist,
      'rarity': rarity,
      'nationalPokedexNumbers': nationalPokedexNumbers,
      'images': images,
      'pricingHistoryID': pricingHistoryID,
    };
  }

  static List<Map<String, dynamic>> toJsonList(List<CardRaven> cards) {
    return cards.map((card) => card.toJson()).toList();
  }
}

List<CardRaven> readCardsFromJsonFile(String json) {
  final jsonList = jsonDecode(json) as List<dynamic>;

  // Convert JSON list to CardRaven instances
  final cardRavens = jsonList
      .map((json) => CardRaven.fromJson(json as Map<String, dynamic>))
      .toList();
  return cardRavens;
}
