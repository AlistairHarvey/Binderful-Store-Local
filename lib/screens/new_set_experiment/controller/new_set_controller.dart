import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewSetController extends ChangeNotifier {
  int currentScreen = 1;
  String setName = '';
  String era = 'Scarlet & Violet';
  double setNumber = 4;
  String productName = '';
  bool isSpecailSet = false;
  int etbCount = 1;
  int checkLaneCount = 2;
  int triplePackCount = 2;
  List<String> etbVariantNames = [];
  List<String> checklaneVariantNames = [];
  List<String> triplePackVariantNames = [];
  List<String> boosterBoxImageURLS = [];
  String emailText = '';

  final productsList = <String>[];

  void changeScreen(int i) {
    currentScreen = i;
    notifyListeners();
  }

  void setSpecailSet({required bool v}) {
    isSpecailSet = v;
    notifyListeners();
  }

  void setSetName(String name) {
    setName = name;
    notifyListeners();
  }

  void setProductsList() {
    //Booster Boxes
    final titleLeading = 'PRE-ORDER: Pokemon - $era $setNumber - $setName -';
    productsList.add('$titleLeading Booster Box (36 Boosters)');

    //ETBS
    if (etbCount == 1) {
      productsList.add('$titleLeading Elite Trainer Box');
    } else {
      for (final product in etbVariantNames) {
        productsList.add('$titleLeading Elite Trainer Box ($product)');
      }
    }

    //Checklanes
    if (checkLaneCount == 1) {
      productsList.add('$titleLeading Premium Checklane Blister');
    } else {
      for (final product in checklaneVariantNames) {
        productsList.add('$titleLeading Premium Checklane Blister - $product');
      }
    }

    //Triple Packs
    if (triplePackCount == 1) {
      productsList.add('$titleLeading 3-Pack Booster');
    } else {
      for (final product in triplePackVariantNames) {
        productsList.add('$titleLeading 3-Pack Booster - $product');
      }
    }
  }

  void addBoosterBoxImageURL(String url) {
    boosterBoxImageURLS.add(url);
    notifyListeners();
  }

  Future<void> setEmailText(String v) async {
    emailText = v;

    final parts = v.split(
      RegExp(
        '<div style=3D"text-align: center;">'
        '<span style=3D"font-size:18px"><strong>',
      ),
    );
    parts.removeAt(0);

    final newProduct = <String>[];

    for (final part in parts) {
      final position = part.indexOf('Deadline to Order');
      debugPrint(position.toString());
      newProduct.add(part.substring(0, position));
    }

    for (final part in newProduct) {
      debugPrint('\n-----------------------\n-----------------------');

      final emailDataCleanedUp = part.replaceAll(RegExp('<[^>]*>'), '');

      var decodedString = Uri.decodeComponent(emailDataCleanedUp);
      decodedString = decodedString.replaceAll('&amp;', '&');
      decodedString = decodedString.replaceAll('&nbsp;', ' ');
      decodedString = decodedString.replaceAll('Pok=C3=A9mon', 'Pokemon');
      decodedString = decodedString.replaceAll('=\n', '');
      decodedString = decodedString.replaceAll('=E2=80=A2', '.');
      decodedString = decodedString.replaceAll('=C2=A3', '£');

      final lines = decodedString.split('\n');
      lines.removeWhere((e) => e.isEmpty);
      lines.removeWhere((e) => e == ' ');

      for (final line in lines) {
        debugPrint(line);
      }

      for (var i = 1; i < 10; i++) {
        final uri = Uri.parse(
          'https://www.asmodee.co.uk/cdn/shop/files/${lines[2]}_$i.jpg',
        );
        final result = await http.get(uri);
        debugPrint(result.statusCode.toString());
        if (result.statusCode == 200) {
          debugPrint(uri.toString());
        } else {
          break;
        }
      }
    }
  }
}

class ProductInfoFromEmail {
  ProductInfoFromEmail(
    this.title,
    this.body,
    this.code,
    this.trade,
    this.caseQuantity,
    this.release,
    this.images,
  );

  String? title;
  String? body;
  String? code;
  String? trade;
  String? caseQuantity;
  String? release;
  List<String>? images;
}
