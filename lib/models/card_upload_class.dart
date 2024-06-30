import 'package:binderful_store/models/card_class.dart';

//Model used to pass to the Excel Document to upload. 

class CardUploadClass extends Pokemon {
  CardUploadClass({
    required this.price,
    required this.condition,
    required this.quantity,
    required super.id,
    required super.name,
    required super.supertype,
    required super.subtypes,
    required super.hp,
    required super.types,
    required super.evolvesTo,
    required super.rules,
    required super.attacks,
    required super.weaknesses,
    required super.retreatCost,
    required super.convertedRetreatCost,
    required super.set,
    required super.number,
    required super.artist,
    required super.rarity,
    required super.nationalPokedexNumbers,
    required super.legalities,
    required super.images,
    required super.tcgplayer,
  });

  factory CardUploadClass.fromPokemon(
    double price,
    String condition,
    int quantity,
    Pokemon pokemon,
  ) =>
      CardUploadClass(
        price: price,
        condition: condition,
        quantity: quantity,
        id: pokemon.id,
        name: pokemon.name,
        supertype: pokemon.supertype,
        subtypes: pokemon.subtypes,
        hp: pokemon.hp,
        types: pokemon.types,
        evolvesTo: pokemon.evolvesTo,
        rules: pokemon.rules,
        attacks: pokemon.attacks,
        weaknesses: pokemon.weaknesses,
        retreatCost: pokemon.retreatCost,
        convertedRetreatCost: pokemon.convertedRetreatCost,
        set: pokemon.set,
        number: pokemon.number,
        artist: pokemon.artist,
        rarity: pokemon.rarity,
        nationalPokedexNumbers: pokemon.nationalPokedexNumbers,
        legalities: pokemon.legalities,
        images: pokemon.images,
        tcgplayer: pokemon.tcgplayer,
      );

  double price;
  String condition;
  int quantity;
}
