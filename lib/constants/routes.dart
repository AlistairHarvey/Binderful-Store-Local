import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const home = '/';
  static const addCards = '/add';
  static const newSet = '/newSet';
  static const updateSets = '/updateSets';
  static const updatePrices = '/updatePrices';
  static const profitCalc = '/profitCalc';
}

class RouteNames {
  static const home = 'home';
  static const addCards = 'add';
  static const newSet = 'newSet';
  static const updateSets = 'updateSets';
  static const updatePrices = 'updatePrices';
  static const profitCalc = 'profitCalc';
}

extension RouteNavigation on String {
  void pushNamed(BuildContext context) {
    context.pushNamed(this);
  }
}
