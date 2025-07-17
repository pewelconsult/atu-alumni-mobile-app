// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ATUColors {
  // Primary ATU Branding Colors (Official)
  static const Color primaryBlue = Color(0xFF1F4A7D);
  static const Color primaryGold = Color(0xFFCDA73C);
  static const Color lightBlue = Color(0xFF3B82F6);
  static const Color darkBlue = Color(0xFF1E3A66);

  // Secondary Colors (Enhanced)
  static const Color lightGold = Color(0xFFFEF3C7);
  static const Color darkGold = Color(0xFFB8941F);
  static const Color accentBlue = Color(0xFF2563EB);
  static const Color softGold = Color(0xFFF3E8B3);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFCDA73C); // Using ATU gold for warnings
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF06B6D4);

  // Enhanced Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, lightBlue],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGold, darkGold],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [grey50, white],
  );

  // Brand Specific Gradients
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, primaryGold],
  );

  static const LinearGradient softBrandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1F4A7D), Color(0xFF2563EB), Color(0xFFCDA73C)],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF9FAFB)],
  );
}

class ATUTextStyles {
  static TextStyle get _baseTextStyle => GoogleFonts.inter();

  // Headings
  static TextStyle get h1 => _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: ATUColors.grey900,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle get h2 => _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: ATUColors.grey900,
    height: 1.25,
    letterSpacing: -0.3,
  );

  static TextStyle get h3 => _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: ATUColors.grey900,
    height: 1.3,
    letterSpacing: -0.2,
  );

  static TextStyle get h4 => _baseTextStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ATUColors.grey900,
    height: 1.4,
  );

  static TextStyle get h5 => _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ATUColors.grey900,
    height: 1.4,
  );

  static TextStyle get h6 => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ATUColors.grey900,
    height: 1.4,
  );

  // Body Text
  static TextStyle get bodyLarge => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: ATUColors.grey700,
    height: 1.5,
  );

  static TextStyle get bodyMedium => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ATUColors.grey700,
    height: 1.5,
  );

  static TextStyle get bodySmall => _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: ATUColors.grey600,
    height: 1.4,
  );

  // Special Styles
  static TextStyle get buttonText => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ATUColors.white,
    letterSpacing: 0.2,
  );

  static TextStyle get buttonTextSmall => _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ATUColors.white,
    letterSpacing: 0.1,
  );

  static TextStyle get caption => _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: ATUColors.grey500,
    height: 1.3,
  );

  static TextStyle get overline => _baseTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: ATUColors.grey500,
    letterSpacing: 1.5,
    height: 1.2,
  );

  // Brand Specific Styles
  static TextStyle get brandTitle => _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ATUColors.primaryBlue,
    letterSpacing: -0.2,
  );

  static TextStyle get brandSubtitle => _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ATUColors.primaryGold,
  );
}

class ATUTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ATUColors.primaryBlue,
        brightness: Brightness.light,
        primary: ATUColors.primaryBlue,
        onPrimary: ATUColors.white,
        secondary: ATUColors.primaryGold,
        onSecondary: ATUColors.white,
        tertiary: ATUColors.lightBlue,
        onTertiary: ATUColors.white,
        surface: ATUColors.white,
        onSurface: ATUColors.grey900,
        onSurfaceVariant: ATUColors.grey600,
        surfaceContainerLowest: ATUColors.white,
        surfaceContainerLow: ATUColors.grey50,
        surfaceContainer: ATUColors.grey100,
        surfaceContainerHigh: ATUColors.grey200,
        surfaceContainerHighest: ATUColors.grey300,
        error: ATUColors.error,
        onError: ATUColors.white,
        outline: ATUColors.grey300,
        outlineVariant: ATUColors.grey200,
        shadow: ATUColors.black,
        scrim: ATUColors.black,
        inverseSurface: ATUColors.grey900,
        onInverseSurface: ATUColors.grey50,
        inversePrimary: ATUColors.lightBlue,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: ATUColors.grey50,

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: ATUColors.primaryBlue,
        foregroundColor: ATUColors.white,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: ATUTextStyles.h4.copyWith(
          color: ATUColors.white,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: ATUColors.white, size: 24),
        actionsIconTheme: const IconThemeData(color: ATUColors.white, size: 24),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ATUColors.primaryBlue,
          foregroundColor: ATUColors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 2,
          shadowColor: ATUColors.primaryBlue.withValues(alpha: .3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: ATUTextStyles.buttonText,
        ),
      ),

      // Filled Button Theme (Material 3)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: ATUColors.primaryBlue,
          foregroundColor: ATUColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: ATUTextStyles.buttonText,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ATUColors.primaryBlue,
          side: const BorderSide(color: ATUColors.primaryBlue, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: ATUTextStyles.buttonText.copyWith(
            color: ATUColors.primaryBlue,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ATUColors.primaryGold,
          textStyle: ATUTextStyles.buttonText.copyWith(
            color: ATUColors.primaryGold,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: ATUColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: ATUColors.grey400.withValues(alpha: .2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ATUColors.grey50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.grey300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.grey300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ATUColors.error, width: 2),
        ),
        hintStyle: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey400),
        labelStyle: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey600),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ATUColors.white,
        selectedItemColor: ATUColors.primaryBlue,
        unselectedItemColor: ATUColors.grey400,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      ),

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: ATUColors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: ATUColors.primaryBlue.withValues(alpha: .1),
        elevation: 8,
        shadowColor: ATUColors.grey400.withValues(alpha: .1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ATUTextStyles.caption.copyWith(
              color: ATUColors.primaryBlue,
              fontWeight: FontWeight.w600,
            );
          }
          return ATUTextStyles.caption.copyWith(color: ATUColors.grey400);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: ATUColors.primaryBlue, size: 24);
          }
          return const IconThemeData(color: ATUColors.grey400, size: 24);
        }),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ATUColors.primaryGold,
        foregroundColor: ATUColors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        iconSize: 24,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: ATUColors.grey200,
        thickness: 1,
        space: 1,
      ),

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: ATUTextStyles.h1,
        headlineMedium: ATUTextStyles.h2,
        headlineSmall: ATUTextStyles.h3,
        titleLarge: ATUTextStyles.h4,
        titleMedium: ATUTextStyles.h5,
        titleSmall: ATUTextStyles.h6,
        bodyLarge: ATUTextStyles.bodyLarge,
        bodyMedium: ATUTextStyles.bodyMedium,
        bodySmall: ATUTextStyles.bodySmall,
        labelLarge: ATUTextStyles.buttonText,
        labelMedium: ATUTextStyles.buttonTextSmall,
        labelSmall: ATUTextStyles.caption,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: ATUColors.grey100,
        selectedColor: ATUColors.primaryBlue.withValues(alpha: .1),
        labelStyle: ATUTextStyles.bodySmall,
        side: const BorderSide(color: ATUColors.grey300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: ATUColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: ATUColors.grey400.withValues(alpha: .2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: ATUTextStyles.h4.copyWith(color: ATUColors.grey900),
        contentTextStyle: ATUTextStyles.bodyMedium.copyWith(
          color: ATUColors.grey600,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: ATUColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        shadowColor: ATUColors.grey400.withValues(alpha: .2),
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ATUColors.grey800,
        contentTextStyle: ATUTextStyles.bodyMedium.copyWith(
          color: ATUColors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        actionTextColor: ATUColors.primaryGold,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ATUColors.primaryBlue,
        linearTrackColor: ATUColors.grey200,
        circularTrackColor: ATUColors.grey200,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: ATUColors.primaryBlue,
        inactiveTrackColor: ATUColors.grey200,
        thumbColor: ATUColors.primaryBlue,
        overlayColor: ATUColors.primaryBlue.withValues(alpha: .1),
        valueIndicatorColor: ATUColors.primaryBlue,
        valueIndicatorTextStyle: ATUTextStyles.bodySmall.copyWith(
          color: ATUColors.white,
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ATUColors.primaryBlue;
          }
          return ATUColors.grey400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ATUColors.primaryBlue.withValues(alpha: .3);
          }
          return ATUColors.grey200;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ATUColors.primaryBlue;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(ATUColors.white),
        side: const BorderSide(color: ATUColors.grey400, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ATUColors.primaryBlue;
          }
          return ATUColors.grey400;
        }),
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarThemeData(
        labelColor: ATUColors.primaryBlue,
        unselectedLabelColor: ATUColors.grey400,
        indicatorColor: ATUColors.primaryGold,
        labelStyle: ATUTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: ATUTextStyles.bodyMedium,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: ATUColors.white,
        selectedTileColor: ATUColors.primaryBlue.withValues(alpha: .1),
        iconColor: ATUColors.grey600,
        textColor: ATUColors.grey900,
      ),
    );
  }

  // Dark theme for future use
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ATUColors.primaryBlue,
        brightness: Brightness.dark,
        primary: ATUColors.lightBlue,
        onPrimary: ATUColors.black,
        secondary: ATUColors.primaryGold,
        onSecondary: ATUColors.black,
        surface: ATUColors.grey900,
        onSurface: ATUColors.white,
        onSurfaceVariant: ATUColors.grey300,
        surfaceContainerLowest: ATUColors.black,
        surfaceContainerLow: ATUColors.grey900,
        surfaceContainer: ATUColors.grey800,
        surfaceContainerHigh: ATUColors.grey700,
        surfaceContainerHighest: ATUColors.grey600,
        error: ATUColors.error,
        onError: ATUColors.white,
        outline: ATUColors.grey600,
        outlineVariant: ATUColors.grey700,
      ),
      scaffoldBackgroundColor: ATUColors.grey900,

      appBarTheme: AppBarTheme(
        backgroundColor: ATUColors.grey900,
        foregroundColor: ATUColors.white,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: ATUTextStyles.h4.copyWith(
          color: ATUColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),

      cardTheme: CardThemeData(
        color: ATUColors.grey800,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: ATUColors.black.withValues(alpha: .3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

// Animation Durations
class ATUAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration extraSlow = Duration(milliseconds: 800);
}

// Spacing Constants
class ATUSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

// Border Radius Constants
class ATURadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double circular = 50.0;
}

// Shadow Presets
class ATUShadows {
  static List<BoxShadow> get soft => [
    BoxShadow(
      color: ATUColors.grey400.withValues(alpha: .1),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get medium => [
    BoxShadow(
      color: ATUColors.grey400.withValues(alpha: .15),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get strong => [
    BoxShadow(
      color: ATUColors.grey400.withValues(alpha: .2),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get brand => [
    BoxShadow(
      color: ATUColors.primaryBlue.withValues(alpha: .3),
      blurRadius: 15,
      offset: const Offset(0, 6),
    ),
  ];
}
