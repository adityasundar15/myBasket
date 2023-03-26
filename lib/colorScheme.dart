import 'package:flutter/material.dart';

//The color scheme of the project, updating this should show
//changes throughout the shopping list, edit accordingly
class ColorOptions {
  static MaterialColor colorscheme =
      const MaterialColor(_colorschemePrimaryValue, <int, Color>{
    50: Color(0xFFE7E7E7),
    100: Color(0xFFC3C3C3),
    200: Color(0xFF9B9B9B),
    300: Color(0xFF727272),
    400: Color(0xFF545454),
    500: Color(_colorschemePrimaryValue),
    600: Color(0xFF303030),
    700: Color(0xFF292929),
    800: Color(0xFF222222),
    900: Color(0xFF161616),
  });
  static const int _colorschemePrimaryValue = 0xFF363636;

  static const MaterialColor colorschemeAccent =
      MaterialColor(_colorschemeAccentValue, <int, Color>{
    100: Color(0xFFEF6F6F),
    200: Color(_colorschemeAccentValue),
    400: Color(0xFFF80000),
    700: Color(0xFFDF0000),
  });
  static const int _colorschemeAccentValue = 0xFFEA4141;
}
