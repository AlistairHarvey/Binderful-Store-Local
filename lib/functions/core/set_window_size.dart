import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

Future<void> setWindowSize() async {
  await DesktopWindow.setMinWindowSize(const Size(850, 700));
  await DesktopWindow.setMaxWindowSize(const Size(850, 700));
  await DesktopWindow.setWindowSize(const Size(850, 700));
}
