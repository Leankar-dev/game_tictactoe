import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/theme/neumorphic_theme.dart';

class NeumorphicButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? width;
  final double height;
  final bool isLoading;
  final bool isDisabled;
  final NeumorphicButtonVariant variant;
  final TextStyle? textStyle;
  final Color? iconColor;

  const NeumorphicButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.width,
    this.height = AppDimensions.buttonHeight,
    this.isLoading = false,
    this.isDisabled = false,
    this.variant = NeumorphicButtonVariant.primary,
    this.textStyle,
    this.iconColor,
  });

  factory NeumorphicButtonWidget.primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    IconData? icon,
    double? width,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return NeumorphicButtonWidget(
      key: key,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: NeumorphicButtonVariant.primary,
    );
  }

  factory NeumorphicButtonWidget.secondary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    IconData? icon,
    double? width,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return NeumorphicButtonWidget(
      key: key,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: NeumorphicButtonVariant.secondary,
    );
  }

  factory NeumorphicButtonWidget.danger({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    IconData? icon,
    double? width,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return NeumorphicButtonWidget(
      key: key,
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      isLoading: isLoading,
      isDisabled: isDisabled,
      variant: NeumorphicButtonVariant.danger,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && !isLoading && onPressed != null;

    return SizedBox(
      width: width,
      height: height,
      child: NeumorphicButton(
        onPressed: isEnabled ? onPressed : null,
        style: _getButtonStyle(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing8,
        ),
        child: _buildContent(context),
      ),
    );
  }

  NeumorphicStyle _getButtonStyle() {
    if (isDisabled) {
      return AppNeumorphicTheme.flatStyle;
    }

    return NeumorphicStyle(
      depth: 6,
      intensity: 0.6,
      surfaceIntensity: 0.15,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      color: _getBackgroundColor(),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case NeumorphicButtonVariant.primary:
        return AppColors.background;
      case NeumorphicButtonVariant.secondary:
        return AppColors.background;
      case NeumorphicButtonVariant.danger:
        return AppColors.background;
    }
  }

  Color _getTextColor() {
    if (isDisabled) return AppColors.textLight;

    switch (variant) {
      case NeumorphicButtonVariant.primary:
        return AppColors.accent;
      case NeumorphicButtonVariant.secondary:
        return AppColors.textPrimary;
      case NeumorphicButtonVariant.danger:
        return AppColors.error;
    }
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: AppDimensions.iconMedium,
        height: AppDimensions.iconMedium,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: _getTextColor(),
        ),
      );
    }

    final textWidget = Text(
      text,
      style: textStyle ??
          TextStyle(
            fontSize: AppDimensions.fontMedium,
            fontWeight: FontWeight.w600,
            color: _getTextColor(),
          ),
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: AppDimensions.iconMedium,
            color: iconColor ?? _getTextColor(),
          ),
          const SizedBox(width: AppDimensions.spacing8),
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}

enum NeumorphicButtonVariant {
  primary,
  secondary,
  danger,
}

class NeumorphicIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? iconColor;
  final bool isDisabled;

  const NeumorphicIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 48,
    this.iconColor,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: NeumorphicButton(
        onPressed: isDisabled ? null : onPressed,
        style: NeumorphicStyle(
          depth: isDisabled ? 0 : 6,
          intensity: 0.6,
          boxShape: const NeumorphicBoxShape.circle(),
        ),
        padding: EdgeInsets.zero,
        child: Icon(
          icon,
          size: size * 0.5,
          color: isDisabled
              ? AppColors.textLight
              : (iconColor ?? AppColors.textPrimary),
        ),
      ),
    );
  }
}
