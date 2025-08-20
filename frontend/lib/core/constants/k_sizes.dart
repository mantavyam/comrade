/// Design system constants for consistent sizing across the app
class KSizes {
  KSizes._();

  // Base unit (4px)
  static const double _baseUnit = 4.0;

  // Margins and Padding
  static const double margin1x = _baseUnit; // 4px
  static const double margin2x = _baseUnit * 2; // 8px
  static const double margin3x = _baseUnit * 3; // 12px
  static const double margin4x = _baseUnit * 4; // 16px
  static const double margin6x = _baseUnit * 6; // 24px
  static const double margin8x = _baseUnit * 8; // 32px
  static const double margin12x = _baseUnit * 12; // 48px
  static const double margin16x = _baseUnit * 16; // 64px

  // Padding (same as margins for consistency)
  static const double padding1x = margin1x;
  static const double padding2x = margin2x;
  static const double padding3x = margin3x;
  static const double padding4x = margin4x;
  static const double padding6x = margin6x;
  static const double padding8x = margin8x;
  static const double padding12x = margin12x;
  static const double padding16x = margin16x;

  // Font Sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 20.0;
  static const double fontSizeXXXL = 24.0;
  static const double fontSizeTitle = 28.0;
  static const double fontSizeHeading = 32.0;
  static const double fontSizeLargeHeading = 40.0;

  // Border Radius
  static const double radiusXS = 2.0;
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 20.0;
  static const double radiusDefault = radiusM;
  static const double radiusCard = radiusL;
  static const double radiusButton = radiusM;

  // Icon Sizes
  static const double iconXS = 12.0;
  static const double iconS = 16.0;
  static const double iconM = 20.0;
  static const double iconL = 24.0;
  static const double iconXL = 32.0;
  static const double iconXXL = 40.0;
  static const double iconXXXL = 48.0;

  // Component Sizes
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightLarge = 56.0;
  static const double inputHeight = 48.0;
  static const double cardMinHeight = 120.0;
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 60.0;
  static const double tabBarHeight = 48.0;

  // Swipeable Card Sizes (for news cards)
  static const double cardWidth = 320.0;
  static const double cardHeight = 480.0;
  static const double cardImageHeight = 280.0;
  static const double cardContentHeight = 200.0;

  // Avatar Sizes
  static const double avatarS = 24.0;
  static const double avatarM = 32.0;
  static const double avatarL = 48.0;
  static const double avatarXL = 64.0;
  static const double avatarXXL = 96.0;

  // Elevation
  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationVeryHigh = 16.0;

  // Animation Durations (in milliseconds)
  static const int animationFast = 200;
  static const int animationMedium = 300;
  static const int animationSlow = 500;
  static const int animationVerySlow = 800;

  // Screen Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
}
