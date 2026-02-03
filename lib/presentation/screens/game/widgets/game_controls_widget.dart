import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../presentation/providers/game_provider.dart';
import '../../../../presentation/widgets/widgets.dart';

class GameControlsWidget extends ConsumerWidget {
  final VoidCallback? onMainMenu;

  const GameControlsWidget({
    super.key,
    this.onMainMenu,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameProvider);
    final notifier = ref.read(gameProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NeumorphicButtonWidget(
            text: 'Undo',
            icon: Icons.undo,
            onPressed: state.canUndo && !state.isAiThinking
                ? () => notifier.undoMove()
                : null,
            isDisabled: !state.canUndo || state.isAiThinking,
            variant: NeumorphicButtonVariant.secondary,
          ),
          NeumorphicButtonWidget(
            text: 'Restart',
            icon: Icons.refresh,
            onPressed: !state.isLoading && !state.isAiThinking
                ? () => _showRestartDialog(context, notifier)
                : null,
            isDisabled: state.isLoading || state.isAiThinking,
            variant: NeumorphicButtonVariant.secondary,
          ),
          if (onMainMenu != null)
            NeumorphicButtonWidget(
              text: 'Menu',
              icon: Icons.home,
              onPressed: !state.isAiThinking
                  ? () => _showExitDialog(context, onMainMenu!)
                  : null,
              isDisabled: state.isAiThinking,
              variant: NeumorphicButtonVariant.secondary,
            ),
        ],
      ),
    );
  }

  void _showRestartDialog(BuildContext context, GameNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restart Game'),
        content: const Text('Are you sure you want to restart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              notifier.restartGame();
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Game'),
        content: const Text(
          'Are you sure you want to exit? Your current game will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}

class GameControlsCompact extends ConsumerWidget {
  final VoidCallback? onMainMenu;

  const GameControlsCompact({
    super.key,
    this.onMainMenu,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameProvider);
    final notifier = ref.read(gameProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NeumorphicIconButton(
          icon: Icons.undo,
          onPressed: state.canUndo && !state.isAiThinking
              ? () => notifier.undoMove()
              : null,
          isDisabled: !state.canUndo || state.isAiThinking,
        ),
        const SizedBox(width: AppDimensions.spacing16),
        NeumorphicIconButton(
          icon: Icons.refresh,
          onPressed: !state.isLoading && !state.isAiThinking
              ? () => notifier.restartGame()
              : null,
          isDisabled: state.isLoading || state.isAiThinking,
        ),
        if (onMainMenu != null) ...[
          const SizedBox(width: AppDimensions.spacing16),
          NeumorphicIconButton(
            icon: Icons.home,
            onPressed: !state.isAiThinking ? onMainMenu : null,
            isDisabled: state.isAiThinking,
          ),
        ],
      ],
    );
  }
}
