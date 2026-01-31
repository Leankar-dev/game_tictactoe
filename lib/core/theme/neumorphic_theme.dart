import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../constants/app_colors.dart';

abstract class AppNeumorphicTheme {
  static NeumorphicThemeData get themeData => const NeumorphicThemeData(
    baseColor: AppColors.background,
    lightSource: LightSource.topLeft,
    depth: 8,
    intensity: 0.5,
    shadowLightColor: AppColors.shadowLight,
    shadowDarkColor: AppColors.shadowDark,
  );

  static NeumorphicThemeData get darkThemeData => const NeumorphicThemeData(
    baseColor: Color(0xFF2D2D2D),
    lightSource: LightSource.topLeft,
    depth: 8,
    intensity: 0.3,
    shadowLightColor: Color(0xFF3D3D3D),
    shadowDarkColor: Color(0xFF1D1D1D),
  );

  static NeumorphicStyle get flatStyle => NeumorphicStyle(
    depth: 0,
    intensity: 0,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
  );

  static NeumorphicStyle get concaveStyle => NeumorphicStyle(
    depth: -4,
    intensity: 0.7,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
  );

  static NeumorphicStyle get convexStyle => NeumorphicStyle(
    depth: 8,
    intensity: 0.5,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
  );

  static NeumorphicStyle get buttonStyle => NeumorphicStyle(
    depth: 6,
    intensity: 0.6,
    surfaceIntensity: 0.15,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
  );

  static NeumorphicStyle get buttonPressedStyle => NeumorphicStyle(
    depth: -4,
    intensity: 0.7,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
  );

  static NeumorphicStyle get cardStyle => NeumorphicStyle(
    depth: 8,
    intensity: 0.5,
    surfaceIntensity: 0.1,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
  );

  static NeumorphicStyle get cellStyle => NeumorphicStyle(
    depth: -4,
    intensity: 0.8,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
  );

  static NeumorphicStyle get cellActiveStyle => NeumorphicStyle(
    depth: 2,
    intensity: 0.5,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
  );

  static NeumorphicStyle circularStyle({double size = 48}) =>
      const NeumorphicStyle(
        depth: 6,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.circle(),
      );

  static NeumorphicStyle circularPressedStyle({double size = 48}) =>
      const NeumorphicStyle(
        depth: -4,
        intensity: 0.7,
        boxShape: NeumorphicBoxShape.circle(),
      );
}
