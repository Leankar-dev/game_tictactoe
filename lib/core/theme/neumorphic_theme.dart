import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../constants/app_colors.dart';

/// Neumorphic theme configuration for the application.
/// Provides consistent Neumorphic styling across all widgets.
abstract class AppNeumorphicTheme {
  /// Base theme data for the entire application
  static NeumorphicThemeData get themeData => const NeumorphicThemeData(
        baseColor: AppColors.background,
        lightSource: LightSource.topLeft,
        depth: 8,
        intensity: 0.5,
        shadowLightColor: AppColors.shadowLight,
        shadowDarkColor: AppColors.shadowDark,
      );

  /// Dark theme data (for future implementation)
  static NeumorphicThemeData get darkThemeData => const NeumorphicThemeData(
        baseColor: Color(0xFF2D2D2D),
        lightSource: LightSource.topLeft,
        depth: 8,
        intensity: 0.3,
        shadowLightColor: Color(0xFF3D3D3D),
        shadowDarkColor: Color(0xFF1D1D1D),
      );

  /// Style for flat containers (no elevation)
  static NeumorphicStyle get flatStyle => NeumorphicStyle(
        depth: 0,
        intensity: 0,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      );

  /// Style for concave (pressed) elements
  static NeumorphicStyle get concaveStyle => NeumorphicStyle(
        depth: -4,
        intensity: 0.7,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      );

  /// Style for convex (raised) elements
  static NeumorphicStyle get convexStyle => NeumorphicStyle(
        depth: 8,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      );

  /// Style for buttons
  static NeumorphicStyle get buttonStyle => NeumorphicStyle(
        depth: 6,
        intensity: 0.6,
        surfaceIntensity: 0.15,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      );

  /// Style for pressed buttons
  static NeumorphicStyle get buttonPressedStyle => NeumorphicStyle(
        depth: -4,
        intensity: 0.7,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      );

  /// Style for cards
  static NeumorphicStyle get cardStyle => NeumorphicStyle(
        depth: 8,
        intensity: 0.5,
        surfaceIntensity: 0.1,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(16),
        ),
      );

  /// Style for board cells
  static NeumorphicStyle get cellStyle => NeumorphicStyle(
        depth: -4,
        intensity: 0.8,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(8),
        ),
      );

  /// Style for active/selected cells
  static NeumorphicStyle get cellActiveStyle => NeumorphicStyle(
        depth: 2,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(8),
        ),
      );

  /// Style for circular elements (like player indicators)
  static NeumorphicStyle circularStyle({double size = 48}) =>
      const NeumorphicStyle(
        depth: 6,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.circle(),
      );

  /// Style for circular pressed elements
  static NeumorphicStyle circularPressedStyle({double size = 48}) =>
      const NeumorphicStyle(
        depth: -4,
        intensity: 0.7,
        boxShape: NeumorphicBoxShape.circle(),
      );
}
