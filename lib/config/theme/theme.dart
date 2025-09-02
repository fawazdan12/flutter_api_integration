import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import 'widgets/app_bar_theme.dart';
import 'widgets/icon_theme.dart';
import 'widgets/text_field_theme.dart';
import 'widgets/text_theme.dart';
import 'widgets/elevated_button_theme.dart';
import 'widgets/outlined_button_theme.dart';

//----------------------------------------------------------------------------
// Theme Provider
//----------------------------------------------------------------------------

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    
    // Utiliser Future.microtask pour retarder légèrement la mise à jour du systemOverlayStyle
    Future.microtask(() {
      SystemChrome.setSystemUIOverlayStyle(
        state == ThemeMode.light 
          ? const SystemUiOverlayStyle(
              statusBarColor: AppColors.appBarColorLight,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            )
          : const SystemUiOverlayStyle(
              statusBarColor: AppColors.appBarColorDark,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
      );
    });
  }
}

//----------------------------------------------------------------------------
// Theme Data
//----------------------------------------------------------------------------

class TAppTheme {
  TAppTheme._();

  static ThemeData lightThemeData(BuildContext context) {

    //--------------------------------------------------------------------------
    // Light Theme 
    //--------------------------------------------------------------------------
    return ThemeData.light().copyWith(
      primaryColor: AppColors.primaryColorLight,
      primaryColorLight: AppColors.secondaryColorLight,
      scaffoldBackgroundColor: AppColors.backgroundColorLight,
      appBarTheme: TAppBarTheme.lightThemeAppBarTheme,
      iconTheme: TIconTheme.lightThemeIconTheme,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightThemeDecorationTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColorLight,
        onPrimary: AppColors.backgroundColorLight,
        primaryContainer: AppColors.primaryColorLight,
        onPrimaryContainer: AppColors.tertiaryColorLight,
        secondary: AppColors.secondaryColorLight,
        secondaryContainer: AppColors.secondaryColorLight,
        onSecondaryContainer: AppColors.tertiaryColorLight,
        surface: AppColors.surfaceColorLight,
        onSurface: AppColors.onSurfaceColorLight,
        error: Colors.red,
        onError: AppColors.backgroundColorLight,
      ),
    );
  }

  //--------------------------------------------------------------------------
  // Dark Theme 
  //--------------------------------------------------------------------------
  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryColorDark,
      primaryColorLight: AppColors.secondaryColorDark,
      scaffoldBackgroundColor: AppColors.backgroundColorDark,
      appBarTheme: TAppBarTheme.darkThemeAppBarTheme,
      iconTheme: TIconTheme.darkThemeIconTheme,
      textTheme: TTextTheme.darkTextTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkThemeDecorationTheme,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryColorDark,
        onPrimary: AppColors.backgroundColorDark,
        primaryContainer: AppColors.primaryColorDark,
        onPrimaryContainer: AppColors.tertiaryColorDark,
        secondary: AppColors.secondaryColorDark,
        secondaryContainer: AppColors.secondaryColorDark,
        onSecondaryContainer: AppColors.tertiaryColorDark,
        surface: AppColors.surfaceColorDark,
        onSurface: AppColors.onSurfaceColorDark,
        error: Colors.red,
        onError: AppColors.backgroundColorDark,
      ),
    );
  }
}