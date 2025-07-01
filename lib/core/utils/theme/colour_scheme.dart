import 'package:flutter/material.dart';

class ColourScheme {
  static ColorScheme lightScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Colors.purple,
      onPrimary: Colors.white,
      secondary: Colors.purple.shade100,
      onSecondary: Colors.purple.shade300,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.red.shade400);
}
