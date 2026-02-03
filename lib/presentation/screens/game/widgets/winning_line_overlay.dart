import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class WinningLineOverlay extends StatefulWidget {
  final List<({int row, int col})> winningCells;
  final int gridSize;
  final double cellSize;
  final double spacing;
  final double padding;

  const WinningLineOverlay({
    super.key,
    required this.winningCells,
    required this.gridSize,
    required this.cellSize,
    required this.spacing,
    required this.padding,
  });

  @override
  State<WinningLineOverlay> createState() => _WinningLineOverlayState();
}

class _WinningLineOverlayState extends State<WinningLineOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.winningCells.isEmpty) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(
            widget.gridSize * widget.cellSize +
                (widget.gridSize - 1) * widget.spacing +
                widget.padding * 2,
            widget.gridSize * widget.cellSize +
                (widget.gridSize - 1) * widget.spacing +
                widget.padding * 2,
          ),
          painter: _WinningLinePainter(
            winningCells: widget.winningCells,
            cellSize: widget.cellSize,
            spacing: widget.spacing,
            padding: widget.padding,
            progress: _animation.value,
          ),
        );
      },
    );
  }
}

class _WinningLinePainter extends CustomPainter {
  final List<({int row, int col})> winningCells;
  final double cellSize;
  final double spacing;
  final double padding;
  final double progress;

  _WinningLinePainter({
    required this.winningCells,
    required this.cellSize,
    required this.spacing,
    required this.padding,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (winningCells.isEmpty) return;

    final paint = Paint()
      ..color = AppColors.success
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final first = winningCells.first;
    final last = winningCells.last;

    final startX = padding + first.col * (cellSize + spacing) + cellSize / 2;
    final startY = padding + first.row * (cellSize + spacing) + cellSize / 2;
    final endX = padding + last.col * (cellSize + spacing) + cellSize / 2;
    final endY = padding + last.row * (cellSize + spacing) + cellSize / 2;

    final currentEndX = startX + (endX - startX) * progress;
    final currentEndY = startY + (endY - startY) * progress;

    canvas.drawLine(
      Offset(startX, startY),
      Offset(currentEndX, currentEndY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _WinningLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
