import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '../enums/enums.dart';
import 'board_entity.dart';
import 'move_entity.dart';
import 'player_entity.dart';

class GameEntity extends Equatable {
  final String id;
  final BoardEntity board;
  final PlayerEntity playerX;
  final PlayerEntity playerO;
  final PlayerType currentTurn;
  final GameStatus status;
  final GameMode mode;
  final List<MoveEntity> moveHistory;
  final List<({int row, int col})>? winningCells;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GameEntity({
    required this.id,
    required this.board,
    required this.playerX,
    required this.playerO,
    required this.currentTurn,
    required this.status,
    required this.mode,
    required this.moveHistory,
    this.winningCells,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GameEntity.newGame({
    required BoardSize boardSize,
    required GameMode mode,
    PlayerEntity? playerX,
    PlayerEntity? playerO,
  }) {
    final now = DateTime.now();
    final isCpuGame = mode == GameMode.playerVsCpu;

    return GameEntity(
      id: const Uuid().v4(),
      board: BoardEntity.empty(boardSize),
      playerX: playerX ?? PlayerEntity.playerX(),
      playerO: playerO ?? PlayerEntity.playerO(isCpu: isCpuGame),
      currentTurn: PlayerType.x,
      status: GameStatus.playing,
      mode: mode,
      moveHistory: const [],
      winningCells: null,
      createdAt: now,
      updatedAt: now,
    );
  }

  PlayerEntity get currentPlayer =>
      currentTurn == PlayerType.x ? playerX : playerO;

  bool get isCpuTurn => currentPlayer.isCpu;

  BoardSize get boardSize => board.size;

  int get moveCount => moveHistory.length;

  bool get isGameOver => status.isGameOver;

  bool get hasWinner => status.hasWinner;

  MoveEntity? get lastMove => moveHistory.isNotEmpty ? moveHistory.last : null;

  GameEntity copyWith({
    String? id,
    BoardEntity? board,
    PlayerEntity? playerX,
    PlayerEntity? playerO,
    PlayerType? currentTurn,
    GameStatus? status,
    GameMode? mode,
    List<MoveEntity>? moveHistory,
    List<({int row, int col})>? winningCells,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GameEntity(
      id: id ?? this.id,
      board: board ?? this.board,
      playerX: playerX ?? this.playerX,
      playerO: playerO ?? this.playerO,
      currentTurn: currentTurn ?? this.currentTurn,
      status: status ?? this.status,
      mode: mode ?? this.mode,
      moveHistory: moveHistory ?? this.moveHistory,
      winningCells: winningCells ?? this.winningCells,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        board,
        playerX,
        playerO,
        currentTurn,
        status,
        mode,
        moveHistory,
        winningCells,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() =>
      'GameEntity(id: $id, status: $status, turn: ${currentTurn.symbol}, moves: $moveCount)';
}
