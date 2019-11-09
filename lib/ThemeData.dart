import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData buildThemeData() {

  return ThemeData(

    brightness: Brightness.light,
    primaryColor: Colors.teal,
    accentColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textSelectionHandleColor: Colors.black,
    textSelectionColor: Colors.black12,
    cursorColor: Colors.black,
    toggleableActiveColor: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.white30,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
ThemeData buildThemeDataDark() {

  return ThemeData(

    brightness: Brightness.light,
    primaryColor: Colors.teal,
    accentColor: Colors.black12,
    scaffoldBackgroundColor: Colors.black,
    textSelectionHandleColor: Colors.white10,
    textSelectionColor: Colors.black12,
    cursorColor: Colors.white,
    toggleableActiveColor: Colors.black26,
    iconTheme: new IconThemeData(
        color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.white30,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      ),
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
const SystemUiOverlayStyle lightSystemUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.black,
  systemNavigationBarColor: Colors.black,
  systemNavigationBarDividerColor: Colors.black,
  systemNavigationBarIconBrightness: Brightness.dark,
);