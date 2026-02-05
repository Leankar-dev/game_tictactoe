import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import '../../domain/enums/enums.dart';
import '../datasources/local/database.dart';

enum AiDifficulty {
  easy,
  medium,
  hard;

  String get displayName {
    switch (this) {
      case AiDifficulty.easy:
        return 'Easy';
      case AiDifficulty.medium:
        return 'Medium';
      case AiDifficulty.hard:
        return 'Hard';
    }
  }

  static AiDifficulty fromString(String value) {
    switch (value.toLowerCase()) {
      case 'easy':
        return AiDifficulty.easy;
      case 'hard':
        return AiDifficulty.hard;
      case 'medium':
      default:
        return AiDifficulty.medium;
    }
  }
}

enum AppThemeMode {
  light,
  dark,
  system;

  static AppThemeMode fromString(String value) {
    switch (value.toLowerCase()) {
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
        return AppThemeMode.system;
      case 'light':
      default:
        return AppThemeMode.light;
    }
  }
}

class SettingsModel extends Equatable {
  final bool soundEnabled;
  final bool hapticEnabled;
  final AiDifficulty aiDifficulty;
  final BoardSize defaultBoardSize;
  final GameMode defaultGameMode;
  final AppThemeMode themeMode;
  final String playerXName;
  final String playerOName;
  final DateTime updatedAt;

  const SettingsModel({
    required this.soundEnabled,
    required this.hapticEnabled,
    required this.aiDifficulty,
    required this.defaultBoardSize,
    required this.defaultGameMode,
    required this.themeMode,
    required this.playerXName,
    required this.playerOName,
    required this.updatedAt,
  });

  factory SettingsModel.defaults() {
    return SettingsModel(
      soundEnabled: true,
      hapticEnabled: true,
      aiDifficulty: AiDifficulty.medium,
      defaultBoardSize: BoardSize.classic,
      defaultGameMode: GameMode.playerVsPlayer,
      themeMode: AppThemeMode.light,
      playerXName: 'Player X',
      playerOName: 'Player O',
      updatedAt: DateTime.now(),
    );
  }

  factory SettingsModel.fromRecord(SettingsRecord record) {
    return SettingsModel(
      soundEnabled: record.soundEnabled,
      hapticEnabled: record.hapticEnabled,
      aiDifficulty: AiDifficulty.fromString(record.aiDifficulty),
      defaultBoardSize: BoardSize.fromString(record.defaultBoardSize),
      defaultGameMode: GameMode.fromString(record.defaultGameMode),
      themeMode: AppThemeMode.fromString(record.themeMode),
      playerXName: record.playerXName,
      playerOName: record.playerOName,
      updatedAt: record.updatedAt,
    );
  }

  SettingsCompanion toCompanion() {
    return SettingsCompanion(
      soundEnabled: Value(soundEnabled),
      hapticEnabled: Value(hapticEnabled),
      aiDifficulty: Value(aiDifficulty.name),
      defaultBoardSize: Value(
        defaultBoardSize == BoardSize.classic ? 'classic' : 'extended',
      ),
      defaultGameMode: Value(
        defaultGameMode == GameMode.playerVsPlayer ? 'pvp' : 'pvc',
      ),
      themeMode: Value(themeMode.name),
      playerXName: Value(playerXName),
      playerOName: Value(playerOName),
      updatedAt: Value(DateTime.now()),
    );
  }

  SettingsModel copyWith({
    bool? soundEnabled,
    bool? hapticEnabled,
    AiDifficulty? aiDifficulty,
    BoardSize? defaultBoardSize,
    GameMode? defaultGameMode,
    AppThemeMode? themeMode,
    String? playerXName,
    String? playerOName,
    DateTime? updatedAt,
  }) {
    return SettingsModel(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      hapticEnabled: hapticEnabled ?? this.hapticEnabled,
      aiDifficulty: aiDifficulty ?? this.aiDifficulty,
      defaultBoardSize: defaultBoardSize ?? this.defaultBoardSize,
      defaultGameMode: defaultGameMode ?? this.defaultGameMode,
      themeMode: themeMode ?? this.themeMode,
      playerXName: playerXName ?? this.playerXName,
      playerOName: playerOName ?? this.playerOName,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    soundEnabled,
    hapticEnabled,
    aiDifficulty,
    defaultBoardSize,
    defaultGameMode,
    themeMode,
    playerXName,
    playerOName,
    updatedAt,
  ];
}
