import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_tictactoe/data/models/settings_model.dart';
import 'package:game_tictactoe/data/repositories/settings_repository.dart';
import 'package:game_tictactoe/presentation/providers/settings_provider.dart';
import 'package:game_tictactoe/core/di/providers.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late MockSettingsRepository mockRepository;
  late ProviderContainer container;
  late StreamController<SettingsModel> settingsStreamController;

  setUp(() {
    mockRepository = MockSettingsRepository();
    settingsStreamController = StreamController<SettingsModel>.broadcast();

    when(
      () => mockRepository.getSettings(),
    ).thenAnswer((_) async => SettingsModel.defaults());

    when(
      () => mockRepository.watchSettings(),
    ).thenAnswer((_) => settingsStreamController.stream);

    container = ProviderContainer(
      overrides: [settingsRepositoryProvider.overrideWithValue(mockRepository)],
    );
  });

  tearDown(() {
    settingsStreamController.close();
    container.dispose();
  });

  group('SettingsNotifier', () {
    test('should have default settings on init', () {
      final state = container.read(settingsProvider);
      expect(state.settings.soundEnabled, true);
      expect(state.settings.hapticEnabled, true);
      expect(state.isLoading, false);
    });

    test('should load settings when initialize is called', () async {
      final notifier = container.read(settingsProvider.notifier);
      await notifier.initialize();

      verify(() => mockRepository.getSettings()).called(1);
      verify(() => mockRepository.watchSettings()).called(1);
    });

    test('should update sound enabled', () async {
      when(
        () => mockRepository.updateSoundEnabled(any()),
      ).thenAnswer((_) async {});

      final notifier = container.read(settingsProvider.notifier);
      await notifier.setSoundEnabled(false);

      verify(() => mockRepository.updateSoundEnabled(false)).called(1);
    });

    test('should reset settings', () async {
      when(() => mockRepository.resetSettings()).thenAnswer((_) async {});

      final notifier = container.read(settingsProvider.notifier);
      await notifier.resetSettings();

      verify(() => mockRepository.resetSettings()).called(1);
    });
  });

  group('Selector providers', () {
    test('soundEnabledProvider should reflect settings', () {
      expect(container.read(soundEnabledProvider), true);
    });
  });
}
