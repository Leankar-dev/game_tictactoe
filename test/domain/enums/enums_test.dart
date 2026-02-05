import 'package:flutter_test/flutter_test.dart';
import 'package:game_tictactoe/domain/enums/enums.dart';

void main() {
  group('PlayerType', () {
    test('should have correct symbols', () {
      expect(PlayerType.x.symbol, 'X');
      expect(PlayerType.o.symbol, 'O');
      expect(PlayerType.none.symbol, '');
    });

    test('should identify players correctly', () {
      expect(PlayerType.x.isPlayer, true);
      expect(PlayerType.o.isPlayer, true);
      expect(PlayerType.none.isPlayer, false);
    });

    test('should return correct opponent', () {
      expect(PlayerType.x.opponent, PlayerType.o);
      expect(PlayerType.o.opponent, PlayerType.x);
      expect(PlayerType.none.opponent, PlayerType.none);
    });
  });

  group('BoardSize', () {
    test('should have correct sizes', () {
      expect(BoardSize.classic.size, 3);
      expect(BoardSize.extended.size, 6);
    });

    test('should have correct total cells', () {
      expect(BoardSize.classic.totalCells, 9);
      expect(BoardSize.extended.totalCells, 36);
    });

    test('should have correct win condition', () {
      expect(BoardSize.classic.winCondition, 3);
      expect(BoardSize.extended.winCondition, 4);
    });

    test('should have display names', () {
      expect(BoardSize.classic.displayName, isNotEmpty);
      expect(BoardSize.extended.displayName, isNotEmpty);
    });

    test('fromString should return correct enum', () {
      expect(BoardSize.fromString('classic'), BoardSize.classic);
      expect(BoardSize.fromString('extended'), BoardSize.extended);
      expect(BoardSize.fromString('invalid'), BoardSize.classic);
    });
  });

  group('GameMode', () {
    test('should have correct values', () {
      expect(GameMode.values.length, 2);
      expect(GameMode.values, contains(GameMode.playerVsPlayer));
      expect(GameMode.values, contains(GameMode.playerVsCpu));
    });

    test('should have display names', () {
      expect(GameMode.playerVsPlayer.displayName, isNotEmpty);
      expect(GameMode.playerVsCpu.displayName, isNotEmpty);
    });

    test('fromString should return correct enum', () {
      expect(GameMode.fromString('pvp'), GameMode.playerVsPlayer);
      expect(GameMode.fromString('pvc'), GameMode.playerVsCpu);
      expect(GameMode.fromString('invalid'), GameMode.playerVsPlayer);
    });
  });

  group('GameStatus', () {
    test('isPlaying should be correct', () {
      expect(GameStatus.playing.isPlaying, true);
      expect(GameStatus.xWins.isPlaying, false);
      expect(GameStatus.oWins.isPlaying, false);
      expect(GameStatus.draw.isPlaying, false);
    });

    test('isGameOver should be correct', () {
      expect(GameStatus.playing.isGameOver, false);
      expect(GameStatus.xWins.isGameOver, true);
      expect(GameStatus.oWins.isGameOver, true);
      expect(GameStatus.draw.isGameOver, true);
    });

    test('hasWinner should be correct', () {
      expect(GameStatus.playing.hasWinner, false);
      expect(GameStatus.xWins.hasWinner, true);
      expect(GameStatus.oWins.hasWinner, true);
      expect(GameStatus.draw.hasWinner, false);
    });

    test('winner should return correct player', () {
      expect(GameStatus.xWins.winner, PlayerType.x);
      expect(GameStatus.oWins.winner, PlayerType.o);
      expect(GameStatus.playing.winner, PlayerType.none);
      expect(GameStatus.draw.winner, PlayerType.none);
    });

    test('fromWinner should return correct status', () {
      expect(GameStatus.fromWinner(PlayerType.x), GameStatus.xWins);
      expect(GameStatus.fromWinner(PlayerType.o), GameStatus.oWins);
      expect(GameStatus.fromWinner(PlayerType.none), GameStatus.playing);
    });
  });
}
