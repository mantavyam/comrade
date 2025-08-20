import 'package:flutter/material.dart';

/// App color constants following the black and white theme
class KColors {
  KColors._();

  // Primary Colors (Black and White theme)
  static const Color primary = Color(0xFF000000); // Pure black
  static const Color primaryLight = Color(0xFF333333); // Dark gray
  static const Color primaryDark = Color(0xFF000000); // Pure black
  static const Color primaryVariant = Color(0xFF1A1A1A); // Very dark gray

  // Secondary Colors (Accent)
  static const Color secondary = Color(0xFFFFFFFF); // Pure white
  static const Color secondaryLight = Color(0xFFF5F5F5); // Light gray
  static const Color secondaryDark = Color(0xFFE0E0E0); // Medium light gray

  // Background Colors (Black and White theme)
  static const Color background = Color(0xFFFFFFFF); // Pure white
  static const Color backgroundLight = Color(0xFFFAFAFA); // Very light gray
  static const Color backgroundCard = Color(0xFFFFFFFF); // White card background
  static const Color backgroundSurface = Color(0xFFF8F8F8); // Light surface background

  // Text Colors
  static const Color textPrimary = Color(0xFF000000); // Black
  static const Color textSecondary = Color(0xFF666666); // Dark gray
  static const Color textTertiary = Color(0xFF999999); // Medium gray
  static const Color textDisabled = Color(0xFFCCCCCC); // Light gray
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White on black
  static const Color textOnSecondary = Color(0xFF000000); // Black on white

  // Status Colors
  static const Color success = Color(0xFF000000); // Black
  static const Color warning = Color(0xFF666666); // Dark gray
  static const Color error = Color(0xFF000000); // Black
  static const Color info = Color(0xFF333333); // Dark gray

  // Interactive Colors
  static const Color buttonPrimary = Color(0xFF000000); // Black buttons
  static const Color buttonSecondary = Color(0xFFFFFFFF); // White buttons
  static const Color buttonText = Color(0xFFFFFFFF); // White text on black buttons
  static const Color buttonTextSecondary = Color(0xFF000000); // Black text on white buttons

  // Border Colors
  static const Color border = Color(0xFFE0E0E0); // Light gray
  static const Color borderLight = Color(0xFFF0F0F0); // Very light gray
  static const Color borderDark = Color(0xFF000000); // Black

  // Overlay Colors
  static const Color overlay = Color(0x80000000); // Semi-transparent black
  static const Color overlayLight = Color(0x40000000); // Light overlay
  static const Color overlayDark = Color(0xB3000000); // Dark overlay

  // Gradient Colors (for cards and backgrounds)
  static const List<Color> primaryGradient = [
    Color(0xFF000000),
    Color(0xFF333333),
  ];

  static const List<Color> cardGradient = [
    Color(0xFFFFFFFF),
    Color(0xFFF8F8F8),
  ];

  static const List<Color> overlayGradient = [
    Color(0x00000000), // Transparent
    Color(0x80000000), // Semi-transparent black
  ];

  // Special Colors
  static const Color streak = Color(0xFF000000); // Black for streak icons
  static const Color bookmark = Color(0xFF000000); // Black for bookmarks
  static const Color share = Color(0xFF000000); // Black for share
  static const Color notification = Color(0xFF000000); // Black for notifications

  // Swipeable Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardOverlay = Color(0x66000000);
  static const Color cardText = Color(0xFF000000);
  static const Color cardSubtext = Color(0xFF666666);

  // Bottom Navigation Colors
  static const Color bottomNavBackground = Color(0xFFFFFFFF);
  static const Color bottomNavSelected = Color(0xFF000000);
  static const Color bottomNavUnselected = Color(0xFF999999);

  // Input Field Colors
  static const Color inputBackground = Color(0xFFFFFFFF);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocusedBorder = Color(0xFF000000);
  static const Color inputText = Color(0xFF000000);
  static const Color inputHint = Color(0xFF999999);
}
