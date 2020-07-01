import 'package:flutter/material.dart';

/// Responsible of changing between dark and light modes.
class CustomThemeMode {
  static final light = ThemeData(
      primaryColor: Colors.deepOrangeAccent,
      accentColor: Colors.white,
      cursorColor: Colors.deepOrangeAccent,
      canvasColor: Colors.amber.shade50,
      buttonColor: Colors.black54,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.deepOrangeAccent,
      fontFamily: 'Roboto',
      textTheme: TextTheme(

          /// For last message.
          headline5: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          headline1: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Colors.white, fontSize: 16),

          /// For Contacts names
          headline4: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 14),

          /// Bigger Contacts name
          headline6: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 16),

          /// For drawer
          headline2: TextStyle(color: Colors.black54, fontSize: 18),
          button: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 18,
          )));

  static final dark = ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.white,
      cursorColor: Colors.blue,
      canvasColor: Colors.indigo.shade50,
      buttonColor: Colors.black54,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Roboto',
      textTheme: TextTheme(

          /// For last message.
          headline5: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          headline1: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Colors.black, fontSize: 16),

          /// For Contacts names
          headline4: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 14),

          /// Bigger Contacts name
          headline6: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 16),

          /// For drawer
          headline2: TextStyle(color: Colors.black54, fontSize: 18),
          button: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 18,
          )));
}
