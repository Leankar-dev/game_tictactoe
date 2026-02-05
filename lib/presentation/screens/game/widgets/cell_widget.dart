import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../domain/enums/player_type.dart';

class CellWidget extends StatefulWidget {
  final PlayerType player;
  final bool isWinningCell;
  final bool isEnabled;
  final VoidCallback? onTap;
  final double size;
  final bool animate;

  const CellWidget({
    super.key,
    required this.player,
    this.isWinningCell = false,
    this.isEnabled = true,
    this.onTap,
    this.size = AppDimensions.cellSizeClassic,
    this.animate = true,
  });

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: AppDimensions.animationNormal),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    if (widget.player != PlayerType.none && widget.animate) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(CellWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.player == PlayerType.none &&
        widget.player != PlayerType.none &&
        widget.animate) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled && widget.player == PlayerType.none
          ? widget.onTap
          : null,
      child: Neumorphic(
        style: _getCellStyle(),
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: Center(child: _buildCellContent()),
        ),
      ),
    );
  }

  NeumorphicStyle _getCellStyle() {
    if (widget.isWinningCell) {
      return NeumorphicStyle(
        depth: 4,
        intensity: 0.6,
        surfaceIntensity: 0.2,
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

  Widget _buildCellContent() {
    if (widget.player == PlayerType.none) {
      return const SizedBox.shrink();
    }

    Widget symbol;
    if (widget.player == PlayerType.x) {
      symbol = _XSymbol(
        size: widget.size * 0.5,
        color: widget.isWinningCell ? AppColors.success : AppColors.playerX,
      );
    } else {
      symbol = _OSymbol(
        size: widget.size * 0.5,
        color: widget.isWinningCell ? AppColors.success : AppColors.playerO,
      );
    }

    if (widget.animate) {
      return ScaleTransition(scale: _scaleAnimation, child: symbol);
    }

    return symbol;
  }
}

class _XSymbol extends StatelessWidget {
  final double size;
  final Color color;

  const _XSymbol({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _XPainter(color: color),
    );
  }
}

class _XPainter extends CustomPainter {
  final Color color;

  _XPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final padding = size.width * 0.1;

    canvas.drawLine(
      Offset(padding, padding),
      Offset(size.width - padding, size.height - padding),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(padding, size.height - padding),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _XPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _OSymbol extends StatelessWidget {
  final double size;
  final Color color;

  const _OSymbol({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _OPainter(color: color),
    );
  }
}

class _OPainter extends CustomPainter {
  final Color color;

  _OPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (size.width * 0.1);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _OPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
