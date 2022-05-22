import 'package:flutter/material.dart';
import 'package:shop/src/utils/constante.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  focusColor: Colors.black,
  backgroundColor: const Color(0xFEFEFEFE),
  cardColor: const Color(0xFFF5F6F9),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(foregroundColor: Colors.white),
  dividerColor: Colors.grey.shade200,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Monstserrat",
  appBarTheme: appBarThemeLight(),
  textTheme: textTheme(),
  inputDecorationTheme: inputDecorationTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      .copyWith(secondary: Colors.black),
);

ThemeData darkTheme = ThemeData(
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  focusColor: Colors.white,
  backgroundColor: const Color(0xFF0E0E0E),
  cardColor: const Color(0xFF21202B),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(foregroundColor: kTextDarkColor),
  dividerColor: Colors.grey.shade900,
  scaffoldBackgroundColor: const Color(0xFF121212),
  fontFamily: "Monstserrat",
  appBarTheme: appBarThemeDark(),
  textTheme: textTheme(),
  inputDecorationTheme: inputDecorationTheme(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      .copyWith(secondary: Colors.white, brightness: Brightness.dark),
);

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide.none,
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: kDefaultPadding,
      vertical: kDefaultPadding,
    ),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    errorStyle: const TextStyle(
      height: 0,
      fontSize: 0,
      color: Colors.transparent,
    ),
    filled: true,
    fillColor: const Color(0xFFF5F6F9),
    labelStyle: const TextStyle(color: kTextColor),
    hintStyle: const TextStyle(color: kTextColor),
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarThemeLight() {
  return const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    color: Colors.white,
    iconTheme: IconThemeData(color: kTextDarkColor),
    titleTextStyle: TextStyle(
      color: kTextColor,
      fontSize: 18,
    ),
  );
}

AppBarTheme appBarThemeDark() {
  return const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    color: Color(0xFF121212),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: kTextColor,
      fontSize: 18,
    ),
  );
}
