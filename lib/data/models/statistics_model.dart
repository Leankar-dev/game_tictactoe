import 'package:equatable/equatable.dart';
import '../../domain/enums/enums.dart';
import '../datasources/local/database.dart';

class StatisticsModel extends Equatable {
  final int? id;
  final BoardSize boardSize;
  final GameMode gameMode;
  final int totalGames;
  final int xWins;
  final int oWins;
  final int draws;
  final int totalMoves;
  final int totalDurationSeconds;
  final int xWinStreak;
  final int oWinStreak;
  final int xBestStreak;
  final int oBestStreak;
  final DateTime updatedAt;

  const StatisticsModel({
    this.id,
    required this.boardSize,
    required this.gameMode,
    required this.totalGames,
    required this.xWins,
    required this.oWins,
    required this.draws,
    required this.totalMoves,
    required this.totalDurationSeconds,
    required this.xWinStreak,
    required this.oWinStreak,
    required this.xBestStreak,
    required this.oBestStreak,
    required this.updatedAt,
  });

  factory StatisticsModel.empty({
    required BoardSize boardSize,
    required GameMode gameMode,
  }) {
    return StatisticsModel(
      boardSize: boardSize,
      gameMode: gameMode,
      totalGames: 0,
      xWins: 0,
      oWins: 0,
      draws: 0,
      totalMoves: 0,
      totalDurationSeconds: 0,
      xWinStreak: 0,
      oWinStreak: 0,
      xBestStreak: 0,
      oBestStreak: 0,
      updatedAt: DateTime.now(),
    );
  }

  factory StatisticsModel.fromRecord(StatisticsRecord record) {
    return StatisticsModel(
      id: record.id,
      boardSize: BoardSize.fromString(record.boardSize),
      gameMode: GameMode.fromString(record.gameMode),
      totalGames: record.totalGames,
      xWins: record.xWins,
      oWins: record.oWins,
      draws: record.draws,
      totalMoves: record.totalMoves,
      totalDurationSeconds: record.totalDurationSeconds,
      xWinStreak: record.xWinStreak,
      oWinStreak: record.oWinStreak,
      xBestStreak: record.xBestStreak,
      oBestStreak: record.oBestStreak,
      updatedAt: record.updatedAt,
    );
  }

  double get xWinRate => totalGames > 0 ? xWins / totalGames : 0.0;

  double get oWinRate => totalGames > 0 ? oWins / totalGames : 0.0;

  double get drawRate => totalGames > 0 ? draws / totalGames : 0.0;

  double get averageMoves => totalGames > 0 ? totalMoves / totalGames : 0.0;

  double get averageDuration =>
      totalGames > 0 ? totalDurationSeconds / totalGames : 0.0;

  String get averageDurationFormatted {
    final avgSeconds = averageDuration.round();
    final minutes = avgSeconds ~/ 60;
    final seconds = avgSeconds % 60;
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  String xWinRatePercent() => '${(xWinRate * 100).toStringAsFixed(1)}%';
  String oWinRatePercent() => '${(oWinRate * 100).toStringAsFixed(1)}%';
  String drawRatePercent() => '${(drawRate * 100).toStringAsFixed(1)}%';

  StatisticsModel copyWith({
    int? id,
    BoardSize? boardSize,
    GameMode? gameMode,
    int? totalGames,
    int? xWins,
    int? oWins,
    int? draws,
    int? totalMoves,
    int? totalDurationSeconds,
    int? xWinStreak,
    int? oWinStreak,
    int? xBestStreak,
    int? oBestStreak,
    DateTime? updatedAt,
  }) {
    return StatisticsModel(
      id: id ?? this.id,
      boardSize: boardSize ?? this.boardSize,
      gameMode: gameMode ?? this.gameMode,
      totalGames: totalGames ?? this.totalGames,
      xWins: xWins ?? this.xWins,
      oWins: oWins ?? this.oWins,
      draws: draws ?? this.draws,
      totalMoves: totalMoves ?? this.totalMoves,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      xWinStreak: xWinStreak ?? this.xWinStreak,
      oWinStreak: oWinStreak ?? this.oWinStreak,
      xBestStreak: xBestStreak ?? this.xBestStreak,
      oBestStreak: oBestStreak ?? this.oBestStreak,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        boardSize,
        gameMode,
        totalGames,
        xWins,
        oWins,
        draws,
        totalMoves,
        totalDurationSeconds,
        xWinStreak,
        oWinStreak,
        xBestStreak,
        oBestStreak,
        updatedAt,
      ];
}
