import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';

abstract class ThemeManager{

  static ThemeData getLightAppTheme(){
    return ThemeData(
      scaffoldBackgroundColor: ColorsManager.black,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: ColorsManager.transparent,
        foregroundColor: ColorsManager.white,
        centerTitle: true,
        actionsIconTheme: IconThemeData(
          size: 15
        ),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorsManager.black,
          statusBarIconBrightness: Brightness.light
        ),
      ),

    );
  }
}