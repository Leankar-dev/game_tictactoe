import 'package:equatable/equatable.dart';
import '../enums/player_type.dart';

class MoveEntity extends Equatable {
  final int row;
  final int col;
  final PlayerType player;
  final int moveNumber;
  final DateTime timestamp;

  const MoveEntity({
    required this.row,
    required this.col,
    required this.player,
    required this.moveNumber,
    required this.timestamp,
  });

  factory MoveEntity.create({
    required int row,
    required int col,
    required PlayerType player,
    required int moveNumber,
  }) {
    return MoveEntity(
      row: row,
      col: col,
      player: player,
      moveNumber: moveNumber,
      timestamp: DateTime.now(),
    );
  }

  String get positionString => '($row, $col)';

  MoveEntity copyWith({
    int? row,
    int? col,
    PlayerType? player,
    int? moveNumber,
    DateTime? timestamp,
  }) {
    return MoveEntity(
      row: row ?? this.row,
      col: col ?? this.col,
      player: player ?? this.player,
      moveNumber: moveNumber ?? this.moveNumber,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [row, col, player, moveNumber, timestamp];

  @override
  String toString() =>
      'MoveEntity(row: $row, col: $col, player: ${player.symbol}, moveNumber: $moveNumber)';
}
