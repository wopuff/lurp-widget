import 'dart:ui';

extension DimColor on Color {
  Color dim([double factor = 0.7]) {
    return Color.from(
      alpha: a,
      red: (r * factor).clamp(0.0, 1.0),
      green: (g * factor).clamp(0.0, 1.0),
      blue: (b * factor).clamp(0.0, 1.0),
    );
  }
}
