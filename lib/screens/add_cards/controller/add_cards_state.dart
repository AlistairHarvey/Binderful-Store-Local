import 'package:binderful_store/models/card_class.dart';
import 'package:binderful_store/models/card_upload_class.dart';
import 'package:binderful_store/models/pricing_history_model.dart';
import 'package:flutter/material.dart';

class AddCardState {
  int currentPageIndex = 0;
  List<Pokemon> results = [];
  String? pokemonImage;
  String? title;
  String? set;
  PricingHistoryModel? price;
  final TextEditingController cardNoController = TextEditingController();
  final TextEditingController setTotalNoController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final List<CardUploadClass> savedCards = <CardUploadClass>[];
  bool loading = false;
  bool isViewAll = false;
  double total = 0;
}
