import 'package:flutter/material.dart';

//The color scheme of the project, updating this should show
//changes throughout the shopping list, edit accordingly
class ColorOptions {
  static const MaterialColor colorscheme =
      MaterialColor(_colorschemePrimaryValue, <int, Color>{
    50: Color(0xFFE4F0E4),
    100: Color(0xFFBAD8BC),
    200: Color(0xFF8DBF90),
    300: Color(0xFF5FA564),
    400: Color(0xFF3C9142),
    500: Color(_colorschemePrimaryValue),
    600: Color(0xFF17761D),
    700: Color(0xFF136B18),
    800: Color(0xFF0F6114),
    900: Color(0xFF084E0B),
  });
  static const int _colorschemePrimaryValue = 0xFF1A7E21;

  static const MaterialColor colorschemeAccent =
      MaterialColor(_colorschemeAccentValue, <int, Color>{
    100: Color(0xFF83FF87),
    200: Color(_colorschemeAccentValue),
    400: Color(0xFF1DFF24),
    700: Color(0xFF03FF0C),
  });
  static const int _colorschemeAccentValue = 0xFF50FF56;
}
