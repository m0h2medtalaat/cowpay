import 'package:flutter/material.dart';

class ScreenSize {
  BuildContext? materialContext;
  static ScreenSize _instance = new ScreenSize.internal();

  ScreenSize.internal();

  factory ScreenSize() => _instance;

  double? height = 690, width = 360;
}
