import 'package:binderful_store/constants/routes.dart';
import 'package:binderful_store/screens/add_cards/add_cards_screen.dart';
import 'package:binderful_store/screens/homepage/home.dart';
import 'package:binderful_store/screens/new_set_experiment/new_set_screen.dart';
import 'package:binderful_store/screens/update_prices/update_prices_screen.dart';
import 'package:binderful_store/screens/update_sets/update_sets_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.home,
      name: RouteNames.home,
      builder: (context, state) {
        return const DefaultTabController(
          length: 3,
          child: HomePage(),
        );
      },
    ),
    GoRoute(
      path: Routes.addCards,
      name: RouteNames.addCards,
      builder: (context, state) {
        return const AddCardsScreen();
      },
    ),
    GoRoute(
      path: Routes.newSet,
      name: RouteNames.newSet,
      builder: (context, state) {
        return const AddNewSetScreen();
      },
    ),
    GoRoute(
      path: Routes.updateSets,
      name: RouteNames.updateSets,
      builder: (context, state) {
        return const UpdateSetsScreen();
      },
    ),
    GoRoute(
      path: Routes.updatePrices,
      name: RouteNames.updatePrices,
      builder: (context, state) {
        return const UpdatePricesScreen();
      },
    ),
  ],
);
