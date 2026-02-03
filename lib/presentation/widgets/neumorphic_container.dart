import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../../core/constants/app_dimensions.dart';

class NeumorphicContainerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double borderRadius;
  final double depth;
  final double intensity;
  final Color? color;
  final BoxShape shape;

  const NeumorphicContainerWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius = AppDimensions.radiusMedium,
    this.depth = 6,
    this.intensity = 0.5,
    this.color,
    this.shape = BoxShape.rectangle,
  });

  factory NeumorphicContainerWidget.circle({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsetsGeometry? margin,
    double? size,
    double depth = 6,
    Color? color,
  }) {
    return NeumorphicContainerWidget(
      key: key,
      padding: padding,
      margin: margin,
      width: size,
      height: size,
      depth: depth,
      color: color,
      shape: BoxShape.circle,
      child: child,
    );
  }

  factory NeumorphicContainerWidget.pill({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double height = 40,
    double depth = 6,
    Color? color,
  }) {
    return NeumorphicContainerWidget(
      key: key,
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing16,
            vertical: AppDimensions.spacing8,
          ),
      margin: margin,
      width: width,
      height: height,
      borderRadius: height / 2,
      depth: depth,
      color: color,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Neumorphic(
        style: _getStyle(context),
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }

  NeumorphicStyle _getStyle(BuildContext context) {
    final baseColor = color ?? NeumorphicTheme.baseColor(context);

    if (shape == BoxShape.circle) {
      return NeumorphicStyle(
        depth: depth,
        intensity: intensity,
        boxShape: const NeumorphicBoxShape.circle(),
        color: baseColor,
      );
    }

    return NeumorphicStyle(
      depth: depth,
      intensity: intensity,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(borderRadius),
      ),
      color: baseColor,
    );
  }
}

class NeumorphicProgressContainer extends StatelessWidget {
  final double progress;
  final double height;
  final Color? progressColor;
  final Color? backgroundColor;

  const NeumorphicProgressContainer({
    super.key,
    required this.progress,
    this.height = 12,
    this.progressColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -4,
        intensity: 0.8,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(height / 2),
        ),
      ),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: progressColor ?? Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NeumorphicToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;

  const NeumorphicToggle({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: NeumorphicSwitch(
        value: value,
        onChanged: onChanged,
        style: NeumorphicSwitchStyle(
          activeTrackColor: activeColor ?? Theme.of(context).primaryColor,
          inactiveTrackColor: NeumorphicTheme.baseColor(context),
        ),
      ),
    );
  }
}
