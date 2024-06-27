import 'package:flutter/material.dart';

class AppTheme {
  static get light => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
      ).copyWith(
        brightness: Brightness.dark,
      ),
      fontFamily: 'Alexandria',
      splashFactory: InkRipple.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }));

  static get dark => ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Colors.deepPurple,
      ).copyWith(
        brightness: Brightness.dark,
      ),
      fontFamily: 'Alexandria',
      splashFactory: InkRipple.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }));
}
