import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/data/repositories/repositories.dart';
import 'package:game_tictactoe/domain/entities/entities.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

import 'test_database.dart';

void main() {
  late StatisticsRepository statsRepository;
  late GameRepository gameRepository;

  setUp(() async {
    final database = createTestDatabase();
    statsRepository = StatisticsRepository(database);
    gameRepository = GameRepository(database);
  });

  group('StatisticsRepository', () {
    group('getStatistics', () {
      test('should return empty stats when no games played', () async {
        final stats = await statsRepository.getStatistics(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(stats.totalGames, 0);
        expect(stats.xWins, 0);
        expect(stats.oWins, 0);
        expect(stats.draws, 0);
      });

      test('should track wins correctly', () async {
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);
        await _saveGameWithWinner(gameRepository, GameStatus.oWins);
        await _saveGameWithWinner(gameRepository, GameStatus.draw);

        final stats = await statsRepository.getStatistics(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(stats.totalGames, 4);
        expect(stats.xWins, 2);
        expect(stats.oWins, 1);
        expect(stats.draws, 1);
      });

      test('should track separate stats by board size', () async {
        await _saveGameWithWinner(
          gameRepository,
          GameStatus.xWins,
          boardSize: BoardSize.classic,
        );
        await _saveGameWithWinner(
          gameRepository,
          GameStatus.oWins,
          boardSize: BoardSize.extended,
        );

        final classicStats = await statsRepository.getStatistics(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );
        final extendedStats = await statsRepository.getStatistics(
          boardSize: BoardSize.extended,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(classicStats.xWins, 1);
        expect(classicStats.oWins, 0);
        expect(extendedStats.xWins, 0);
        expect(extendedStats.oWins, 1);
      });
    });

    group('computed properties', () {
      test('should calculate win rates correctly', () async {
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);
        await _saveGameWithWinner(gameRepository, GameStatus.oWins);
        await _saveGameWithWinner(gameRepository, GameStatus.draw);

        final stats = await statsRepository.getStatistics(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(stats.xWinRate, 0.5);
        expect(stats.oWinRate, 0.25);
        expect(stats.drawRate, 0.25);
      });
    });

    group('win streaks', () {
      test('should track current win streak', () async {
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);

        final stats = await statsRepository.getStatistics(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(stats.xWinStreak, 3);
        expect(stats.xBestStreak, 3);
      });

      test('should reset streak on loss', () async {
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);
        await _saveGameWithWinner(gameRepository, GameStatus.oWins);

        final stats = await statsRepository.getStatistics(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(stats.xWinStreak, 0);
        expect(stats.xBestStreak, 2);
        expect(stats.oWinStreak, 1);
      });
    });

    group('getTotalStatistics', () {
      test('should combine all stats', () async {
        await _saveGameWithWinner(
          gameRepository,
          GameStatus.xWins,
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );
        await _saveGameWithWinner(
          gameRepository,
          GameStatus.oWins,
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsCpu,
        );
        await _saveGameWithWinner(
          gameRepository,
          GameStatus.draw,
          boardSize: BoardSize.extended,
          gameMode: GameMode.playerVsPlayer,
        );

        final total = await statsRepository.getTotalStatistics();

        expect(total.totalGames, 3);
        expect(total.xWins, 1);
        expect(total.oWins, 1);
        expect(total.draws, 1);
      });
    });

    group('resetAllStatistics', () {
      test('should clear all statistics', () async {
        await _saveGameWithWinner(gameRepository, GameStatus.xWins);
        await _saveGameWithWinner(gameRepository, GameStatus.oWins);

        await statsRepository.resetAllStatistics();

        final stats = await statsRepository.getStatistics(
          boardSize: BoardSize.classic,
          gameMode: GameMode.playerVsPlayer,
        );

        expect(stats.totalGames, 0);
      });
    });
  });
}

Future<void> _saveGameWithWinner(
  GameRepository repository,
  GameStatus winner, {
  BoardSize boardSize = BoardSize.classic,
  GameMode gameMode = GameMode.playerVsPlayer,
}) async {
  var game = GameEntity.newGame(
    boardSize: boardSize,
    mode: gameMode,
  );

  game = game.copyWith(
    status: winner,
    board: BoardEntity.empty(boardSize),
    moveHistory: [
      MoveEntity.create(row: 0, col: 0, player: PlayerType.x, moveNumber: 1),
    ],
  );

  await repository.saveGame(game);
}
