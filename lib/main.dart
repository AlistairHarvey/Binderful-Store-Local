import 'package:binderful_store/core/core_app.dart';
import 'package:binderful_store/core/functions/init_core_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initCoreApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BinderfulStoreCoreApp();
  }
}
