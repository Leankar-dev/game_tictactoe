import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../../core/constants/app_dimensions.dart';

class NeumorphicCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double depth;
  final double? width;
  final double? height;
  final NeumorphicCardVariant variant;

  const NeumorphicCardWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = AppDimensions.radiusLarge,
    this.depth = 8,
    this.width,
    this.height,
    this.variant = NeumorphicCardVariant.convex,
  });

  factory NeumorphicCardWidget.convex({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
  }) {
    return NeumorphicCardWidget(
      key: key,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      variant: NeumorphicCardVariant.convex,
      child: child,
    );
  }

  factory NeumorphicCardWidget.concave({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
  }) {
    return NeumorphicCardWidget(
      key: key,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      depth: -4,
      variant: NeumorphicCardVariant.concave,
      child: child,
    );
  }

  factory NeumorphicCardWidget.flat({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
  }) {
    return NeumorphicCardWidget(
      key: key,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      depth: 0,
      variant: NeumorphicCardVariant.flat,
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
        style: _getStyle(),
        padding: padding ?? const EdgeInsets.all(AppDimensions.spacing16),
        child: child,
      ),
    );
  }

  NeumorphicStyle _getStyle() {
    switch (variant) {
      case NeumorphicCardVariant.convex:
        return NeumorphicStyle(
          depth: depth,
          intensity: 0.5,
          surfaceIntensity: 0.1,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(borderRadius),
          ),
        );
      case NeumorphicCardVariant.concave:
        return NeumorphicStyle(
          depth: depth,
          intensity: 0.7,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(borderRadius),
          ),
        );
      case NeumorphicCardVariant.flat:
        return NeumorphicStyle(
          depth: 0,
          intensity: 0,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(borderRadius),
          ),
        );
    }
  }
}

enum NeumorphicCardVariant { convex, concave, flat }

class StatisticCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? valueColor;

  const StatisticCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicCardWidget(
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppDimensions.iconLarge,
              color: valueColor ?? Theme.of(context).primaryColor,
            ),
            const SizedBox(height: AppDimensions.spacing8),
          ],
          Text(
            value,
            style: TextStyle(
              fontSize: AppDimensions.fontXXLarge,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            label,
            style: TextStyle(
              fontSize: AppDimensions.fontSmall,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
