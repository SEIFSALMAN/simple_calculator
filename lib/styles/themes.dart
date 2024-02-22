import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
    // useMaterial3: false,
    primaryColor: defaultDarkColor,
    brightness: Brightness.dark,


    appBarTheme: const AppBarTheme(
        shadowColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light
        ),
        backgroundColor: defaultDarkColor,
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        )
    ),
    cardColor: buttonsDarkColor,
    scaffoldBackgroundColor: Colors.grey.shade800,
    dialogBackgroundColor: Colors.grey.shade800,
    shadowColor: trigDarkColor,
    hintColor: Colors.white,

    textTheme: const TextTheme(
        bodyLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            fontFamily: 'PlaypenSans'

        ),
        bodyMedium: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'PlaypenSans'
        ),
    )
);

ThemeData lightTheme = ThemeData(
    // useMaterial3: false,
    primaryColor: defaultLightColor,
    brightness: Brightness.light,
    dialogBackgroundColor: Colors.white,
    cardColor: buttonsLightColor,
    shadowColor: trigLightColor,

    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        titleSpacing: 20.0,
        color: defaultLightColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        elevation:0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
           // fontWeight: FontWeight.bold
        )
    ),
    textTheme:  const TextTheme(
        bodyLarge: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
        ),
        bodyMedium: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w200,
            color: Colors.black,
            fontFamily: 'PlaypenSans'
        ),
    )
);