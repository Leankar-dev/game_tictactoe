import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../domain/enums/player_type.dart';

class AnimatedCellWidget extends StatefulWidget {
  final PlayerType player;
  final bool isWinningCell;
  final bool isEnabled;
  final VoidCallback? onTap;
  final double size;
  final bool shouldAnimate;

  const AnimatedCellWidget({
    super.key,
    required this.player,
    this.isWinningCell = false,
    this.isEnabled = true,
    this.onTap,
    this.size = AppDimensions.cellSizeClassic,
    this.shouldAnimate = true,
  });

  @override
  State<AnimatedCellWidget> createState() => _AnimatedCellWidgetState();
}

class _AnimatedCellWidgetState extends State<AnimatedCellWidget>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _entryController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.elasticOut),
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.player != PlayerType.none && widget.shouldAnimate) {
      _entryController.forward();
    }

    if (widget.isWinningCell) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AnimatedCellWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.player == PlayerType.none &&
        widget.player != PlayerType.none &&
        widget.shouldAnimate) {
      _entryController.reset();
      _entryController.forward();
    }

    if (widget.isWinningCell && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isWinningCell && _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled && widget.player == PlayerType.none
          ? widget.onTap
          : null,
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _pulseAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isWinningCell ? _pulseAnimation.value : 1.0,
            child: Neumorphic(
              style: _getCellStyle(),
              child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: Center(child: _buildContent()),
              ),
            ),
          );
        },
      ),
    );
  }

  NeumorphicStyle _getCellStyle() {
    if (widget.isWinningCell) {
      return NeumorphicStyle(
        depth: 6,
        intensity: 0.7,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        color: AppColors.success.withValues(alpha: 0.2),
      );
    }

    return NeumorphicStyle(
      depth: widget.player == PlayerType.none ? -4 : 2,
      intensity: widget.player == PlayerType.none ? 0.8 : 0.5,
      boxShape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(AppDimensions.radiusSmall),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.player == PlayerType.none) {
      return const SizedBox.shrink();
    }

    final color = widget.isWinningCell
        ? AppColors.success
        : (widget.player == PlayerType.x
              ? AppColors.playerX
              : AppColors.playerO);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Text(
        widget.player.symbol,
        style: TextStyle(
          fontSize: widget.size * 0.5,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
