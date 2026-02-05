import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_strings.dart';
import '../../core/di/providers.dart';
import '../../data/models/settings_model.dart';
import '../../domain/enums/enums.dart';

class SettingsState {
  final SettingsModel settings;
  final bool isLoading;
  final String? errorMessage;
  final bool hasChanges;

  const SettingsState({
    required this.settings,
    this.isLoading = false,
    this.errorMessage,
    this.hasChanges = false,
  });

  factory SettingsState.initial() =>
      SettingsState(settings: SettingsModel.defaults(), isLoading: false);

  SettingsState copyWith({
    SettingsModel? settings,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    bool? hasChanges,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      hasChanges: hasChanges ?? this.hasChanges,
    );
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);

class SettingsNotifier extends Notifier<SettingsState> {
  StreamSubscription? _subscription;

  @override
  SettingsState build() {
    ref.onDispose(() {
      _subscription?.cancel();
    });

    return SettingsState.initial();
  }

  Future<void> initialize() async {
    try {
      final repository = ref.read(settingsRepositoryProvider);
      final settings = await repository.getSettings();
      state = state.copyWith(settings: settings, isLoading: false);

      _subscription = repository.watchSettings().listen((settings) {
        state = state.copyWith(settings: settings);
      });
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: AppStrings.errorWithDetails(
          AppStrings.failedToLoadSettings,
          e,
        ),
      );
    }
  }

  Future<void> setSoundEnabled(bool enabled) async {
    final repository = ref.read(settingsRepositoryProvider);
    await _updateSetting(() => repository.updateSoundEnabled(enabled));
  }

  Future<void> setHapticEnabled(bool enabled) async {
    final repository = ref.read(settingsRepositoryProvider);
    await _updateSetting(() => repository.updateHapticEnabled(enabled));
  }

  Future<void> setAiDifficulty(AiDifficulty difficulty) async {
    final repository = ref.read(settingsRepositoryProvider);
    await _updateSetting(() => repository.updateAiDifficulty(difficulty));
  }

  Future<void> setDefaultBoardSize(BoardSize boardSize) async {
    final repository = ref.read(settingsRepositoryProvider);
    await _updateSetting(() => repository.updateDefaultBoardSize(boardSize));
  }

  Future<void> setDefaultGameMode(GameMode gameMode) async {
    final repository = ref.read(settingsRepositoryProvider);
    await _updateSetting(() => repository.updateDefaultGameMode(gameMode));
  }

  Future<void> setThemeMode(AppThemeMode themeMode) async {
    final repository = ref.read(settingsRepositoryProvider);
    await _updateSetting(() => repository.updateThemeMode(themeMode));
  }

  Future<void> setPlayerNames({String? playerX, String? playerO}) async {
    final repository = ref.read(settingsRepositoryProvider);
    await _updateSetting(
      () => repository.updatePlayerNames(playerX: playerX, playerO: playerO),
    );
  }

  Future<void> resetSettings() async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(settingsRepositoryProvider);
      await repository.resetSettings();
      final settings = await repository.getSettings();
      state = state.copyWith(settings: settings, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: AppStrings.errorWithDetails(
          AppStrings.failedToResetSettings,
          e,
        ),
      );
    }
  }

  Future<void> _updateSetting(Future<void> Function() update) async {
    try {
      await update();
      state = state.copyWith(clearError: true);
    } catch (e) {
      state = state.copyWith(
        errorMessage: AppStrings.errorWithDetails(
          AppStrings.failedToUpdateSetting,
          e,
        ),
      );
    }
  }
}

final currentSettingsProvider = Provider<SettingsModel>((ref) {
  return ref.watch(settingsProvider.select((state) => state.settings));
});

final soundEnabledProvider = Provider<bool>((ref) {
  return ref.watch(
    settingsProvider.select((state) => state.settings.soundEnabled),
  );
});

final hapticEnabledProvider = Provider<bool>((ref) {
  return ref.watch(
    settingsProvider.select((state) => state.settings.hapticEnabled),
  );
});

final aiDifficultyProvider = Provider<AiDifficulty>((ref) {
  return ref.watch(
    settingsProvider.select((state) => state.settings.aiDifficulty),
  );
});

final defaultBoardSizeProvider = Provider<BoardSize>((ref) {
  return ref.watch(
    settingsProvider.select((state) => state.settings.defaultBoardSize),
  );
});

final defaultGameModeProvider = Provider<GameMode>((ref) {
  return ref.watch(
    settingsProvider.select((state) => state.settings.defaultGameMode),
  );
});

final themeModeProvider = Provider<AppThemeMode>((ref) {
  return ref.watch(
    settingsProvider.select((state) => state.settings.themeMode),
  );
});

final playerNamesProvider = Provider<({String x, String o})>((ref) {
  final settings = ref.watch(currentSettingsProvider);
  return (x: settings.playerXName, o: settings.playerOName);
});
