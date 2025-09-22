import 'package:flutter/material.dart';

final darktheme = ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(225, 31, 31, 31),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 85, 4, 4),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 20,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          labelSmall: TextStyle(
            color: Color.fromARGB(255, 255, 250, 205),
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
      );