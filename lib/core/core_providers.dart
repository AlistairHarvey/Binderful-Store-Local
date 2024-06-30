import 'package:binderful_store/screens/add_cards/controller/extended_controller.dart';
import 'package:binderful_store/screens/new_set_experiment/controller/new_set_controller.dart';
import 'package:binderful_store/screens/update_sets/update_set_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BinderfulStoreCoreProviders extends StatelessWidget {
  const BinderfulStoreCoreProviders({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExtendedAddCardController>.value(
          value: ExtendedAddCardController(),
        ),
        ChangeNotifierProvider<NewSetController>.value(
          value: NewSetController(),
        ),
        ChangeNotifierProvider<UpdateSetController>.value(
          value: UpdateSetController(),
        ),
      ],
      child: child,
    );
  }
}
