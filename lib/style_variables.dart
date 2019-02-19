import 'package:flutter/material.dart';

class StylingVariables {
  static MaterialColor get mainColor => Colors.green;
  static MaterialColor get secondaryColor => Colors.deepOrange;
  static Color get lightgreyBgColor => const Color.fromRGBO(0, 0, 0, 0.10);

  static TextStyle get labelStyle => TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0);
  static TextStyle get smallLabelStyle => TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0);

  static Color get redMeatColor => Colors.red[500];
  static Color get poultryColor => Colors.orange[500];
  static Color get seafoodColor => Colors.blue[500];
  static Color get vegetarianColor => Colors.teal[500];
  static Color get veganColor => Colors.green[500];
}