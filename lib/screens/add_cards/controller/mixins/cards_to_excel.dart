// ignore_for_file: missing_whitespace_between_adjacent_strings, no_adjacent_strings_in_list, lines_longer_than_80_chars

import 'dart:io';

import 'package:binderful_store/models/card_upload_class.dart';
import 'package:binderful_store/screens/add_cards/controller/add_cards_controller.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

mixin CardsToExcel on AddCardController {
  Future<String> export() async {
    try {
      // Get the directory where you can save files
      final directory = await getApplicationDocumentsDirectory();

      final fileName = 'singles-${DateTime.now().toString().substring(0, 10)}.csv';

      final path =
          '${directory.path}/$fileName';

      final file = File(
        path,
      );

      // Convert the CSV data to a CSV string
      final csvString = exportCSV();

      // Write the CSV string to the file
      await file.writeAsString(csvString);

      // Show a success message or perform any other actions
      debugPrint('CSV data exported successfully to ${file.path}');
      return fileName;
    } catch (e) {
      debugPrint('Error exporting CSV data: $e');
      return '';
    }
  }

  String exportCSV() {
    final headers = <String>[
      'Handle',
      'Title',
      'Body (HTML)',
      'Vendor',
      'Product Category',
      'Type',
      'Tags',
      'Published',
      'Option1 Name',
      'Option1 Value',
      'Option2 Name',
      'Option2 Value',
      'Option3 Name',
      'Option3 Value',
      'Variant SKU',
      'Variant Grams',
      'Variant Inventory Tracker',
      'Variant Inventory Qty',
      'Variant Inventory Policy',
      'Variant Fulfillment Service',
      'Variant Price',
      'Variant Compare At Price',
      'Variant Requires Shipping',
      'Variant Taxable',
      'Variant Barcode',
      'Image Src',
      'Image Position',
      'Image Alt Text',
      'Gift Card',
      'SEO Title',
      'SEO Description',
      'Google Shopping / Google Product Category',
      'Google Shopping / Gender,Google Shopping / Age Group',
      'Google Shopping / MPN,Google Shopping / AdWords Grouping',
      'Google Shopping / AdWords Labels',
      'Google Shopping / Condition',
      'Google Shopping / Custom Product',
      'Google Shopping / Custom Label 0',
      'Google Shopping / Custom Label 1',
      'Google Shopping / Custom Label 2',
      'Google Shopping / Custom Label 3',
      'Google Shopping / Custom Label 4',
      'Variant Image',
      'Variant Weight Unit',
      'Variant Tax Code',
      'Cost per item',
      'Price / International',
      'Compare At Price / International',
      'Status',
    ];
    final data = <List<String>>[
      headers,
    ];
    for (final pokemon in state.savedCards) {
      data.add(pokemonToProduct(pokemon));
    }
    final csvData = const ListToCsvConverter().convert(data);
    return csvData;
  }

  List<String> pokemonToProduct(CardUploadClass pokemon) {
    final setTag = pokemon.set.id.toUpperCase();

    final isReverse = state.isReverseHoloMode;

    return [
      'pokemon-singles-${pokemon.set.name}-${pokemon.name}${pokemon.number}/${pokemon.set.printedTotal}${isReverse ? '/ReverseHolo' : ''}',
      'Pokemon Singles - ${pokemon.set.name} - ${pokemon.name} ${pokemon.number}/${pokemon.set.printedTotal}${isReverse ? ' (Reverse Holo)' : ''}',
      '<p>Pokemon Singles - ${pokemon.set.name} - ${pokemon.name} ${pokemon.number}/${pokemon.set.printedTotal}${isReverse ? ' (Reverse Holo)' : ''}.</p>'
          '<p> </p>'
          '<p>Pack fresh straight to sleeve. </p>'
          '<p> </p>'
          '<p>This card is in pack fresh condition (unless stated otherwise) and will be sent to you in a protective sleeve and a toploader. </p>',
      'Binderful',
      'Arts & Entertainment > Hobbies & Creative Arts > Collectibles > Collectible Trading Cards',
      'Pokemon TCG',
      'Singles, $setTag Singles, ${pokemon.rarity}, ${isReverse ? 'Reverse Holo' : ''}',
      'TRUE',
      'Title',
      'Default Title',
      '',
      '',
      '',
      '',
      '${pokemon.set.id.toUpperCase()}${pokemon.number}/${pokemon.set.printedTotal}',
      '25',
      'shopify',
      '${pokemon.quantity}',
      'deny',
      'manual',
      '${pokemon.price}',
      '',
      'TRUE',
      'TRUE',
      '',
      pokemon.images.large,
      '1',
      '',
      'FALSE',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      'g',
      '',
      '',
      '',
      '',
      'active',
    ];
  }
}
