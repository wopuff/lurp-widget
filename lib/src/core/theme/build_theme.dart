// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lurp/src/core/theme/theme_values.dart';
import 'package:lurp/src/core/utils/color_utils.dart';

ThemeData buildTheme(ColorScheme colors) {
  final normalFontWeight = colors.brightness == Brightness.dark
      ? FontWeight.w500
      : FontWeight.w600;
  final boldFontWeight = colors.brightness == Brightness.dark
      ? FontWeight.w600
      : FontWeight.w700;

  return ThemeData(
    colorScheme: colors,
    brightness: colors.brightness,
    visualDensity: ThemeValues.visualDensity,
    materialTapTargetSize: ThemeValues.materialTapTargetSize,
    primaryColor: colors.primary,
    fontFamily: ThemeValues.textFont,
    shadowColor: Colors.transparent,
    applyElevationOverlayColor: false,
    useMaterial3: true,
    scaffoldBackgroundColor: colors.background,
    cardColor: colors.surface,
    dividerColor: colors.onSurface,
    disabledColor: colors.onSurface,
    hintColor: colors.onSurface,
    iconTheme: IconThemeData(color: colors.onSurface),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: colors.onSurface,
        fontSize: ThemeValues.titleLarge,
        fontWeight: boldFontWeight,
      ),
      titleMedium: TextStyle(
        color: colors.onSurface,
        fontSize: ThemeValues.titleMedium,
        fontWeight: boldFontWeight,
      ),
      titleSmall: TextStyle(
        color: colors.onSurface,
        fontSize: ThemeValues.titleSmall,
        fontWeight: normalFontWeight,
      ),
      bodyLarge: TextStyle(
        color: colors.onSurface,
        fontSize: ThemeValues.bodyLarge,
        fontWeight: normalFontWeight,
      ),
      bodyMedium: TextStyle(
        color: colors.onSurface,
        fontSize: ThemeValues.bodyMedium,
        fontWeight: normalFontWeight,
      ),
      bodySmall: TextStyle(
        color: colors.onSurface,
        fontSize: ThemeValues.bodySmall,
        fontWeight: normalFontWeight,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colors.primary,
      selectionColor: colors.secondary,
      selectionHandleColor: colors.primary,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(colors.surfaceBright),
      radius: const Radius.circular(4),
      thickness: const WidgetStatePropertyAll(8),
      crossAxisMargin: 0,
      mainAxisMargin: 0,
      interactive: true,
      minThumbLength: 60,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.5),
        ),
        elevation: 0,
        backgroundColor: colors.secondary,
        foregroundColor: colors.onSecondary,
        shadowColor: Colors.transparent,
        surfaceTintColor: colors.background,
        iconColor: colors.onSurface,
        overlayColor: colors.onSurface,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.onSurface),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.onSurface),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.error),
      ),
      labelStyle: TextStyle(color: colors.onSurface),
      hintStyle: TextStyle(color: colors.onSurface),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
      elevation: 0,
      centerTitle: true,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colors.surface,
      indicatorColor: colors.primary.dim(0.12),
      labelTextStyle: WidgetStateProperty.all(
        TextStyle(color: colors.primary, fontSize: 12),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? colors.primary
            : colors.onSurface;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? colors.primary
            : colors.onSurface;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? colors.primary
            : colors.onSurface;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? colors.primary.dim(0.5)
            : colors.onSurface.dim(0.5);
      }),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colors.surface,
      contentTextStyle: TextStyle(color: colors.onSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: TextStyle(color: colors.onSurface),
    ),
  );
}
