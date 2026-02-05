import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/enums/enums.dart';
import '../../../presentation/providers/game_provider.dart';
import '../../../presentation/providers/game_state.dart';
import '../../../presentation/widgets/widgets.dart';
import 'widgets/board_widget.dart';
import 'widgets/game_controls_widget.dart';
import 'widgets/player_indicator_widget.dart';

class GameScreen extends ConsumerStatefulWidget {
  final BoardSize boardSize;
  final GameMode gameMode;

  const GameScreen({
    super.key,
    required this.boardSize,
    required this.gameMode,
  });

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(gameProvider.notifier)
          .startGame(boardSize: widget.boardSize, gameMode: widget.gameMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameProvider);

    ref.listen<GameState>(gameProvider, (previous, next) {
      if (previous?.showGameOverDialog == false &&
          next.showGameOverDialog == true) {
        _showGameOverDialog(context, next);
      }
    });

    return Scaffold(
      body: NeumorphicBackground(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: widget.boardSize == BoardSize.classic
                    ? AppStrings.classicMode
                    : AppStrings.extendedMode,
                showBackButton: true,
                onBackPressed: () => _handleBack(context),
                actions: [
                  AppBarAction(
                    icon: Icons.info_outline,
                    tooltip: 'Game Info',
                    onPressed: () => _showGameInfo(context),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacing16),
              const PlayerIndicatorWidget(),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.spacing16),
                    child: BoardWidget(
                      cellSize: widget.boardSize == BoardSize.classic
                          ? AppDimensions.cellSizeClassic
                          : AppDimensions.cellSizeExtended,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.spacing8,
                ),
                child: Text(
                  'Move ${state.moveCount}',
                  style: TextStyle(
                    fontSize: AppDimensions.fontMedium,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spacing24),
                child: GameControlsWidget(
                  onMainMenu: () => _handleBack(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleBack(BuildContext context) {
    final state = ref.read(gameProvider);
    if (state.hasUnsavedChanges && !state.isGameOver) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit Game'),
          content: const Text('Your game is in progress. Exit anyway?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Stay'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Exit'),
            ),
          ],
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _showGameOverDialog(BuildContext context, GameState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _GameOverDialog(
        status: state.status,
        playerXName: state.game.playerX.name,
        playerOName: state.game.playerO.name,
        moveCount: state.moveCount,
        onPlayAgain: () {
          Navigator.pop(context);
          ref.read(gameProvider.notifier).restartGame();
        },
        onMainMenu: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        onSave: () async {
          await ref.read(gameProvider.notifier).saveGame();
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Game saved!')));
          }
        },
      ),
    );
  }

  void _showGameInfo(BuildContext context) {
    final state = ref.read(gameProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mode: ${widget.gameMode.displayName}'),
            Text('Board: ${widget.boardSize.displayName}'),
            Text('Win Condition: ${widget.boardSize.winCondition} in a row'),
            const Divider(),
            Text('Moves: ${state.moveCount}'),
            Text('Status: ${state.status.name}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _GameOverDialog extends StatelessWidget {
  final GameStatus status;
  final String playerXName;
  final String playerOName;
  final int moveCount;
  final VoidCallback onPlayAgain;
  final VoidCallback onMainMenu;
  final VoidCallback onSave;

  const _GameOverDialog({
    required this.status,
    required this.playerXName,
    required this.playerOName,
    required this.moveCount,
    required this.onPlayAgain,
    required this.onMainMenu,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _getTitle(),
        style: TextStyle(color: _getTitleColor(), fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getIcon(), size: 64, color: _getTitleColor()),
          const SizedBox(height: 16),
          Text(
            'Game completed in $moveCount moves',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          children: [
            NeumorphicButtonWidget.primary(
              text: 'Play Again',
              icon: Icons.refresh,
              onPressed: onPlayAgain,
              width: 200,
            ),
            const SizedBox(height: 12),
            NeumorphicButtonWidget.secondary(
              text: 'Save Game',
              icon: Icons.save,
              onPressed: onSave,
              width: 200,
            ),
            const SizedBox(height: 12),
            NeumorphicButtonWidget.secondary(
              text: 'Main Menu',
              icon: Icons.home,
              onPressed: onMainMenu,
              width: 200,
            ),
          ],
        ),
      ],
    );
  }

  String _getTitle() {
    switch (status) {
      case GameStatus.xWins:
        return '$playerXName Wins!';
      case GameStatus.oWins:
        return '$playerOName Wins!';
      case GameStatus.draw:
        return "It's a Draw!";
      default:
        return 'Game Over';
    }
  }

  Color _getTitleColor() {
    switch (status) {
      case GameStatus.xWins:
        return AppColors.playerX;
      case GameStatus.oWins:
        return AppColors.playerO;
      case GameStatus.draw:
        return AppColors.warning;
      default:
        return AppColors.textPrimary;
    }
  }

  IconData _getIcon() {
    switch (status) {
      case GameStatus.xWins:
      case GameStatus.oWins:
        return Icons.emoji_events;
      case GameStatus.draw:
        return Icons.handshake;
      default:
        return Icons.sports_esports;
    }
  }
}
