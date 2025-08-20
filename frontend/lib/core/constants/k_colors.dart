import 'package:flutter/material.dart';

/// App color constants following the dark theme design from Figma
class KColors {
  KColors._();

  // Primary Colors (Military/Defense theme)
  static const Color primary = Color(0xFF2E7D32); // Dark green
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF1B5E20);
  static const Color primaryVariant = Color(0xFF388E3C);

  // Secondary Colors (Accent)
  static const Color secondary = Color(0xFFFF9800); // Orange for energy/action
  static const Color secondaryLight = Color(0xFFFFB74D);
  static const Color secondaryDark = Color(0xFFE65100);

  // Background Colors (Dark theme)
  static const Color background = Color(0xFF121212); // Very dark gray
  static const Color backgroundLight = Color(0xFF1E1E1E); // Slightly lighter
  static const Color backgroundCard = Color(0xFF2C2C2C); // Card background
  static const Color backgroundSurface = Color(0xFF242424); // Surface background

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF); // White
  static const Color textSecondary = Color(0xFFB3B3B3); // Light gray
  static const Color textTertiary = Color(0xFF808080); // Medium gray
  static const Color textDisabled = Color(0xFF4D4D4D); // Dark gray
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White on primary
  static const Color textOnSecondary = Color(0xFF000000); // Black on secondary

  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color error = Color(0xFFF44336); // Red
  static const Color info = Color(0xFF2196F3); // Blue

  // Interactive Colors
  static const Color buttonPrimary = Color(0xFFFFFFFF); // White buttons
  static const Color buttonSecondary = Color(0xFF2C2C2C); // Dark buttons
  static const Color buttonText = Color(0xFF000000); // Black text on white buttons
  static const Color buttonTextSecondary = Color(0xFFFFFFFF); // White text on dark buttons

  // Border Colors
  static const Color border = Color(0xFF404040); // Medium gray
  static const Color borderLight = Color(0xFF606060); // Lighter gray
  static const Color borderDark = Color(0xFF2C2C2C); // Darker gray

  // Overlay Colors
  static const Color overlay = Color(0x80000000); // Semi-transparent black
  static const Color overlayLight = Color(0x40000000); // Light overlay
  static const Color overlayDark = Color(0xB3000000); // Dark overlay

  // Gradient Colors (for cards and backgrounds)
  static const List<Color> primaryGradient = [
    Color(0xFF2E7D32),
    Color(0xFF1B5E20),
  ];

  static const List<Color> cardGradient = [
    Color(0xFF2C2C2C),
    Color(0xFF1E1E1E),
  ];

  static const List<Color> overlayGradient = [
    Color(0x00000000), // Transparent
    Color(0x80000000), // Semi-transparent black
  ];

  // Special Colors
  static const Color streak = Color(0xFFFFD700); // Gold for streak icons
  static const Color bookmark = Color(0xFF2196F3); // Blue for bookmarks
  static const Color share = Color(0xFF4CAF50); // Green for share
  static const Color notification = Color(0xFFFF5722); // Red-orange for notifications

  // Swipeable Card Colors
  static const Color cardBackground = Color(0xFF1E1E1E);
  static const Color cardOverlay = Color(0x66000000);
  static const Color cardText = Color(0xFFFFFFFF);
  static const Color cardSubtext = Color(0xFFB3B3B3);

  // Bottom Navigation Colors
  static const Color bottomNavBackground = Color(0xFF1E1E1E);
  static const Color bottomNavSelected = Color(0xFFFFFFFF);
  static const Color bottomNavUnselected = Color(0xFF808080);

  // Input Field Colors
  static const Color inputBackground = Color(0xFF2C2C2C);
  static const Color inputBorder = Color(0xFF404040);
  static const Color inputFocusedBorder = Color(0xFFFFFFFF);
  static const Color inputText = Color(0xFFFFFFFF);
  static const Color inputHint = Color(0xFF808080);
}
