import 'package:binderful_store/core/core_providers.dart';
import 'package:binderful_store/core/routing.dart';
import 'package:binderful_store/core/theme.dart';
import 'package:flutter/material.dart';

class BinderfulStoreCoreApp extends StatelessWidget {
  const BinderfulStoreCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BinderfulStoreCoreProviders(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: BinderfulThemeData.lightTheme(),
        darkTheme: BinderfulThemeData.darkTheme(),
      ),
    );
  }
}
