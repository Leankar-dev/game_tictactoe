import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/settings_model.dart';
import '../../../domain/enums/enums.dart';
import '../../../presentation/providers/settings_provider.dart';
import '../../../presentation/widgets/widgets.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final settings = state.settings;

    return NeumorphicBackground(
      child: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: AppStrings.settings,
              showBackButton: true,
            ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(AppDimensions.spacing16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSection(
                            title: 'Game Defaults',
                            children: [
                              _SettingsTile(
                                title: 'Default Board Size',
                                subtitle: settings.defaultBoardSize.displayName,
                                icon: Icons.grid_on,
                                onTap: () => _showBoardSizeDialog(
                                  context,
                                  settings.defaultBoardSize,
                                  notifier,
                                ),
                              ),
                              _SettingsTile(
                                title: 'Default Game Mode',
                                subtitle: settings.defaultGameMode.displayName,
                                icon: Icons.sports_esports,
                                onTap: () => _showGameModeDialog(
                                  context,
                                  settings.defaultGameMode,
                                  notifier,
                                ),
                              ),
                            ],
                          ),

                          _buildSection(
                            title: 'AI Settings',
                            children: [
                              _SettingsTile(
                                title: AppStrings.difficulty,
                                subtitle: settings.aiDifficulty.displayName,
                                icon: Icons.psychology,
                                onTap: () => _showDifficultyDialog(
                                  context,
                                  settings.aiDifficulty,
                                  notifier,
                                ),
                              ),
                            ],
                          ),

                          _buildSection(
                            title: 'Feedback',
                            children: [
                              _SettingsTile.toggle(
                                title: AppStrings.soundEffects,
                                subtitle: 'Play sounds during game',
                                icon: Icons.volume_up,
                                value: settings.soundEnabled,
                                onChanged: (v) => notifier.setSoundEnabled(v),
                              ),
                              _SettingsTile.toggle(
                                title: AppStrings.hapticFeedback,
                                subtitle: 'Vibrate on actions',
                                icon: Icons.vibration,
                                value: settings.hapticEnabled,
                                onChanged: (v) => notifier.setHapticEnabled(v),
                              ),
                            ],
                          ),

                          _buildSection(
                            title: 'Player Names',
                            children: [
                              _SettingsTile(
                                title: 'Player X Name',
                                subtitle: settings.playerXName,
                                icon: Icons.person,
                                onTap: () => _showNameDialog(
                                  context,
                                  'Player X Name',
                                  settings.playerXName,
                                  (name) => notifier.setPlayerNames(playerX: name),
                                ),
                              ),
                              _SettingsTile(
                                title: 'Player O Name',
                                subtitle: settings.playerOName,
                                icon: Icons.person_outline,
                                onTap: () => _showNameDialog(
                                  context,
                                  'Player O Name',
                                  settings.playerOName,
                                  (name) => notifier.setPlayerNames(playerO: name),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppDimensions.spacing24),

                          Center(
                            child: NeumorphicButtonWidget.secondary(
                              text: 'Reset to Defaults',
                              icon: Icons.restore,
                              onPressed: () => _showResetDialog(context, notifier),
                            ),
                          ),

                          const SizedBox(height: AppDimensions.spacing32),

                          Center(
                            child: Column(
                              children: [
                                Text(
                                  AppStrings.appName,
                                  style: TextStyle(
                                    fontSize: AppDimensions.fontMedium,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  'Version ${AppStrings.appVersion}',
                                  style: TextStyle(
                                    fontSize: AppDimensions.fontSmall,
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppDimensions.spacing24),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing8,
            vertical: AppDimensions.spacing12,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: AppDimensions.fontMedium,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ),
        NeumorphicCardWidget(
          padding: EdgeInsets.zero,
          child: Column(
            children: children,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing16),
      ],
    );
  }

  void _showBoardSizeDialog(
    BuildContext context,
    BoardSize current,
    SettingsNotifier notifier,
  ) {
    showDialog(
      context: context,
      builder: (context) => _SelectionDialog<BoardSize>(
        title: 'Default Board Size',
        options: BoardSize.values,
        current: current,
        labelBuilder: (v) => v.displayName,
        onSelected: (v) => notifier.setDefaultBoardSize(v),
      ),
    );
  }

  void _showGameModeDialog(
    BuildContext context,
    GameMode current,
    SettingsNotifier notifier,
  ) {
    showDialog(
      context: context,
      builder: (context) => _SelectionDialog<GameMode>(
        title: 'Default Game Mode',
        options: GameMode.values,
        current: current,
        labelBuilder: (v) => v.displayName,
        onSelected: (v) => notifier.setDefaultGameMode(v),
      ),
    );
  }

  void _showDifficultyDialog(
    BuildContext context,
    AiDifficulty current,
    SettingsNotifier notifier,
  ) {
    showDialog(
      context: context,
      builder: (context) => _SelectionDialog<AiDifficulty>(
        title: 'AI Difficulty',
        options: AiDifficulty.values,
        current: current,
        labelBuilder: (v) => v.displayName,
        onSelected: (v) => notifier.setAiDifficulty(v),
      ),
    );
  }

  void _showNameDialog(
    BuildContext context,
    String title,
    String currentValue,
    ValueChanged<String> onSave,
  ) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSave(controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, SettingsNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text('Reset all settings to default values?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier.resetSettings();
              Navigator.pop(context);
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}


class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final bool? toggleValue;
  final ValueChanged<bool>? onToggleChanged;

  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  })  : toggleValue = null,
        onToggleChanged = null;

  const _SettingsTile.toggle({
    required this.title,
    required this.subtitle,
    required this.icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  })  : toggleValue = value,
        onToggleChanged = onChanged,
        onTap = null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary),
            const SizedBox(width: AppDimensions.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
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
            if (toggleValue != null)
              NeumorphicSwitch(
                value: toggleValue!,
                onChanged: onToggleChanged,
              )
            else
              Icon(
                Icons.chevron_right,
                color: AppColors.textLight,
              ),
          ],
        ),
      ),
    );
  }
}


class _SelectionDialog<T> extends StatelessWidget {
  final String title;
  final List<T> options;
  final T current;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onSelected;

  const _SelectionDialog({
    required this.title,
    required this.options,
    required this.current,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((option) {
          final isSelected = option == current;
          return ListTile(
            title: Text(labelBuilder(option)),
            trailing: isSelected
                ? Icon(Icons.check, color: AppColors.accent)
                : null,
            onTap: () {
              onSelected(option);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
