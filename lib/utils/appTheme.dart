import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';

class AppThemeData {
  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldLightColor,
      primaryColor: AppColors.appColorPrimary,
      errorColor: Colors.red,
      hoverColor: Colors.white,
      fontFamily: GoogleFonts.openSans(color: AppColors.appTextColorPrimary).fontFamily,
      appBarTheme: const AppBarTheme(
          color: AppColors.appLayoutBackground,
          iconTheme: IconThemeData(color: AppColors.appTextColorPrimary),
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: AppColors.appColorPrimary)),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.appTextColorPrimary),
    iconTheme: const IconThemeData(color: AppColors.iconColorPrimary),
    textTheme: const TextTheme(
      button: TextStyle(color: AppColors.appColorPrimary),
      headline6: TextStyle(color: AppColors.appTextColorPrimary, fontSize: AppConstants.textSizeMedium, fontWeight: FontWeight.bold),
      subtitle2: TextStyle(color: AppColors.appTextColorSecondary),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: const ColorScheme.light(primary: AppColors.appColorPrimary, primaryContainer: AppColors.appColorPrimary).copyWith(secondary: Colors.grey)
  );
}
