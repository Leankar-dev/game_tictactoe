import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/data/models/statistics_model.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

void main() {
  group('StatisticsModel', () {
    group('empty factory', () {
      test('should create model with zero values', () {
        final stats = StatisticsModel.empty(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(stats.totalGames, 0);
        expect(stats.xWins, 0);
        expect(stats.oWins, 0);
        expect(stats.draws, 0);
        expect(stats.totalMoves, 0);
        expect(stats.totalDurationSeconds, 0);
        expect(stats.xWinStreak, 0);
        expect(stats.oWinStreak, 0);
        expect(stats.xBestStreak, 0);
        expect(stats.oBestStreak, 0);
        expect(stats.boardSize, BoardSize.classic);
        expect(stats.gameMode, GameMode.playerVsPlayer);
      });
    });

    group('win rates', () {
      test('should return 0 for empty stats', () {
        final stats = StatisticsModel.empty(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(stats.xWinRate, 0.0);
        expect(stats.oWinRate, 0.0);
        expect(stats.drawRate, 0.0);
      });

      test('should calculate correct win rates', () {
        final stats = StatisticsModel(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
          totalGames: 10,
          xWins: 5,
          oWins: 3,
          draws: 2,
          totalMoves: 50,
          totalDurationSeconds: 600,
          xWinStreak: 0,
          oWinStreak: 0,
          xBestStreak: 3,
          oBestStreak: 2,
          updatedAt: DateTime.now(),
        );

        expect(stats.xWinRate, 0.5);
        expect(stats.oWinRate, 0.3);
        expect(stats.drawRate, 0.2);
      });
    });

    group('averages', () {
      test('should return 0 for empty stats', () {
        final stats = StatisticsModel.empty(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(stats.averageMoves, 0.0);
        expect(stats.averageDuration, 0.0);
      });

      test('should calculate correct averages', () {
        final stats = StatisticsModel(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
          totalGames: 10,
          xWins: 5,
          oWins: 3,
          draws: 2,
          totalMoves: 80,
          totalDurationSeconds: 600,
          xWinStreak: 0,
          oWinStreak: 0,
          xBestStreak: 3,
          oBestStreak: 2,
          updatedAt: DateTime.now(),
        );

        expect(stats.averageMoves, 8.0);
        expect(stats.averageDuration, 60.0);
      });
    });

    group('averageDurationFormatted', () {
      test('should format seconds only', () {
        final stats = StatisticsModel(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
          totalGames: 1,
          xWins: 1,
          oWins: 0,
          draws: 0,
          totalMoves: 5,
          totalDurationSeconds: 45,
          xWinStreak: 1,
          oWinStreak: 0,
          xBestStreak: 1,
          oBestStreak: 0,
          updatedAt: DateTime.now(),
        );

        expect(stats.averageDurationFormatted, '45s');
      });

      test('should format minutes and seconds', () {
        final stats = StatisticsModel(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
          totalGames: 1,
          xWins: 1,
          oWins: 0,
          draws: 0,
          totalMoves: 5,
          totalDurationSeconds: 90,
          xWinStreak: 1,
          oWinStreak: 0,
          xBestStreak: 1,
          oBestStreak: 0,
          updatedAt: DateTime.now(),
        );

        expect(stats.averageDurationFormatted, '1m 30s');
      });
    });

    group('win rate percent', () {
      test('should format percentages correctly', () {
        final stats = StatisticsModel(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
          totalGames: 10,
          xWins: 5,
          oWins: 3,
          draws: 2,
          totalMoves: 50,
          totalDurationSeconds: 600,
          xWinStreak: 0,
          oWinStreak: 0,
          xBestStreak: 3,
          oBestStreak: 2,
          updatedAt: DateTime.now(),
        );

        expect(stats.xWinRatePercent(), '50.0%');
        expect(stats.oWinRatePercent(), '30.0%');
        expect(stats.drawRatePercent(), '20.0%');
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        final original = StatisticsModel.empty(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        final updated = original.copyWith(totalGames: 5, xWins: 3);

        expect(updated.totalGames, 5);
        expect(updated.xWins, 3);
        expect(updated.oWins, original.oWins);
        expect(updated.boardSize, original.boardSize);
      });

      test('should preserve unmodified fields', () {
        final original = StatisticsModel(
          boardSize: BoardSize.extended,
          gameMode: GameMode.playerVsCpu,
          totalGames: 10,
          xWins: 5,
          oWins: 3,
          draws: 2,
          totalMoves: 50,
          totalDurationSeconds: 600,
          xWinStreak: 2,
          oWinStreak: 1,
          xBestStreak: 4,
          oBestStreak: 3,
          updatedAt: DateTime.now(),
        );

        final updated = original.copyWith(draws: 3);

        expect(updated.boardSize, BoardSize.extended);
        expect(updated.gameMode, GameMode.playerVsCpu);
        expect(updated.totalGames, 10);
        expect(updated.draws, 3);
      });
    });

    group('equality', () {
      test('should be equal for same values', () {
        final timestamp = DateTime(2024, 1, 1);
        final stats1 = StatisticsModel(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
          totalGames: 10,
          xWins: 5,
          oWins: 3,
          draws: 2,
          totalMoves: 50,
          totalDurationSeconds: 600,
          xWinStreak: 0,
          oWinStreak: 0,
          xBestStreak: 3,
          oBestStreak: 2,
          updatedAt: timestamp,
        );

        final stats2 = StatisticsModel(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
          totalGames: 10,
          xWins: 5,
          oWins: 3,
          draws: 2,
          totalMoves: 50,
          totalDurationSeconds: 600,
          xWinStreak: 0,
          oWinStreak: 0,
          xBestStreak: 3,
          oBestStreak: 2,
          updatedAt: timestamp,
        );

        expect(stats1, equals(stats2));
      });
    });
  });
}
