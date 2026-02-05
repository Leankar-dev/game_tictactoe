import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../domain/enums/enums.dart';
import '../../../../presentation/providers/game_provider.dart';
import '../../../../presentation/providers/game_state.dart';
import 'cell_widget.dart';

class BoardWidget extends ConsumerWidget {
  final double? cellSize;
  final double spacing;
  final void Function(int row, int col)? onCellTap;

  const BoardWidget({
    super.key,
    this.cellSize,
    this.spacing = AppDimensions.cellSpacing,
    this.onCellTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameProvider);
    final board = state.board;
    final size = board.size.size;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableSize = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;

        final calculatedCellSize =
            cellSize ?? _calculateCellSize(availableSize, size, spacing);

        return Neumorphic(
          style: NeumorphicStyle(
            depth: 8,
            intensity: 0.5,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(AppDimensions.radiusLarge),
            ),
          ),
          padding: const EdgeInsets.all(AppDimensions.boardPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(size, (row) {
              return Padding(
                padding: EdgeInsets.only(bottom: row < size - 1 ? spacing : 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(size, (col) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: col < size - 1 ? spacing : 0,
                      ),
                      child: _buildCell(
                        context,
                        ref,
                        state,
                        row,
                        col,
                        calculatedCellSize,
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildCell(
    BuildContext context,
    WidgetRef ref,
    GameState state,
    int row,
    int col,
    double size,
  ) {
    final player = state.getCellPlayer(row, col);
    final isWinning = state.isWinningCell(row, col);
    final isLastMove = state.isLastMove(row, col);
    final canPlay =
        !state.isGameOver &&
        !state.isLoading &&
        !state.isAiThinking &&
        !state.isCpuTurn;

    return CellWidget(
      player: player,
      isWinningCell: isWinning,
      isEnabled: canPlay && player == PlayerType.none,
      size: size,
      animate: isLastMove,
      onTap: () {
        if (onCellTap != null) {
          onCellTap!(row, col);
        } else {
          ref.read(gameProvider.notifier).makeMove(row, col);
        }
      },
    );
  }

  double _calculateCellSize(
    double availableSize,
    int gridSize,
    double spacing,
  ) {
    final totalSpacing = spacing * (gridSize - 1);
    final totalPadding = AppDimensions.boardPadding * 2;
    final availableForCells = availableSize - totalSpacing - totalPadding;
    return availableForCells / gridSize;
  }
}

class CompactBoardWidget extends StatelessWidget {
  final List<List<PlayerType>> cells;
  final BoardSize boardSize;
  final double size;
  final List<({int row, int col})>? winningCells;

  const CompactBoardWidget({
    super.key,
    required this.cells,
    required this.boardSize,
    this.size = 100,
    this.winningCells,
  });

  @override
  Widget build(BuildContext context) {
    final gridSize = boardSize.size;
    final cellSize = (size - (gridSize - 1) * 2) / gridSize;

    return SizedBox(
      width: size,
      height: size,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(gridSize, (row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(gridSize, (col) {
              final player = cells[row][col];
              final isWinning =
                  winningCells?.any((c) => c.row == row && c.col == col) ??
                  false;

              return Container(
                width: cellSize,
                height: cellSize,
                margin: EdgeInsets.only(
                  right: col < gridSize - 1 ? 2 : 0,
                  bottom: row < gridSize - 1 ? 2 : 0,
                ),
                decoration: BoxDecoration(
                  color: isWinning
                      ? AppColors.success.withValues(alpha: 0.3)
                      : AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: _buildMiniSymbol(player, cellSize * 0.6, isWinning),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  Widget _buildMiniSymbol(PlayerType player, double size, bool isWinning) {
    if (player == PlayerType.none) {
      return const SizedBox.shrink();
    }

    final color = isWinning
        ? AppColors.success
        : (player == PlayerType.x ? AppColors.playerX : AppColors.playerO);

    return CustomPaint(
      size: Size(size, size),
      painter: player == PlayerType.x
          ? _MiniXPainter(color: color)
          : _MiniOPainter(color: color),
    );
  }
}

class _MiniXPainter extends CustomPainter {
  final Color color;
  _MiniXPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiniOPainter extends CustomPainter {
  final Color color;
  _MiniOPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 1,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
