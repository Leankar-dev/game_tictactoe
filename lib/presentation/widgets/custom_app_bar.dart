import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final double height;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.height = kToolbarHeight + 16,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing8,
        ),
        child: Row(
          children: [
            if (leading != null)
              leading!
            else if (showBackButton && Navigator.of(context).canPop())
              _buildBackButton(context),
            if (centerTitle) const Spacer(),
            if (titleWidget != null)
              titleWidget!
            else if (title != null)
              _buildTitle(context),
            if (centerTitle) const Spacer(),
            if (actions != null) ...actions!,
            if (!showBackButton &&
                !Navigator.of(context).canPop() &&
                centerTitle)
              const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return NeumorphicButton(
      onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      style: NeumorphicStyle(
        depth: 4,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(AppDimensions.radiusSmall),
        ),
      ),
      padding: const EdgeInsets.all(AppDimensions.spacing8),
      child: const Icon(
        Icons.arrow_back_ios_new,
        size: AppDimensions.iconMedium,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return NeumorphicText(
      title!,
      style: const NeumorphicStyle(
        depth: 2,
        color: AppColors.textPrimary,
      ),
      textStyle: NeumorphicTextStyle(
        fontSize: AppDimensions.fontXLarge,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const SimpleAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton && Navigator.of(context).canPop()
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
    );
  }
}

class AppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool isLoading;

  const AppBarAction({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: NeumorphicButton(
        onPressed: isLoading ? null : onPressed,
        style: NeumorphicStyle(
          depth: 4,
          intensity: 0.5,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(AppDimensions.radiusSmall),
          ),
        ),
        padding: const EdgeInsets.all(AppDimensions.spacing8),
        child: isLoading
            ? const SizedBox(
                width: AppDimensions.iconMedium,
                height: AppDimensions.iconMedium,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                icon,
                size: AppDimensions.iconMedium,
                color: AppColors.textPrimary,
              ),
      ),
    );
  }
}
