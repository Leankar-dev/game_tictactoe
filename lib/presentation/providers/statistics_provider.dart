import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/providers.dart';
import '../../data/models/statistics_model.dart';
import '../../domain/enums/enums.dart';

class StatisticsState {
  final StatisticsModel? classicPvpStats;
  final StatisticsModel? classicPvcStats;
  final StatisticsModel? extendedPvpStats;
  final StatisticsModel? extendedPvcStats;
  final StatisticsModel? totalStats;
  final bool isLoading;
  final String? errorMessage;
  final StatisticsFilter currentFilter;

  const StatisticsState({
    this.classicPvpStats,
    this.classicPvcStats,
    this.extendedPvpStats,
    this.extendedPvcStats,
    this.totalStats,
    this.isLoading = false,
    this.errorMessage,
    this.currentFilter = StatisticsFilter.all,
  });

  factory StatisticsState.initial() => const StatisticsState(isLoading: false);

  StatisticsModel? get filteredStats {
    switch (currentFilter) {
      case StatisticsFilter.all:
        return totalStats;
      case StatisticsFilter.classicPvp:
        return classicPvpStats;
      case StatisticsFilter.classicPvc:
        return classicPvcStats;
      case StatisticsFilter.extendedPvp:
        return extendedPvpStats;
      case StatisticsFilter.extendedPvc:
        return extendedPvcStats;
    }
  }

  StatisticsState copyWith({
    StatisticsModel? classicPvpStats,
    StatisticsModel? classicPvcStats,
    StatisticsModel? extendedPvpStats,
    StatisticsModel? extendedPvcStats,
    StatisticsModel? totalStats,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    StatisticsFilter? currentFilter,
  }) {
    return StatisticsState(
      classicPvpStats: classicPvpStats ?? this.classicPvpStats,
      classicPvcStats: classicPvcStats ?? this.classicPvcStats,
      extendedPvpStats: extendedPvpStats ?? this.extendedPvpStats,
      extendedPvcStats: extendedPvcStats ?? this.extendedPvcStats,
      totalStats: totalStats ?? this.totalStats,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}

enum StatisticsFilter {
  all('All Games'),
  classicPvp('Classic - Player vs Player'),
  classicPvc('Classic - Player vs CPU'),
  extendedPvp('Extended - Player vs Player'),
  extendedPvc('Extended - Player vs CPU');

  final String displayName;
  const StatisticsFilter(this.displayName);
}

final statisticsProvider = NotifierProvider<StatisticsNotifier, StatisticsState>(StatisticsNotifier.new);

class StatisticsNotifier extends Notifier<StatisticsState> {
  @override
  StatisticsState build() {
    return StatisticsState.initial();
  }

  Future<void> loadStatistics() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final repository = ref.read(statisticsRepositoryProvider);
      final classicPvp = await repository.getStatistics(
        boardSize: BoardSize.classic,
        gameMode: GameMode.playerVsPlayer,
      );
      final classicPvc = await repository.getStatistics(
        boardSize: BoardSize.classic,
        gameMode: GameMode.playerVsCpu,
      );
      final extendedPvp = await repository.getStatistics(
        boardSize: BoardSize.extended,
        gameMode: GameMode.playerVsPlayer,
      );
      final extendedPvc = await repository.getStatistics(
        boardSize: BoardSize.extended,
        gameMode: GameMode.playerVsCpu,
      );
      final total = await repository.getTotalStatistics();

      state = state.copyWith(
        classicPvpStats: classicPvp,
        classicPvcStats: classicPvc,
        extendedPvpStats: extendedPvp,
        extendedPvcStats: extendedPvc,
        totalStats: total,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load statistics: $e',
      );
    }
  }

  void setFilter(StatisticsFilter filter) {
    state = state.copyWith(currentFilter: filter);
  }

  Future<void> resetStatistics() async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(statisticsRepositoryProvider);
      await repository.resetAllStatistics();
      await loadStatistics();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to reset statistics: $e',
      );
    }
  }

  Future<void> refresh() => loadStatistics();
}

final filteredStatisticsProvider = Provider<StatisticsModel?>((ref) {
  return ref.watch(statisticsProvider.select((state) => state.filteredStats));
});

final totalGamesCountProvider = Provider<int>((ref) {
  return ref.watch(
    statisticsProvider.select((state) => state.totalStats?.totalGames ?? 0),
  );
});

final statisticsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(statisticsProvider.select((state) => state.isLoading));
});
