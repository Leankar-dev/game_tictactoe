import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../presentation/providers/statistics_provider.dart';
import '../../../presentation/widgets/widgets.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(statisticsProvider);

    return Scaffold(
      body: NeumorphicBackground(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: AppStrings.statistics,
                showBackButton: true,
                actions: [
                  AppBarAction(
                    icon: Icons.refresh,
                    tooltip: 'Refresh',
                    onPressed: () =>
                        ref.read(statisticsProvider.notifier).refresh(),
                  ),
                ],
              ),

              _FilterTabs(
                currentFilter: state.currentFilter,
                onFilterChanged: (filter) =>
                    ref.read(statisticsProvider.notifier).setFilter(filter),
              ),

              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildContent(context, ref, state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    StatisticsState state,
  ) {
    final stats = state.filteredStats;

    if (stats == null || stats.totalGames == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: 64,
              color: AppColors.textLight,
            ),
            const SizedBox(height: AppDimensions.spacing16),
            Text(
              'No games played yet',
              style: TextStyle(
                fontSize: AppDimensions.fontLarge,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing8),
            Text(
              'Play some games to see your statistics',
              style: TextStyle(
                fontSize: AppDimensions.fontMedium,
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: StatisticCard(
                  label: AppStrings.totalGames,
                  value: stats.totalGames.toString(),
                  icon: Icons.sports_esports,
                ),
              ),
              const SizedBox(width: AppDimensions.spacing16),
              Expanded(
                child: StatisticCard(
                  label: 'Avg. Moves',
                  value: stats.averageMoves.toStringAsFixed(1),
                  icon: Icons.touch_app,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spacing16),

          NeumorphicCardWidget(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Results',
                  style: TextStyle(
                    fontSize: AppDimensions.fontLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing16),

                _StatBar(
                  label: 'X Wins',
                  value: stats.xWins,
                  total: stats.totalGames,
                  color: AppColors.playerX,
                ),
                const SizedBox(height: AppDimensions.spacing12),

                _StatBar(
                  label: 'O Wins',
                  value: stats.oWins,
                  total: stats.totalGames,
                  color: AppColors.playerO,
                ),
                const SizedBox(height: AppDimensions.spacing12),

                _StatBar(
                  label: 'Draws',
                  value: stats.draws,
                  total: stats.totalGames,
                  color: AppColors.warning,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spacing16),

          NeumorphicCardWidget(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Win Streaks',
                  style: TextStyle(
                    fontSize: AppDimensions.fontLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing16),

                Row(
                  children: [
                    Expanded(
                      child: _StreakCard(
                        player: 'X',
                        current: stats.xWinStreak,
                        best: stats.xBestStreak,
                        color: AppColors.playerX,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacing16),
                    Expanded(
                      child: _StreakCard(
                        player: 'O',
                        current: stats.oWinStreak,
                        best: stats.oBestStreak,
                        color: AppColors.playerO,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spacing24),

          NeumorphicButtonWidget.danger(
            text: 'Reset Statistics',
            icon: Icons.delete_forever,
            onPressed: () => _showResetDialog(context, ref),
          ),

          const SizedBox(height: AppDimensions.spacing24),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Statistics'),
        content: const Text(
          'Are you sure you want to reset all statistics? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(statisticsProvider.notifier).resetStatistics();
              Navigator.pop(context);
            },
            child: Text(
              'Reset',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}


class _FilterTabs extends StatelessWidget {
  final StatisticsFilter currentFilter;
  final ValueChanged<StatisticsFilter> onFilterChanged;

  const _FilterTabs({
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing8,
      ),
      child: Row(
        children: StatisticsFilter.values.map((filter) {
          final isSelected = filter == currentFilter;
          return Padding(
            padding: const EdgeInsets.only(right: AppDimensions.spacing8),
            child: NeumorphicButton(
              onPressed: () => onFilterChanged(filter),
              style: NeumorphicStyle(
                depth: isSelected ? -4 : 4,
                intensity: isSelected ? 0.8 : 0.5,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(AppDimensions.radiusMedium),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing12,
                vertical: AppDimensions.spacing8,
              ),
              child: Text(
                filter.displayName,
                style: TextStyle(
                  fontSize: AppDimensions.fontSmall,
                  color: isSelected ? AppColors.accent : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


class _StatBar extends StatelessWidget {
  final String label;
  final int value;
  final int total;
  final Color color;

  const _StatBar({
    required this.label,
    required this.value,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = total > 0 ? value / total : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              '$value (${(percentage * 100).toStringAsFixed(1)}%)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        NeumorphicProgressContainer(
          progress: percentage,
          progressColor: color,
        ),
      ],
    );
  }
}


class _StreakCard extends StatelessWidget {
  final String player;
  final int current;
  final int best;
  final Color color;

  const _StreakCard({
    required this.player,
    required this.current,
    required this.best,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -4,
        intensity: 0.7,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
      padding: const EdgeInsets.all(AppDimensions.spacing12),
      child: Column(
        children: [
          Text(
            player,
            style: TextStyle(
              fontSize: AppDimensions.fontXLarge,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Current: $current',
            style: TextStyle(
              fontSize: AppDimensions.fontSmall,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            'Best: $best',
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
