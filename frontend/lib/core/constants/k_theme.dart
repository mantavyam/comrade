import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'k_colors.dart';
import 'k_sizes.dart';

/// App theme configuration
class KTheme {
  KTheme._();

  /// Dark theme for the app (primary theme)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: KColors.primary,
        primaryContainer: KColors.primaryDark,
        secondary: KColors.secondary,
        secondaryContainer: KColors.secondaryDark,
        surface: KColors.backgroundSurface,
        error: KColors.error,
        onPrimary: KColors.textOnPrimary,
        onSecondary: KColors.textOnSecondary,
        onSurface: KColors.textPrimary,
        onError: KColors.textOnPrimary,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: KColors.background,
        foregroundColor: KColors.textPrimary,
        elevation: KSizes.elevationNone,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeXL,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: KColors.bottomNavBackground,
        selectedItemColor: KColors.bottomNavSelected,
        unselectedItemColor: KColors.bottomNavUnselected,
        type: BottomNavigationBarType.fixed,
        elevation: KSizes.elevationMedium,
        selectedLabelStyle: TextStyle(
          fontSize: KSizes.fontSizeS,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: KSizes.fontSizeS,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: KColors.backgroundCard,
        elevation: KSizes.elevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.radiusCard),
        ),
        margin: const EdgeInsets.all(KSizes.margin2x),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: KColors.buttonPrimary,
          foregroundColor: KColors.buttonText,
          elevation: KSizes.elevationLow,
          minimumSize: const Size(double.infinity, KSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KSizes.radiusButton),
          ),
          textStyle: const TextStyle(
            fontSize: KSizes.fontSizeL,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: KColors.primary,
          textStyle: const TextStyle(
            fontSize: KSizes.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: KColors.textPrimary,
          side: const BorderSide(color: KColors.border),
          minimumSize: const Size(double.infinity, KSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KSizes.radiusButton),
          ),
          textStyle: const TextStyle(
            fontSize: KSizes.fontSizeL,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KSizes.radiusButton),
          borderSide: const BorderSide(color: KColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KSizes.radiusButton),
          borderSide: const BorderSide(color: KColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KSizes.radiusButton),
          borderSide: const BorderSide(color: KColors.inputFocusedBorder, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KSizes.radiusButton),
          borderSide: const BorderSide(color: KColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: KSizes.padding4x,
          vertical: KSizes.padding3x,
        ),
        hintStyle: const TextStyle(
          color: KColors.inputHint,
          fontSize: KSizes.fontSizeM,
        ),
        labelStyle: const TextStyle(
          color: KColors.textSecondary,
          fontSize: KSizes.fontSizeM,
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeLargeHeading,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeHeading,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeTitle,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeXXXL,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeXXL,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeXL,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeL,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeM,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: KColors.textSecondary,
          fontSize: KSizes.fontSizeS,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeL,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeM,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: KColors.textSecondary,
          fontSize: KSizes.fontSizeS,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: KColors.textPrimary,
          fontSize: KSizes.fontSizeM,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: KColors.textSecondary,
          fontSize: KSizes.fontSizeS,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: KColors.textTertiary,
          fontSize: KSizes.fontSizeXS,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: KColors.textPrimary,
        size: KSizes.iconM,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: KColors.border,
        thickness: 1,
        space: KSizes.margin4x,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: KColors.background,
    );
  }
}
