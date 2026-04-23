import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App theme definitions using Material 3 and FlexColorScheme.
class AppTheme {
  AppTheme._();

  static ThemeData lightTheme() {
    return FlexThemeData.light(
      scheme: FlexScheme.mandyRed,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        adaptiveSplash: FlexAdaptive.all(),
        splashType: FlexSplashType.inkSparkle,
        defaultRadius: 12.0,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        toggleButtonsBorderSchemeColor: SchemeColor.primary,
        segmentedButtonSchemeColor: SchemeColor.primary,
        switchSchemeColor: SchemeColor.primary,
        checkboxSchemeColor: SchemeColor.primary,
        radioSchemeColor: SchemeColor.primary,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorBackgroundAlpha: 15,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 12.0,
        inputDecoratorUnfocusedHasBorder: false,
        fabUseShape: true,
        fabAlwaysCircular: true,
        chipSchemeColor: SchemeColor.primary,
        cardRadius: 16.0,
        popupMenuRadius: 10.0,
        popupMenuElevation: 3.0,
        alignedDropdown: true,
        appBarScrolledUnderElevation: 0.5,
        drawerWidth: 304.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
    );
  }

  static ThemeData darkTheme() {
    return FlexThemeData.dark(
      scheme: FlexScheme.mandyRed,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        adaptiveSplash: FlexAdaptive.all(),
        splashType: FlexSplashType.inkSparkle,
        defaultRadius: 12.0,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        toggleButtonsBorderSchemeColor: SchemeColor.primary,
        segmentedButtonSchemeColor: SchemeColor.primary,
        switchSchemeColor: SchemeColor.primary,
        checkboxSchemeColor: SchemeColor.primary,
        radioSchemeColor: SchemeColor.primary,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorBackgroundAlpha: 22,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 12.0,
        inputDecoratorUnfocusedHasBorder: false,
        fabUseShape: true,
        fabAlwaysCircular: true,
        chipSchemeColor: SchemeColor.primary,
        cardRadius: 16.0,
        popupMenuRadius: 10.0,
        popupMenuElevation: 3.0,
        alignedDropdown: true,
        appBarScrolledUnderElevation: 0.5,
        drawerWidth: 304.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
    );
  }
}
