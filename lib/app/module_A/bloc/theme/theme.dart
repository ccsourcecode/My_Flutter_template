import 'package:flutter/material.dart';

class AppThemeData {
  static const Color oil1Color = Color(0xFFFBF5EF);
static const Color oil2Color = Color(0xFFF2D3AB);
static const Color oil3Color = Color(0xFFC69FA5);
static const Color oil4Color = Color(0xFF8B6D9C);
static const Color oil5Color = Color(0xFF494D7E);
static const Color oil6Color = Color(0xFF272744);


  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: oil6Color,
    primaryColor: oil1Color,
    primaryColorDark: oil2Color,
    primaryColorLight: oil5Color,
    shadowColor: oil2Color,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 80.0,
        color: oil2Color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    backgroundColor: oil2Color,
    primaryColor: oil1Color,
    primaryColorDark: oil2Color,
    primaryColorLight: oil5Color,
    shadowColor: oil5Color,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 80.0,
        color: oil5Color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
