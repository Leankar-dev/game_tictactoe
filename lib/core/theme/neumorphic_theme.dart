import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

abstract class AppNeumorphicTheme {
  static NeumorphicThemeData get themeData => const NeumorphicThemeData(
    baseColor: AppColors.background,
    lightSource: LightSource.topLeft,
    depth: AppDimensions.neumorphicDepthDefault,
    intensity: AppDimensions.neumorphicIntensityDefault,
    shadowLightColor: AppColors.shadowLight,
    shadowDarkColor: AppColors.shadowDark,
  );

  static NeumorphicThemeData get darkThemeData => const NeumorphicThemeData(
    baseColor: AppColors.backgroundDarkTheme,
    lightSource: LightSource.topLeft,
    depth: AppDimensions.neumorphicDepthDefault,
    intensity: AppDimensions.neumorphicIntensityLight,
    shadowLightColor: AppColors.shadowLightDark,
    shadowDarkColor: AppColors.shadowDarkDark,
  );

  static NeumorphicStyle get flatStyle => NeumorphicStyle(
    depth: AppDimensions.neumorphicDepthNone,
    intensity: AppDimensions.neumorphicIntensityNone,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(AppDimensions.radiusMedium),
    ),
  );

  static NeumorphicStyle get concaveStyle => NeumorphicStyle(
    depth: AppDimensions.neumorphicDepthPressed,
    intensity: AppDimensions.neumorphicIntensityPressed,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(AppDimensions.radiusMedium),
    ),
  );

  static NeumorphicStyle get convexStyle => NeumorphicStyle(
    depth: AppDimensions.neumorphicDepthDefault,
    intensity: AppDimensions.neumorphicIntensityDefault,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(AppDimensions.radiusMedium),
    ),
  );

  static NeumorphicStyle get buttonStyle => NeumorphicStyle(
    depth: AppDimensions.neumorphicDepthButton,
    intensity: AppDimensions.neumorphicIntensityButton,
    surfaceIntensity: AppDimensions.neumorphicSurfaceButton,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(AppDimensions.radiusMedium),
    ),
  );

  static NeumorphicStyle get buttonPressedStyle => NeumorphicStyle(
    depth: AppDimensions.neumorphicDepthPressed,
    intensity: AppDimensions.neumorphicIntensityPressed,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(AppDimensions.radiusMedium),
    ),
  );

  static NeumorphicStyle get cardStyle => NeumorphicStyle(
    depth: AppDimensions.neumorphicDepthDefault,
    intensity: AppDimensions.neumorphicIntensityDefault,
    surfaceIntensity: AppDimensions.neumorphicSurfaceCard,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(AppDimensions.radiusLarge),
    ),
  );

  static NeumorphicStyle get cellStyle => NeumorphicStyle(
    depth: AppDimensions.neumorphicDepthPressed,
    intensity: AppDimensions.neumorphicIntensityHigh,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(AppDimensions.radiusSmall),
    ),
  );

  static NeumorphicStyle get cellActiveStyle => NeumorphicStyle(
    depth: AppDimensions.neumorphicDepthSubtle,
    intensity: AppDimensions.neumorphicIntensityDefault,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(AppDimensions.radiusSmall),
    ),
  );

  static NeumorphicStyle circularStyle({double size = 48}) =>
      const NeumorphicStyle(
        depth: AppDimensions.neumorphicDepthButton,
        intensity: AppDimensions.neumorphicIntensityDefault,
        boxShape: NeumorphicBoxShape.circle(),
      );

  static NeumorphicStyle circularPressedStyle({double size = 48}) =>
      const NeumorphicStyle(
        depth: AppDimensions.neumorphicDepthPressed,
        intensity: AppDimensions.neumorphicIntensityPressed,
        boxShape: NeumorphicBoxShape.circle(),
      );
}
