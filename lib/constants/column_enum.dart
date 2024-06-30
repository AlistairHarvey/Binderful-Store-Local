import 'package:binderful_store/models/card_upload_class.dart';
import 'package:binderful_store/screens/add_cards/widgets/view_upload_list.dart';
import 'package:flutter/material.dart';

enum ColumnTitle {
  set,
  cardNo,
  cardName,
  price,
  quantity,
}

extension GetColumnTitle on ColumnTitle {
  String get title {
    switch (this) {
      case ColumnTitle.set:
        return 'Set';
      case ColumnTitle.cardNo:
        return 'Card No';
      case ColumnTitle.cardName:
        return 'Card Name';
      case ColumnTitle.price:
        return 'Price';
      case ColumnTitle.quantity:
        return 'Quantity';
    }
  }

  Widget field(CardUploadClass pokemon) {
    switch (this) {
      case ColumnTitle.set:
        return Text(
          pokemon.set.name,
          textAlign: TextAlign.start,
        );
      case ColumnTitle.cardNo:
        return Text(
          '${pokemon.number}/${pokemon.set.printedTotal}',
          textAlign: TextAlign.start,
        );
      case ColumnTitle.cardName:
        return Text(
          pokemon.name,
          textAlign: TextAlign.start,
        );
      case ColumnTitle.price:
        return EditableTextField(
          title: '£${pokemon.price}',
          pokemon: pokemon,
          isQunatity: false,
        );
      case ColumnTitle.quantity:
        return EditableTextField(
          title: pokemon.quantity.toString(),
          pokemon: pokemon,
          isQunatity: true,
        );
    }
  }
}
