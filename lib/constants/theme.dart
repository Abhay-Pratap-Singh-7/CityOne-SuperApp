import 'package:flutter/material.dart';

class CityOneTheme {
  // ===========================================================================
  // 1. SPACING & LAYOUT CONSTANTS
  // ===========================================================================
  static const double spacingBase = 8.0;
  static const double spacingStackGap = 12.0;
  static const double spacingGutter = 16.0;
  static const double spacingContainerPadding = 16.0;
  static const double spacingSectionMargin = 24.0;

  // ===========================================================================
  // 2. BORDER RADIUS CONSTANTS
  // ===========================================================================
  static const double radiusSm = 4.0;   // 0.25rem
  static const double radiusDefault = 8.0; // 0.5rem
  static const double radiusMd = 12.0;  // 0.75rem
  static const double radiusLg = 16.0;  // 1rem
  static const double radiusXl = 24.0;  // 1.5rem
  static const double radiusFull = 9999.0; // Pill-shape

  // ===========================================================================
  // 3. COLOR SCHEME
  // ===========================================================================
  static const ColorScheme _colorScheme = ColorScheme(
    brightness: Brightness.light,
    
    // Primary (Vibrant Yellow / Darker accents)
    primary: Color(0xFF775A00),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFF9C123), // Vibrant Yellow CTA
    onPrimaryContainer: Color(0xFF6B5000),
    
    // Secondary 
    secondary: Color(0xFF5E5E5E),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE2E2E2),
    onSecondaryContainer: Color(0xFF646464),
    
    // Tertiary
    tertiary: Color(0xFF5F5E5E),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFCBC9C9),
    onTertiaryContainer: Color(0xFF555454),
    
    // Error
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF93000A),
    
    // Surface
    surface: Color(0xFFF9F9F9),
    onSurface: Color(0xFF1A1C1C),
    onSurfaceVariant: Color(0xFF4F4633),
    
    // Outlines & Inverses
    outline: Color(0xFF817660),
    outlineVariant: Color(0xFFD3C5AC),
    inverseSurface: Color(0xFF2F3131),
    onInverseSurface: Color(0xFFF1F1F1),
    inversePrimary: Color(0xFFF6BE1F),
  );

  // Additional brand colors not perfectly mapped to standard ColorScheme
  static const Color solidBlack = Color(0xFF000000);
  static const Color cleanWhite = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color cardBorder = Color(0xFFEEEEEE);

  // ===========================================================================
  // 4. TYPOGRAPHY
  // ===========================================================================
  static const String _fontFamily = 'Inter';

  static const TextTheme _textTheme = TextTheme(
    // headline-lg
    displayLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32.0,
      fontWeight: FontWeight.w800,
      height: 40.0 / 32.0,
      letterSpacing: -0.02 * 32.0, // -0.02em
      color: solidBlack,
    ),
    // headline-lg-mobile
    displayMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 26.0,
      fontWeight: FontWeight.w800,
      height: 32.0 / 26.0,
      letterSpacing: -0.02 * 26.0,
      color: solidBlack,
    ),
    // headline-md
    displaySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      height: 28.0 / 20.0,
      color: solidBlack,
    ),
    // body-lg
    bodyLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 24.0 / 16.0,
      color: solidBlack,
    ),
    // body-sm
    bodyMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 20.0 / 14.0,
      color: solidBlack,
    ),
    // label-bold
    labelLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
      height: 16.0 / 12.0,
      color: solidBlack,
    ),
    // label-sm
    labelMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      height: 14.0 / 11.0,
      color: solidBlack,
    ),
  );

  // ===========================================================================
  // 5. THEME DATA ASSEMBLY
  // ===========================================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: cleanWhite,
      textTheme: _textTheme,
      
      // -- BUTTONS --
      // Primary Buttons: Large, pill-shaped, Yellow background, Black text.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _colorScheme.primaryContainer,
          foregroundColor: solidBlack,
          elevation: 0, // Flat 2.0 aesthetic
          minimumSize: const Size.fromHeight(56), // Minimum touch target + one-handed thumb use
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
          shape: const StadiumBorder(), // Pill-shaped
        ),
      ),
      
      // Secondary Buttons: Pill-shaped, 2px Black stroke, Transparent background.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: solidBlack,
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: solidBlack, width: 2.0),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
          shape: const StadiumBorder(), // Pill-shaped
        ),
      ),

      // -- INPUT FIELDS --
      // 8px rounded corners, light grey border. Focus: 2px solid black.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cleanWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: Color(0xFF5E5E5E), fontFamily: _fontFamily),
        floatingLabelStyle: const TextStyle(color: solidBlack, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: const BorderSide(color: cardBorder, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: const BorderSide(color: cardBorder, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: const BorderSide(color: solidBlack, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusDefault),
          borderSide: BorderSide(color: _colorScheme.error, width: 2.0),
        ),
      ),

      // -- CARDS (Service Cards) --
      // White background, subtle 1px border, 16px radius, no elevation.
      cardTheme: CardThemeData(
        color: cleanWhite,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: const BorderSide(color: cardBorder, width: 1.0),
        ),
      ),

      // -- CHIPS (Status Indicators) --
      // Pill-shaped, black background, white text.
      chipTheme: const ChipThemeData(
        backgroundColor: solidBlack,
        labelStyle: TextStyle(
          fontFamily: _fontFamily,
          color: cleanWhite,
          fontWeight: FontWeight.w700,
          fontSize: 12.0,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        shape: StadiumBorder(),
        side: BorderSide.none,
      ),

      // -- BOTTOM NAVIGATION BAR --
      // High-stroke icons, primary yellow active state, no labels.
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cleanWhite,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: _colorScheme.primaryContainer, // Vibrant Yellow
        unselectedItemColor: solidBlack,
        selectedIconTheme: const IconThemeData(size: 28, weight: 600),
        unselectedIconTheme: const IconThemeData(size: 24, weight: 400),
      ),
      
      // -- APP BAR --
      // Flat aesthetic to match the rest of the app
      appBarTheme: const AppBarTheme(
        backgroundColor: cleanWhite,
        foregroundColor: solidBlack,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: solidBlack,
        ),
      ),
    );
  }
}