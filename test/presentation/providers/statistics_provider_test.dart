import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:game_tictactoe/data/models/statistics_model.dart';
import 'package:game_tictactoe/data/repositories/statistics_repository.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';
import 'package:game_tictactoe/presentation/providers/statistics_provider.dart';
import 'package:game_tictactoe/core/di/providers.dart';

class MockStatisticsRepository extends Mock implements StatisticsRepository {}

void main() {
  late MockStatisticsRepository mockRepository;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(BoardSize.classic);
    registerFallbackValue(GameMode.playerVsPlayer);
  });

  setUp(() {
    mockRepository = MockStatisticsRepository();

    when(() => mockRepository.getStatistics(
          boardSize: any(named: 'boardSize'),
          gameMode: any(named: 'gameMode'),
        )).thenAnswer((_) async => StatisticsModel.empty(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        ));

    when(() => mockRepository.getTotalStatistics()).thenAnswer(
      (_) async => StatisticsModel.empty(
        boardSize: BoardSize.classic,
        gameMode: GameMode.playerVsPlayer,
      ),
    );

    container = ProviderContainer(
      overrides: [
        statisticsRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('StatisticsNotifier', () {
    test('should load statistics when called', () async {
      final notifier = container.read(statisticsProvider.notifier);

      await notifier.loadStatistics();

      verify(() => mockRepository.getStatistics(
            boardSize: BoardSize.classic,
            gameMode: GameMode.playerVsPlayer,
          )).called(1);
      verify(() => mockRepository.getTotalStatistics()).called(1);
    });

    test('should change filter correctly', () {
      final notifier = container.read(statisticsProvider.notifier);
      notifier.setFilter(StatisticsFilter.classicPvp);

      final state = container.read(statisticsProvider);
      expect(state.currentFilter, StatisticsFilter.classicPvp);
    });

    test('should reset statistics', () async {
      when(() => mockRepository.resetAllStatistics()).thenAnswer((_) async {});

      final notifier = container.read(statisticsProvider.notifier);
      await notifier.resetStatistics();

      verify(() => mockRepository.resetAllStatistics()).called(1);
    });
  });
}
