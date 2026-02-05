import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../domain/enums/enums.dart';
import '../../../../presentation/providers/game_provider.dart';
import '../../../../presentation/providers/game_state.dart';

class PlayerIndicatorWidget extends ConsumerWidget {
  const PlayerIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameProvider);

    return Neumorphic(
      style: NeumorphicStyle(
        depth: 6,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(AppDimensions.radiusLarge),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing24,
        vertical: AppDimensions.spacing16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            state.statusMessage,
            style: TextStyle(
              fontSize: AppDimensions.fontXLarge,
              fontWeight: FontWeight.bold,
              color: _getStatusColor(state),
            ),
            textAlign: TextAlign.center,
          ),
          if (!state.isGameOver) ...[
            const SizedBox(height: AppDimensions.spacing16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PlayerAvatar(
                  player: PlayerType.x,
                  name: state.game.playerX.name,
                  isActive: state.currentTurn == PlayerType.x,
                  isCpu: state.game.playerX.isCpu,
                ),
                const SizedBox(width: AppDimensions.spacing32),
                Text(
                  'VS',
                  style: TextStyle(
                    fontSize: AppDimensions.fontMedium,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: AppDimensions.spacing32),
                _PlayerAvatar(
                  player: PlayerType.o,
                  name: state.game.playerO.name,
                  isActive: state.currentTurn == PlayerType.o,
                  isCpu: state.game.playerO.isCpu,
                ),
              ],
            ),
          ],
          if (state.isAiThinking) ...[
            const SizedBox(height: AppDimensions.spacing12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.playerO,
                  ),
                ),
                const SizedBox(width: AppDimensions.spacing8),
                Text(
                  'CPU is thinking...',
                  style: TextStyle(
                    fontSize: AppDimensions.fontSmall,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(GameState state) {
    if (state.status == GameStatus.xWins) {
      return AppColors.playerX;
    } else if (state.status == GameStatus.oWins) {
      return AppColors.playerO;
    } else if (state.status == GameStatus.draw) {
      return AppColors.warning;
    }
    return AppColors.textPrimary;
  }
}

class _PlayerAvatar extends StatelessWidget {
  final PlayerType player;
  final String name;
  final bool isActive;
  final bool isCpu;

  const _PlayerAvatar({
    required this.player,
    required this.name,
    required this.isActive,
    required this.isCpu,
  });

  @override
  Widget build(BuildContext context) {
    final color = player == PlayerType.x
        ? AppColors.playerX
        : AppColors.playerO;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: AppDimensions.animationNormal),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isActive
                ? Border.all(color: color, width: 3)
                : Border.all(color: Colors.transparent, width: 3),
          ),
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: isActive ? 6 : 2,
              intensity: 0.5,
              boxShape: const NeumorphicBoxShape.circle(),
            ),
            padding: const EdgeInsets.all(AppDimensions.spacing12),
            child: Text(
              player.symbol,
              style: TextStyle(
                fontSize: AppDimensions.fontXXLarge,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: AppDimensions.fontSmall,
                color: isActive ? color : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isCpu) ...[
              const SizedBox(width: 4),
              Icon(Icons.computer, size: 12, color: AppColors.textSecondary),
            ],
          ],
        ),
      ],
    );
  }
}

class TurnIndicatorCompact extends ConsumerWidget {
  const TurnIndicatorCompact({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTurn = ref.watch(currentTurnProvider);
    final isGameOver = ref.watch(gameStatusProvider).isGameOver;

    if (isGameOver) return const SizedBox.shrink();

    final color = currentTurn == PlayerType.x
        ? AppColors.playerX
        : AppColors.playerO;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          '${currentTurn.symbol}\'s turn',
          style: TextStyle(
            fontSize: AppDimensions.fontMedium,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
