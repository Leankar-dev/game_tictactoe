import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/enums/enums.dart';
import '../../../presentation/widgets/widgets.dart';
import '../game/game_screen.dart';
import '../statistics/statistics_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: NeumorphicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing24),
            child: Column(
              children: [
                const Spacer(flex: 1),

                _buildTitle(),

                const Spacer(flex: 1),

                _buildPlayButton(context),

                const SizedBox(height: AppDimensions.spacing32),

                _buildQuickPlayOptions(context),

                const Spacer(flex: 2),

                _buildBottomNav(context),

                const SizedBox(height: AppDimensions.spacing16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        NeumorphicText(
          'TIC TAC',
          style: const NeumorphicStyle(depth: 4, color: AppColors.playerX),
          textStyle: NeumorphicTextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        NeumorphicText(
          'TOE',
          style: const NeumorphicStyle(depth: 4, color: AppColors.playerO),
          textStyle: NeumorphicTextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayButton(BuildContext context) {
    return NeumorphicButton(
      onPressed: () => _showModeSelector(context),
      style: NeumorphicStyle(
        depth: 8,
        intensity: 0.6,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(AppDimensions.radiusLarge),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing48,
        vertical: AppDimensions.spacing20,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.play_arrow,
            size: AppDimensions.iconLarge,
            color: AppColors.accent,
          ),
          const SizedBox(width: AppDimensions.spacing12),
          Text(
            AppStrings.play,
            style: TextStyle(
              fontSize: AppDimensions.fontXLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPlayOptions(BuildContext context) {
    return Column(
      children: [
        Text(
          'Quick Play',
          style: TextStyle(
            fontSize: AppDimensions.fontMedium,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _QuickPlayButton(
              label: '3x3',
              sublabel: 'Classic',
              onTap: () => _startQuickGame(
                context,
                BoardSize.classic,
                GameMode.playerVsPlayer,
              ),
            ),
            const SizedBox(width: AppDimensions.spacing16),
            _QuickPlayButton(
              label: '6x6',
              sublabel: 'Extended',
              onTap: () => _startQuickGame(
                context,
                BoardSize.extended,
                GameMode.playerVsPlayer,
              ),
            ),
            const SizedBox(width: AppDimensions.spacing16),
            _QuickPlayButton(
              label: 'vs',
              sublabel: 'CPU',
              icon: Icons.computer,
              onTap: () => _startQuickGame(
                context,
                BoardSize.classic,
                GameMode.playerVsCpu,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NeumorphicIconButton(
          icon: Icons.bar_chart,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const StatisticsScreen()),
          ),
        ),
        NeumorphicIconButton(
          icon: Icons.settings,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          ),
        ),
      ],
    );
  }

  void _showModeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXLarge),
        ),
      ),
      builder: (context) => const _GameModeSelector(),
    );
  }

  void _startQuickGame(
    BuildContext context,
    BoardSize boardSize,
    GameMode gameMode,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(boardSize: boardSize, gameMode: gameMode),
      ),
    );
  }
}

class _QuickPlayButton extends StatelessWidget {
  final String label;
  final String sublabel;
  final IconData? icon;
  final VoidCallback onTap;

  const _QuickPlayButton({
    required this.label,
    required this.sublabel,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onTap,
      style: NeumorphicStyle(
        depth: 4,
        intensity: 0.5,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing12,
      ),
      child: Column(
        children: [
          if (icon != null)
            Icon(icon, size: 24, color: AppColors.textPrimary)
          else
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.fontLarge,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          const SizedBox(height: 4),
          Text(
            sublabel,
            style: TextStyle(
              fontSize: AppDimensions.fontSmall,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _GameModeSelector extends StatefulWidget {
  const _GameModeSelector();

  @override
  State<_GameModeSelector> createState() => _GameModeSelectorState();
}

class _GameModeSelectorState extends State<_GameModeSelector> {
  BoardSize _boardSize = BoardSize.classic;
  GameMode _gameMode = GameMode.playerVsPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacing24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppDimensions.spacing24),

          Text(
            AppStrings.selectBoardSize,
            style: TextStyle(
              fontSize: AppDimensions.fontLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing16),

          Row(
            children: [
              Expanded(
                child: _SelectionCard(
                  title: '3x3',
                  subtitle: 'Classic',
                  isSelected: _boardSize == BoardSize.classic,
                  onTap: () => setState(() => _boardSize = BoardSize.classic),
                ),
              ),
              const SizedBox(width: AppDimensions.spacing16),
              Expanded(
                child: _SelectionCard(
                  title: '6x6',
                  subtitle: 'Extended',
                  isSelected: _boardSize == BoardSize.extended,
                  onTap: () => setState(() => _boardSize = BoardSize.extended),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spacing24),

          Text(
            AppStrings.selectMode,
            style: TextStyle(
              fontSize: AppDimensions.fontLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing16),

          Row(
            children: [
              Expanded(
                child: _SelectionCard(
                  title: 'PvP',
                  subtitle: 'Player vs Player',
                  icon: Icons.people,
                  isSelected: _gameMode == GameMode.playerVsPlayer,
                  onTap: () =>
                      setState(() => _gameMode = GameMode.playerVsPlayer),
                ),
              ),
              const SizedBox(width: AppDimensions.spacing16),
              Expanded(
                child: _SelectionCard(
                  title: 'PvC',
                  subtitle: 'Player vs CPU',
                  icon: Icons.computer,
                  isSelected: _gameMode == GameMode.playerVsCpu,
                  onTap: () => setState(() => _gameMode = GameMode.playerVsCpu),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spacing32),

          NeumorphicButtonWidget.primary(
            text: AppStrings.start,
            icon: Icons.play_arrow,
            width: double.infinity,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      GameScreen(boardSize: _boardSize, gameMode: _gameMode),
                ),
              );
            },
          ),

          const SizedBox(height: AppDimensions.spacing16),
        ],
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionCard({
    required this.title,
    required this.subtitle,
    this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: isSelected ? -4 : 4,
          intensity: isSelected ? 0.8 : 0.5,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          color: isSelected ? AppColors.accent.withValues(alpha: 0.1) : null,
        ),
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 32,
                color: isSelected ? AppColors.accent : AppColors.textPrimary,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: AppDimensions.fontLarge,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.accent : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: AppDimensions.fontSmall,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
