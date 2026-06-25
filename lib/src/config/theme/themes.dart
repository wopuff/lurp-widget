// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lurp/src/config/theme/build_theme.dart';
import 'package:lurp/src/config/theme/theme_values.dart';

// DARK
final ThemeData darkTheme = buildTheme(
  const ColorScheme.light(
    brightness: Brightness.dark,
    background: Color(0xFF0D0D0D),
    primary: ThemeValues.primary,
    onPrimary: ThemeValues.onPrimary,
    secondary: ThemeValues.secondary,
    onSecondary: ThemeValues.onSecondary,
    surface: Color(0xFF1A1A1A),
    surfaceBright: Color.fromARGB(255, 53, 53, 53),
    surfaceDim: Color.fromARGB(255, 20, 20, 20),
    onSurface: Color(0xFFA0A0A0),
    onSurfaceVariant: Color(0xFFCACACA),
    error: Color(0xFFFF270A),
    onError: Color(0xFFFFFFFF),
  ),
);

// LIGHT
final ThemeData lightTheme = buildTheme(
  const ColorScheme(
    brightness: Brightness.light,
    background: Color(0xFFF5F5F5),
    primary: ThemeValues.primary,
    onPrimary: ThemeValues.onPrimary,
    secondary: Color(0xFFCED8E7),
    onSecondary: Color(0xFF000000),
    surface: Color(0xFFE2E2E2),
    surfaceDim: Color(0xFFD4D4D4),
    onSurface: Color(0xFF363636),
    onSurfaceVariant: Color(0xFF222222),
    error: Color(0xFFFF270A),
    onError: Color(0xFFFFFFFF),
  ),
);

// COFFEE
final ThemeData coffeeTheme = buildTheme(
  const ColorScheme(
    brightness: Brightness.dark,
    background: Color(0xFF1A1714),
    primary: ThemeValues.primary,
    onPrimary: ThemeValues.onPrimary,
    secondary: Color(0xFF362c20),
    onSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFF2C2520),
    surfaceDim: Color(0xFF1F1A16),
    onSurface: Color(0xFFCEC7C1),
    onSurfaceVariant: Color(0xFFECE7E3),
    error: Color(0xFFFF270A),
    onError: Color(0xFFFFFFFF),
  ),
);
