import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xFFF1F3F8),
    appBarTheme: AppBarTheme(
      backgroundColor: const AppColors().white,

    ),
  );
}
