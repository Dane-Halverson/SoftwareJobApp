import 'package:flutter/material.dart';

const _primary = Color.fromRGBO(114, 176, 29, 1.0);
const _secondary = Color.fromRGBO(63, 125, 32, 1.0);
const _accent = Color.fromRGBO(43, 80, 170, 1.0);
const _black = Color.fromRGBO(13, 10, 11, 1.0);
const _grey = Color.fromRGBO(69, 73, 85, 0.25);
const _darkSurface = Color.fromRGBO(18, 18, 18, 1.0);
const _darkBackground = Color.fromRGBO(25, 25, 28, 1);

const lightContainerDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
  boxShadow: <BoxShadow> [
    BoxShadow(color: _grey, blurRadius: 10.0, spreadRadius: 3.0)
  ]
);

final lightTheme = ThemeData(
  fontFamily: 'Poppins',
  splashColor:  _primary,
  iconTheme: const IconThemeData(
    color: _accent,
    size: 48.0
  ),
  shadowColor: Color.fromRGBO(69, 73, 85, 1.0),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.w200,
      letterSpacing: 0.7
    ),
    titleLarge: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 15.0,
      letterSpacing: 0.2
    ),
    labelLarge: TextStyle(
      fontSize: 18.0,
      letterSpacing: 0.5,
      fontWeight: FontWeight.bold
    ),
  ),
  colorScheme: const ColorScheme(
    background: Color.fromRGBO(243, 239, 245, 1.0),
    onBackground: _black,
    brightness: Brightness.light,
    primary: _primary,
    secondary: _secondary,
    error: Color.fromRGBO(255, 133, 141, 1.0),
    onError: Colors.black,
    surface: Colors.white,
    onSurface: _black,
    onSecondary: Colors.white,
    shadow: _grey,
    onPrimary: Colors.white,
    onPrimaryContainer: _black,
    primaryContainer: Colors.white
  )
);

const darkContainerDecoration = BoxDecoration(
    color: _darkBackground,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    boxShadow: <BoxShadow> [
      BoxShadow(color: _black, blurRadius: 10.0, spreadRadius: 3.0)
    ]
);



final darkTheme = ThemeData(
    fontFamily: 'Poppins',
    splashColor:  _primary,
    iconTheme: const IconThemeData(
        color: _accent,
        size: 48.0
    ),
    shadowColor: _black,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.w200,
          letterSpacing: 0.7
      ),
      titleLarge: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
          fontSize: 15.0,
          letterSpacing: 0.2
      ),
      labelLarge: TextStyle(
          fontSize: 18.0,
          letterSpacing: 0.5,
          fontWeight: FontWeight.bold
      ),
    ),
    colorScheme: const ColorScheme(
      background: _darkBackground,
      onBackground: Colors.white,
      brightness: Brightness.dark,
      primary: _primary,
      secondary: _secondary,
      error: Color.fromRGBO(255, 133, 141, 1.0),
      onError: Colors.white,
      surface: _darkSurface,
      onSurface: Colors.white,
      onSecondary: Colors.white,
      onPrimary: Colors.white,
    )
);