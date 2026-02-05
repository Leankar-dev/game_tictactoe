import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/entities.dart';
import '../../domain/enums/enums.dart';
import '../datasources/local/database.dart';

class GameModel extends Equatable {
  final String id;
  final BoardSize boardSize;
  final GameMode gameMode;
  final GameStatus status;
  final int movesCount;
  final int durationSeconds;
  final List<MoveModel> moveHistory;
  final DateTime createdAt;
  final DateTime? completedAt;

  const GameModel({
    required this.id,
    required this.boardSize,
    required this.gameMode,
    required this.status,
    required this.movesCount,
    required this.durationSeconds,
    required this.moveHistory,
    required this.createdAt,
    this.completedAt,
  });

  factory GameModel.fromRecord(GameRecord record) {
    final moveHistoryJson = jsonDecode(record.moveHistory) as List<dynamic>;
    final moves = moveHistoryJson
        .map((json) => MoveModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return GameModel(
      id: record.id,
      boardSize: BoardSize.fromString(record.boardSize),
      gameMode: GameMode.fromString(record.gameMode),
      status: _parseWinnerToStatus(record.winner),
      movesCount: record.movesCount,
      durationSeconds: record.durationSeconds,
      moveHistory: moves,
      createdAt: record.createdAt,
      completedAt: record.completedAt,
    );
  }

  factory GameModel.fromEntity(GameEntity entity) {
    return GameModel(
      id: entity.id,
      boardSize: entity.boardSize,
      gameMode: entity.mode,
      status: entity.status,
      movesCount: entity.moveCount,
      durationSeconds: entity.updatedAt.difference(entity.createdAt).inSeconds,
      moveHistory: entity.moveHistory.map(MoveModel.fromEntity).toList(),
      createdAt: entity.createdAt,
      completedAt: entity.isGameOver ? entity.updatedAt : null,
    );
  }

  GamesCompanion toCompanion() {
    return GamesCompanion.insert(
      id: id,
      boardSize: _boardSizeToString(boardSize),
      gameMode: _gameModeToString(gameMode),
      winner: _statusToWinner(status),
      movesCount: movesCount,
      durationSeconds: Value(durationSeconds),
      moveHistory: Value(
        jsonEncode(moveHistory.map((m) => m.toJson()).toList()),
      ),
      createdAt: createdAt,
      completedAt: Value(completedAt),
    );
  }

  GameEntity toEntity() {
    final board = _reconstructBoard();

    return GameEntity(
      id: id,
      board: board,
      playerX: PlayerEntity.playerX(),
      playerO: PlayerEntity.playerO(isCpu: gameMode == GameMode.playerVsCpu),
      currentTurn: _determineCurrentTurn(),
      status: status,
      mode: gameMode,
      moveHistory: moveHistory.map((m) => m.toEntity()).toList(),
      winningCells: null,
      createdAt: createdAt,
      updatedAt: completedAt ?? createdAt,
    );
  }

  BoardEntity _reconstructBoard() {
    var board = BoardEntity.empty(boardSize);
    for (final move in moveHistory) {
      board = board.withMove(move.row, move.col, move.player);
    }
    return board;
  }

  PlayerType _determineCurrentTurn() {
    if (status.isGameOver) return PlayerType.none;
    return moveHistory.length.isEven ? PlayerType.x : PlayerType.o;
  }

  static GameStatus _parseWinnerToStatus(String winner) {
    switch (winner.toLowerCase()) {
      case 'x':
        return GameStatus.xWins;
      case 'o':
        return GameStatus.oWins;
      case 'draw':
        return GameStatus.draw;
      default:
        return GameStatus.playing;
    }
  }

  static String _statusToWinner(GameStatus status) {
    switch (status) {
      case GameStatus.xWins:
        return 'x';
      case GameStatus.oWins:
        return 'o';
      case GameStatus.draw:
        return 'draw';
      case GameStatus.playing:
        return 'none';
    }
  }

  static String _boardSizeToString(BoardSize size) {
    return size == BoardSize.classic ? 'classic' : 'extended';
  }

  static String _gameModeToString(GameMode mode) {
    return mode == GameMode.playerVsPlayer ? 'pvp' : 'pvc';
  }

  @override
  List<Object?> get props => [
    id,
    boardSize,
    gameMode,
    status,
    movesCount,
    durationSeconds,
    moveHistory,
    createdAt,
    completedAt,
  ];
}

class MoveModel extends Equatable {
  final int row;
  final int col;
  final PlayerType player;
  final int moveNumber;
  final DateTime? timestamp;

  const MoveModel({
    required this.row,
    required this.col,
    required this.player,
    required this.moveNumber,
    this.timestamp,
  });

  factory MoveModel.fromJson(Map<String, dynamic> json) {
    return MoveModel(
      row: json['row'] as int,
      col: json['col'] as int,
      player: PlayerType.fromString(json['player'] as String),
      moveNumber: json['moveNumber'] as int,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }

  factory MoveModel.fromEntity(MoveEntity entity) {
    return MoveModel(
      row: entity.row,
      col: entity.col,
      player: entity.player,
      moveNumber: entity.moveNumber,
      timestamp: entity.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'row': row,
      'col': col,
      'player': player.symbol,
      'moveNumber': moveNumber,
      if (timestamp != null) 'timestamp': timestamp!.toIso8601String(),
    };
  }

  MoveEntity toEntity() {
    return MoveEntity(
      row: row,
      col: col,
      player: player,
      moveNumber: moveNumber,
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [row, col, player, moveNumber, timestamp];
}
