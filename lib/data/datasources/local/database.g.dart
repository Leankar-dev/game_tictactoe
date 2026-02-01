// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GamesTable extends Games with TableInfo<$GamesTable, GameRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _boardSizeMeta = const VerificationMeta(
    'boardSize',
  );
  @override
  late final GeneratedColumn<String> boardSize = GeneratedColumn<String>(
    'board_size',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameModeMeta = const VerificationMeta(
    'gameMode',
  );
  @override
  late final GeneratedColumn<String> gameMode = GeneratedColumn<String>(
    'game_mode',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _winnerMeta = const VerificationMeta('winner');
  @override
  late final GeneratedColumn<String> winner = GeneratedColumn<String>(
    'winner',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _movesCountMeta = const VerificationMeta(
    'movesCount',
  );
  @override
  late final GeneratedColumn<int> movesCount = GeneratedColumn<int>(
    'moves_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _moveHistoryMeta = const VerificationMeta(
    'moveHistory',
  );
  @override
  late final GeneratedColumn<String> moveHistory = GeneratedColumn<String>(
    'move_history',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    boardSize,
    gameMode,
    winner,
    movesCount,
    durationSeconds,
    moveHistory,
    createdAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'games';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('board_size')) {
      context.handle(
        _boardSizeMeta,
        boardSize.isAcceptableOrUnknown(data['board_size']!, _boardSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_boardSizeMeta);
    }
    if (data.containsKey('game_mode')) {
      context.handle(
        _gameModeMeta,
        gameMode.isAcceptableOrUnknown(data['game_mode']!, _gameModeMeta),
      );
    } else if (isInserting) {
      context.missing(_gameModeMeta);
    }
    if (data.containsKey('winner')) {
      context.handle(
        _winnerMeta,
        winner.isAcceptableOrUnknown(data['winner']!, _winnerMeta),
      );
    } else if (isInserting) {
      context.missing(_winnerMeta);
    }
    if (data.containsKey('moves_count')) {
      context.handle(
        _movesCountMeta,
        movesCount.isAcceptableOrUnknown(data['moves_count']!, _movesCountMeta),
      );
    } else if (isInserting) {
      context.missing(_movesCountMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('move_history')) {
      context.handle(
        _moveHistoryMeta,
        moveHistory.isAcceptableOrUnknown(
          data['move_history']!,
          _moveHistoryMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      boardSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_size'],
      )!,
      gameMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_mode'],
      )!,
      winner: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}winner'],
      )!,
      movesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}moves_count'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      moveHistory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}move_history'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $GamesTable createAlias(String alias) {
    return $GamesTable(attachedDatabase, alias);
  }
}

class GameRecord extends DataClass implements Insertable<GameRecord> {
  final String id;
  final String boardSize;
  final String gameMode;
  final String winner;
  final int movesCount;
  final int durationSeconds;
  final String moveHistory;
  final DateTime createdAt;
  final DateTime? completedAt;
  const GameRecord({
    required this.id,
    required this.boardSize,
    required this.gameMode,
    required this.winner,
    required this.movesCount,
    required this.durationSeconds,
    required this.moveHistory,
    required this.createdAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['board_size'] = Variable<String>(boardSize);
    map['game_mode'] = Variable<String>(gameMode);
    map['winner'] = Variable<String>(winner);
    map['moves_count'] = Variable<int>(movesCount);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['move_history'] = Variable<String>(moveHistory);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  GamesCompanion toCompanion(bool nullToAbsent) {
    return GamesCompanion(
      id: Value(id),
      boardSize: Value(boardSize),
      gameMode: Value(gameMode),
      winner: Value(winner),
      movesCount: Value(movesCount),
      durationSeconds: Value(durationSeconds),
      moveHistory: Value(moveHistory),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory GameRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameRecord(
      id: serializer.fromJson<String>(json['id']),
      boardSize: serializer.fromJson<String>(json['boardSize']),
      gameMode: serializer.fromJson<String>(json['gameMode']),
      winner: serializer.fromJson<String>(json['winner']),
      movesCount: serializer.fromJson<int>(json['movesCount']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      moveHistory: serializer.fromJson<String>(json['moveHistory']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'boardSize': serializer.toJson<String>(boardSize),
      'gameMode': serializer.toJson<String>(gameMode),
      'winner': serializer.toJson<String>(winner),
      'movesCount': serializer.toJson<int>(movesCount),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'moveHistory': serializer.toJson<String>(moveHistory),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  GameRecord copyWith({
    String? id,
    String? boardSize,
    String? gameMode,
    String? winner,
    int? movesCount,
    int? durationSeconds,
    String? moveHistory,
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => GameRecord(
    id: id ?? this.id,
    boardSize: boardSize ?? this.boardSize,
    gameMode: gameMode ?? this.gameMode,
    winner: winner ?? this.winner,
    movesCount: movesCount ?? this.movesCount,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    moveHistory: moveHistory ?? this.moveHistory,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  GameRecord copyWithCompanion(GamesCompanion data) {
    return GameRecord(
      id: data.id.present ? data.id.value : this.id,
      boardSize: data.boardSize.present ? data.boardSize.value : this.boardSize,
      gameMode: data.gameMode.present ? data.gameMode.value : this.gameMode,
      winner: data.winner.present ? data.winner.value : this.winner,
      movesCount: data.movesCount.present
          ? data.movesCount.value
          : this.movesCount,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      moveHistory: data.moveHistory.present
          ? data.moveHistory.value
          : this.moveHistory,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameRecord(')
          ..write('id: $id, ')
          ..write('boardSize: $boardSize, ')
          ..write('gameMode: $gameMode, ')
          ..write('winner: $winner, ')
          ..write('movesCount: $movesCount, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('moveHistory: $moveHistory, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    boardSize,
    gameMode,
    winner,
    movesCount,
    durationSeconds,
    moveHistory,
    createdAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameRecord &&
          other.id == this.id &&
          other.boardSize == this.boardSize &&
          other.gameMode == this.gameMode &&
          other.winner == this.winner &&
          other.movesCount == this.movesCount &&
          other.durationSeconds == this.durationSeconds &&
          other.moveHistory == this.moveHistory &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class GamesCompanion extends UpdateCompanion<GameRecord> {
  final Value<String> id;
  final Value<String> boardSize;
  final Value<String> gameMode;
  final Value<String> winner;
  final Value<int> movesCount;
  final Value<int> durationSeconds;
  final Value<String> moveHistory;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const GamesCompanion({
    this.id = const Value.absent(),
    this.boardSize = const Value.absent(),
    this.gameMode = const Value.absent(),
    this.winner = const Value.absent(),
    this.movesCount = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.moveHistory = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GamesCompanion.insert({
    required String id,
    required String boardSize,
    required String gameMode,
    required String winner,
    required int movesCount,
    this.durationSeconds = const Value.absent(),
    this.moveHistory = const Value.absent(),
    required DateTime createdAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       boardSize = Value(boardSize),
       gameMode = Value(gameMode),
       winner = Value(winner),
       movesCount = Value(movesCount),
       createdAt = Value(createdAt);
  static Insertable<GameRecord> custom({
    Expression<String>? id,
    Expression<String>? boardSize,
    Expression<String>? gameMode,
    Expression<String>? winner,
    Expression<int>? movesCount,
    Expression<int>? durationSeconds,
    Expression<String>? moveHistory,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (boardSize != null) 'board_size': boardSize,
      if (gameMode != null) 'game_mode': gameMode,
      if (winner != null) 'winner': winner,
      if (movesCount != null) 'moves_count': movesCount,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (moveHistory != null) 'move_history': moveHistory,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GamesCompanion copyWith({
    Value<String>? id,
    Value<String>? boardSize,
    Value<String>? gameMode,
    Value<String>? winner,
    Value<int>? movesCount,
    Value<int>? durationSeconds,
    Value<String>? moveHistory,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return GamesCompanion(
      id: id ?? this.id,
      boardSize: boardSize ?? this.boardSize,
      gameMode: gameMode ?? this.gameMode,
      winner: winner ?? this.winner,
      movesCount: movesCount ?? this.movesCount,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      moveHistory: moveHistory ?? this.moveHistory,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (boardSize.present) {
      map['board_size'] = Variable<String>(boardSize.value);
    }
    if (gameMode.present) {
      map['game_mode'] = Variable<String>(gameMode.value);
    }
    if (winner.present) {
      map['winner'] = Variable<String>(winner.value);
    }
    if (movesCount.present) {
      map['moves_count'] = Variable<int>(movesCount.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (moveHistory.present) {
      map['move_history'] = Variable<String>(moveHistory.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GamesCompanion(')
          ..write('id: $id, ')
          ..write('boardSize: $boardSize, ')
          ..write('gameMode: $gameMode, ')
          ..write('winner: $winner, ')
          ..write('movesCount: $movesCount, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('moveHistory: $moveHistory, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StatisticsTable extends Statistics
    with TableInfo<$StatisticsTable, StatisticsRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatisticsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _boardSizeMeta = const VerificationMeta(
    'boardSize',
  );
  @override
  late final GeneratedColumn<String> boardSize = GeneratedColumn<String>(
    'board_size',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameModeMeta = const VerificationMeta(
    'gameMode',
  );
  @override
  late final GeneratedColumn<String> gameMode = GeneratedColumn<String>(
    'game_mode',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalGamesMeta = const VerificationMeta(
    'totalGames',
  );
  @override
  late final GeneratedColumn<int> totalGames = GeneratedColumn<int>(
    'total_games',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _xWinsMeta = const VerificationMeta('xWins');
  @override
  late final GeneratedColumn<int> xWins = GeneratedColumn<int>(
    'x_wins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _oWinsMeta = const VerificationMeta('oWins');
  @override
  late final GeneratedColumn<int> oWins = GeneratedColumn<int>(
    'o_wins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _drawsMeta = const VerificationMeta('draws');
  @override
  late final GeneratedColumn<int> draws = GeneratedColumn<int>(
    'draws',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalMovesMeta = const VerificationMeta(
    'totalMoves',
  );
  @override
  late final GeneratedColumn<int> totalMoves = GeneratedColumn<int>(
    'total_moves',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalDurationSecondsMeta =
      const VerificationMeta('totalDurationSeconds');
  @override
  late final GeneratedColumn<int> totalDurationSeconds = GeneratedColumn<int>(
    'total_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _xWinStreakMeta = const VerificationMeta(
    'xWinStreak',
  );
  @override
  late final GeneratedColumn<int> xWinStreak = GeneratedColumn<int>(
    'x_win_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _oWinStreakMeta = const VerificationMeta(
    'oWinStreak',
  );
  @override
  late final GeneratedColumn<int> oWinStreak = GeneratedColumn<int>(
    'o_win_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _xBestStreakMeta = const VerificationMeta(
    'xBestStreak',
  );
  @override
  late final GeneratedColumn<int> xBestStreak = GeneratedColumn<int>(
    'x_best_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _oBestStreakMeta = const VerificationMeta(
    'oBestStreak',
  );
  @override
  late final GeneratedColumn<int> oBestStreak = GeneratedColumn<int>(
    'o_best_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'statistics';
  @override
  VerificationContext validateIntegrity(
    Insertable<StatisticsRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('board_size')) {
      context.handle(
        _boardSizeMeta,
        boardSize.isAcceptableOrUnknown(data['board_size']!, _boardSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_boardSizeMeta);
    }
    if (data.containsKey('game_mode')) {
      context.handle(
        _gameModeMeta,
        gameMode.isAcceptableOrUnknown(data['game_mode']!, _gameModeMeta),
      );
    } else if (isInserting) {
      context.missing(_gameModeMeta);
    }
    if (data.containsKey('total_games')) {
      context.handle(
        _totalGamesMeta,
        totalGames.isAcceptableOrUnknown(data['total_games']!, _totalGamesMeta),
      );
    }
    if (data.containsKey('x_wins')) {
      context.handle(
        _xWinsMeta,
        xWins.isAcceptableOrUnknown(data['x_wins']!, _xWinsMeta),
      );
    }
    if (data.containsKey('o_wins')) {
      context.handle(
        _oWinsMeta,
        oWins.isAcceptableOrUnknown(data['o_wins']!, _oWinsMeta),
      );
    }
    if (data.containsKey('draws')) {
      context.handle(
        _drawsMeta,
        draws.isAcceptableOrUnknown(data['draws']!, _drawsMeta),
      );
    }
    if (data.containsKey('total_moves')) {
      context.handle(
        _totalMovesMeta,
        totalMoves.isAcceptableOrUnknown(data['total_moves']!, _totalMovesMeta),
      );
    }
    if (data.containsKey('total_duration_seconds')) {
      context.handle(
        _totalDurationSecondsMeta,
        totalDurationSeconds.isAcceptableOrUnknown(
          data['total_duration_seconds']!,
          _totalDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('x_win_streak')) {
      context.handle(
        _xWinStreakMeta,
        xWinStreak.isAcceptableOrUnknown(
          data['x_win_streak']!,
          _xWinStreakMeta,
        ),
      );
    }
    if (data.containsKey('o_win_streak')) {
      context.handle(
        _oWinStreakMeta,
        oWinStreak.isAcceptableOrUnknown(
          data['o_win_streak']!,
          _oWinStreakMeta,
        ),
      );
    }
    if (data.containsKey('x_best_streak')) {
      context.handle(
        _xBestStreakMeta,
        xBestStreak.isAcceptableOrUnknown(
          data['x_best_streak']!,
          _xBestStreakMeta,
        ),
      );
    }
    if (data.containsKey('o_best_streak')) {
      context.handle(
        _oBestStreakMeta,
        oBestStreak.isAcceptableOrUnknown(
          data['o_best_streak']!,
          _oBestStreakMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {boardSize, gameMode},
  ];
  @override
  StatisticsRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatisticsRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      boardSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_size'],
      )!,
      gameMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_mode'],
      )!,
      totalGames: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_games'],
      )!,
      xWins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}x_wins'],
      )!,
      oWins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}o_wins'],
      )!,
      draws: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}draws'],
      )!,
      totalMoves: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_moves'],
      )!,
      totalDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_duration_seconds'],
      )!,
      xWinStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}x_win_streak'],
      )!,
      oWinStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}o_win_streak'],
      )!,
      xBestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}x_best_streak'],
      )!,
      oBestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}o_best_streak'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StatisticsTable createAlias(String alias) {
    return $StatisticsTable(attachedDatabase, alias);
  }
}

class StatisticsRecord extends DataClass
    implements Insertable<StatisticsRecord> {
  final int id;
  final String boardSize;
  final String gameMode;
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
  const StatisticsRecord({
    required this.id,
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['board_size'] = Variable<String>(boardSize);
    map['game_mode'] = Variable<String>(gameMode);
    map['total_games'] = Variable<int>(totalGames);
    map['x_wins'] = Variable<int>(xWins);
    map['o_wins'] = Variable<int>(oWins);
    map['draws'] = Variable<int>(draws);
    map['total_moves'] = Variable<int>(totalMoves);
    map['total_duration_seconds'] = Variable<int>(totalDurationSeconds);
    map['x_win_streak'] = Variable<int>(xWinStreak);
    map['o_win_streak'] = Variable<int>(oWinStreak);
    map['x_best_streak'] = Variable<int>(xBestStreak);
    map['o_best_streak'] = Variable<int>(oBestStreak);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StatisticsCompanion toCompanion(bool nullToAbsent) {
    return StatisticsCompanion(
      id: Value(id),
      boardSize: Value(boardSize),
      gameMode: Value(gameMode),
      totalGames: Value(totalGames),
      xWins: Value(xWins),
      oWins: Value(oWins),
      draws: Value(draws),
      totalMoves: Value(totalMoves),
      totalDurationSeconds: Value(totalDurationSeconds),
      xWinStreak: Value(xWinStreak),
      oWinStreak: Value(oWinStreak),
      xBestStreak: Value(xBestStreak),
      oBestStreak: Value(oBestStreak),
      updatedAt: Value(updatedAt),
    );
  }

  factory StatisticsRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatisticsRecord(
      id: serializer.fromJson<int>(json['id']),
      boardSize: serializer.fromJson<String>(json['boardSize']),
      gameMode: serializer.fromJson<String>(json['gameMode']),
      totalGames: serializer.fromJson<int>(json['totalGames']),
      xWins: serializer.fromJson<int>(json['xWins']),
      oWins: serializer.fromJson<int>(json['oWins']),
      draws: serializer.fromJson<int>(json['draws']),
      totalMoves: serializer.fromJson<int>(json['totalMoves']),
      totalDurationSeconds: serializer.fromJson<int>(
        json['totalDurationSeconds'],
      ),
      xWinStreak: serializer.fromJson<int>(json['xWinStreak']),
      oWinStreak: serializer.fromJson<int>(json['oWinStreak']),
      xBestStreak: serializer.fromJson<int>(json['xBestStreak']),
      oBestStreak: serializer.fromJson<int>(json['oBestStreak']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'boardSize': serializer.toJson<String>(boardSize),
      'gameMode': serializer.toJson<String>(gameMode),
      'totalGames': serializer.toJson<int>(totalGames),
      'xWins': serializer.toJson<int>(xWins),
      'oWins': serializer.toJson<int>(oWins),
      'draws': serializer.toJson<int>(draws),
      'totalMoves': serializer.toJson<int>(totalMoves),
      'totalDurationSeconds': serializer.toJson<int>(totalDurationSeconds),
      'xWinStreak': serializer.toJson<int>(xWinStreak),
      'oWinStreak': serializer.toJson<int>(oWinStreak),
      'xBestStreak': serializer.toJson<int>(xBestStreak),
      'oBestStreak': serializer.toJson<int>(oBestStreak),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StatisticsRecord copyWith({
    int? id,
    String? boardSize,
    String? gameMode,
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
  }) => StatisticsRecord(
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
  StatisticsRecord copyWithCompanion(StatisticsCompanion data) {
    return StatisticsRecord(
      id: data.id.present ? data.id.value : this.id,
      boardSize: data.boardSize.present ? data.boardSize.value : this.boardSize,
      gameMode: data.gameMode.present ? data.gameMode.value : this.gameMode,
      totalGames: data.totalGames.present
          ? data.totalGames.value
          : this.totalGames,
      xWins: data.xWins.present ? data.xWins.value : this.xWins,
      oWins: data.oWins.present ? data.oWins.value : this.oWins,
      draws: data.draws.present ? data.draws.value : this.draws,
      totalMoves: data.totalMoves.present
          ? data.totalMoves.value
          : this.totalMoves,
      totalDurationSeconds: data.totalDurationSeconds.present
          ? data.totalDurationSeconds.value
          : this.totalDurationSeconds,
      xWinStreak: data.xWinStreak.present
          ? data.xWinStreak.value
          : this.xWinStreak,
      oWinStreak: data.oWinStreak.present
          ? data.oWinStreak.value
          : this.oWinStreak,
      xBestStreak: data.xBestStreak.present
          ? data.xBestStreak.value
          : this.xBestStreak,
      oBestStreak: data.oBestStreak.present
          ? data.oBestStreak.value
          : this.oBestStreak,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StatisticsRecord(')
          ..write('id: $id, ')
          ..write('boardSize: $boardSize, ')
          ..write('gameMode: $gameMode, ')
          ..write('totalGames: $totalGames, ')
          ..write('xWins: $xWins, ')
          ..write('oWins: $oWins, ')
          ..write('draws: $draws, ')
          ..write('totalMoves: $totalMoves, ')
          ..write('totalDurationSeconds: $totalDurationSeconds, ')
          ..write('xWinStreak: $xWinStreak, ')
          ..write('oWinStreak: $oWinStreak, ')
          ..write('xBestStreak: $xBestStreak, ')
          ..write('oBestStreak: $oBestStreak, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatisticsRecord &&
          other.id == this.id &&
          other.boardSize == this.boardSize &&
          other.gameMode == this.gameMode &&
          other.totalGames == this.totalGames &&
          other.xWins == this.xWins &&
          other.oWins == this.oWins &&
          other.draws == this.draws &&
          other.totalMoves == this.totalMoves &&
          other.totalDurationSeconds == this.totalDurationSeconds &&
          other.xWinStreak == this.xWinStreak &&
          other.oWinStreak == this.oWinStreak &&
          other.xBestStreak == this.xBestStreak &&
          other.oBestStreak == this.oBestStreak &&
          other.updatedAt == this.updatedAt);
}

class StatisticsCompanion extends UpdateCompanion<StatisticsRecord> {
  final Value<int> id;
  final Value<String> boardSize;
  final Value<String> gameMode;
  final Value<int> totalGames;
  final Value<int> xWins;
  final Value<int> oWins;
  final Value<int> draws;
  final Value<int> totalMoves;
  final Value<int> totalDurationSeconds;
  final Value<int> xWinStreak;
  final Value<int> oWinStreak;
  final Value<int> xBestStreak;
  final Value<int> oBestStreak;
  final Value<DateTime> updatedAt;
  const StatisticsCompanion({
    this.id = const Value.absent(),
    this.boardSize = const Value.absent(),
    this.gameMode = const Value.absent(),
    this.totalGames = const Value.absent(),
    this.xWins = const Value.absent(),
    this.oWins = const Value.absent(),
    this.draws = const Value.absent(),
    this.totalMoves = const Value.absent(),
    this.totalDurationSeconds = const Value.absent(),
    this.xWinStreak = const Value.absent(),
    this.oWinStreak = const Value.absent(),
    this.xBestStreak = const Value.absent(),
    this.oBestStreak = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StatisticsCompanion.insert({
    this.id = const Value.absent(),
    required String boardSize,
    required String gameMode,
    this.totalGames = const Value.absent(),
    this.xWins = const Value.absent(),
    this.oWins = const Value.absent(),
    this.draws = const Value.absent(),
    this.totalMoves = const Value.absent(),
    this.totalDurationSeconds = const Value.absent(),
    this.xWinStreak = const Value.absent(),
    this.oWinStreak = const Value.absent(),
    this.xBestStreak = const Value.absent(),
    this.oBestStreak = const Value.absent(),
    required DateTime updatedAt,
  }) : boardSize = Value(boardSize),
       gameMode = Value(gameMode),
       updatedAt = Value(updatedAt);
  static Insertable<StatisticsRecord> custom({
    Expression<int>? id,
    Expression<String>? boardSize,
    Expression<String>? gameMode,
    Expression<int>? totalGames,
    Expression<int>? xWins,
    Expression<int>? oWins,
    Expression<int>? draws,
    Expression<int>? totalMoves,
    Expression<int>? totalDurationSeconds,
    Expression<int>? xWinStreak,
    Expression<int>? oWinStreak,
    Expression<int>? xBestStreak,
    Expression<int>? oBestStreak,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (boardSize != null) 'board_size': boardSize,
      if (gameMode != null) 'game_mode': gameMode,
      if (totalGames != null) 'total_games': totalGames,
      if (xWins != null) 'x_wins': xWins,
      if (oWins != null) 'o_wins': oWins,
      if (draws != null) 'draws': draws,
      if (totalMoves != null) 'total_moves': totalMoves,
      if (totalDurationSeconds != null)
        'total_duration_seconds': totalDurationSeconds,
      if (xWinStreak != null) 'x_win_streak': xWinStreak,
      if (oWinStreak != null) 'o_win_streak': oWinStreak,
      if (xBestStreak != null) 'x_best_streak': xBestStreak,
      if (oBestStreak != null) 'o_best_streak': oBestStreak,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StatisticsCompanion copyWith({
    Value<int>? id,
    Value<String>? boardSize,
    Value<String>? gameMode,
    Value<int>? totalGames,
    Value<int>? xWins,
    Value<int>? oWins,
    Value<int>? draws,
    Value<int>? totalMoves,
    Value<int>? totalDurationSeconds,
    Value<int>? xWinStreak,
    Value<int>? oWinStreak,
    Value<int>? xBestStreak,
    Value<int>? oBestStreak,
    Value<DateTime>? updatedAt,
  }) {
    return StatisticsCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (boardSize.present) {
      map['board_size'] = Variable<String>(boardSize.value);
    }
    if (gameMode.present) {
      map['game_mode'] = Variable<String>(gameMode.value);
    }
    if (totalGames.present) {
      map['total_games'] = Variable<int>(totalGames.value);
    }
    if (xWins.present) {
      map['x_wins'] = Variable<int>(xWins.value);
    }
    if (oWins.present) {
      map['o_wins'] = Variable<int>(oWins.value);
    }
    if (draws.present) {
      map['draws'] = Variable<int>(draws.value);
    }
    if (totalMoves.present) {
      map['total_moves'] = Variable<int>(totalMoves.value);
    }
    if (totalDurationSeconds.present) {
      map['total_duration_seconds'] = Variable<int>(totalDurationSeconds.value);
    }
    if (xWinStreak.present) {
      map['x_win_streak'] = Variable<int>(xWinStreak.value);
    }
    if (oWinStreak.present) {
      map['o_win_streak'] = Variable<int>(oWinStreak.value);
    }
    if (xBestStreak.present) {
      map['x_best_streak'] = Variable<int>(xBestStreak.value);
    }
    if (oBestStreak.present) {
      map['o_best_streak'] = Variable<int>(oBestStreak.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatisticsCompanion(')
          ..write('id: $id, ')
          ..write('boardSize: $boardSize, ')
          ..write('gameMode: $gameMode, ')
          ..write('totalGames: $totalGames, ')
          ..write('xWins: $xWins, ')
          ..write('oWins: $oWins, ')
          ..write('draws: $draws, ')
          ..write('totalMoves: $totalMoves, ')
          ..write('totalDurationSeconds: $totalDurationSeconds, ')
          ..write('xWinStreak: $xWinStreak, ')
          ..write('oWinStreak: $oWinStreak, ')
          ..write('xBestStreak: $xBestStreak, ')
          ..write('oBestStreak: $oBestStreak, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingsRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _soundEnabledMeta = const VerificationMeta(
    'soundEnabled',
  );
  @override
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
    'sound_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _hapticEnabledMeta = const VerificationMeta(
    'hapticEnabled',
  );
  @override
  late final GeneratedColumn<bool> hapticEnabled = GeneratedColumn<bool>(
    'haptic_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("haptic_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _aiDifficultyMeta = const VerificationMeta(
    'aiDifficulty',
  );
  @override
  late final GeneratedColumn<String> aiDifficulty = GeneratedColumn<String>(
    'ai_difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('medium'),
  );
  static const VerificationMeta _defaultBoardSizeMeta = const VerificationMeta(
    'defaultBoardSize',
  );
  @override
  late final GeneratedColumn<String> defaultBoardSize = GeneratedColumn<String>(
    'default_board_size',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('classic'),
  );
  static const VerificationMeta _defaultGameModeMeta = const VerificationMeta(
    'defaultGameMode',
  );
  @override
  late final GeneratedColumn<String> defaultGameMode = GeneratedColumn<String>(
    'default_game_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pvp'),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('light'),
  );
  static const VerificationMeta _playerXNameMeta = const VerificationMeta(
    'playerXName',
  );
  @override
  late final GeneratedColumn<String> playerXName = GeneratedColumn<String>(
    'player_x_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Player X'),
  );
  static const VerificationMeta _playerONameMeta = const VerificationMeta(
    'playerOName',
  );
  @override
  late final GeneratedColumn<String> playerOName = GeneratedColumn<String>(
    'player_o_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Player O'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
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
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sound_enabled')) {
      context.handle(
        _soundEnabledMeta,
        soundEnabled.isAcceptableOrUnknown(
          data['sound_enabled']!,
          _soundEnabledMeta,
        ),
      );
    }
    if (data.containsKey('haptic_enabled')) {
      context.handle(
        _hapticEnabledMeta,
        hapticEnabled.isAcceptableOrUnknown(
          data['haptic_enabled']!,
          _hapticEnabledMeta,
        ),
      );
    }
    if (data.containsKey('ai_difficulty')) {
      context.handle(
        _aiDifficultyMeta,
        aiDifficulty.isAcceptableOrUnknown(
          data['ai_difficulty']!,
          _aiDifficultyMeta,
        ),
      );
    }
    if (data.containsKey('default_board_size')) {
      context.handle(
        _defaultBoardSizeMeta,
        defaultBoardSize.isAcceptableOrUnknown(
          data['default_board_size']!,
          _defaultBoardSizeMeta,
        ),
      );
    }
    if (data.containsKey('default_game_mode')) {
      context.handle(
        _defaultGameModeMeta,
        defaultGameMode.isAcceptableOrUnknown(
          data['default_game_mode']!,
          _defaultGameModeMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('player_x_name')) {
      context.handle(
        _playerXNameMeta,
        playerXName.isAcceptableOrUnknown(
          data['player_x_name']!,
          _playerXNameMeta,
        ),
      );
    }
    if (data.containsKey('player_o_name')) {
      context.handle(
        _playerONameMeta,
        playerOName.isAcceptableOrUnknown(
          data['player_o_name']!,
          _playerONameMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      soundEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound_enabled'],
      )!,
      hapticEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}haptic_enabled'],
      )!,
      aiDifficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_difficulty'],
      )!,
      defaultBoardSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_board_size'],
      )!,
      defaultGameMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_game_mode'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      playerXName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_x_name'],
      )!,
      playerOName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_o_name'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingsRecord extends DataClass implements Insertable<SettingsRecord> {
  final int id;
  final bool soundEnabled;
  final bool hapticEnabled;
  final String aiDifficulty;
  final String defaultBoardSize;
  final String defaultGameMode;
  final String themeMode;
  final String playerXName;
  final String playerOName;
  final DateTime updatedAt;
  const SettingsRecord({
    required this.id,
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sound_enabled'] = Variable<bool>(soundEnabled);
    map['haptic_enabled'] = Variable<bool>(hapticEnabled);
    map['ai_difficulty'] = Variable<String>(aiDifficulty);
    map['default_board_size'] = Variable<String>(defaultBoardSize);
    map['default_game_mode'] = Variable<String>(defaultGameMode);
    map['theme_mode'] = Variable<String>(themeMode);
    map['player_x_name'] = Variable<String>(playerXName);
    map['player_o_name'] = Variable<String>(playerOName);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      soundEnabled: Value(soundEnabled),
      hapticEnabled: Value(hapticEnabled),
      aiDifficulty: Value(aiDifficulty),
      defaultBoardSize: Value(defaultBoardSize),
      defaultGameMode: Value(defaultGameMode),
      themeMode: Value(themeMode),
      playerXName: Value(playerXName),
      playerOName: Value(playerOName),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingsRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRecord(
      id: serializer.fromJson<int>(json['id']),
      soundEnabled: serializer.fromJson<bool>(json['soundEnabled']),
      hapticEnabled: serializer.fromJson<bool>(json['hapticEnabled']),
      aiDifficulty: serializer.fromJson<String>(json['aiDifficulty']),
      defaultBoardSize: serializer.fromJson<String>(json['defaultBoardSize']),
      defaultGameMode: serializer.fromJson<String>(json['defaultGameMode']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      playerXName: serializer.fromJson<String>(json['playerXName']),
      playerOName: serializer.fromJson<String>(json['playerOName']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soundEnabled': serializer.toJson<bool>(soundEnabled),
      'hapticEnabled': serializer.toJson<bool>(hapticEnabled),
      'aiDifficulty': serializer.toJson<String>(aiDifficulty),
      'defaultBoardSize': serializer.toJson<String>(defaultBoardSize),
      'defaultGameMode': serializer.toJson<String>(defaultGameMode),
      'themeMode': serializer.toJson<String>(themeMode),
      'playerXName': serializer.toJson<String>(playerXName),
      'playerOName': serializer.toJson<String>(playerOName),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SettingsRecord copyWith({
    int? id,
    bool? soundEnabled,
    bool? hapticEnabled,
    String? aiDifficulty,
    String? defaultBoardSize,
    String? defaultGameMode,
    String? themeMode,
    String? playerXName,
    String? playerOName,
    DateTime? updatedAt,
  }) => SettingsRecord(
    id: id ?? this.id,
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
  SettingsRecord copyWithCompanion(SettingsCompanion data) {
    return SettingsRecord(
      id: data.id.present ? data.id.value : this.id,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
      hapticEnabled: data.hapticEnabled.present
          ? data.hapticEnabled.value
          : this.hapticEnabled,
      aiDifficulty: data.aiDifficulty.present
          ? data.aiDifficulty.value
          : this.aiDifficulty,
      defaultBoardSize: data.defaultBoardSize.present
          ? data.defaultBoardSize.value
          : this.defaultBoardSize,
      defaultGameMode: data.defaultGameMode.present
          ? data.defaultGameMode.value
          : this.defaultGameMode,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      playerXName: data.playerXName.present
          ? data.playerXName.value
          : this.playerXName,
      playerOName: data.playerOName.present
          ? data.playerOName.value
          : this.playerOName,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRecord(')
          ..write('id: $id, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('hapticEnabled: $hapticEnabled, ')
          ..write('aiDifficulty: $aiDifficulty, ')
          ..write('defaultBoardSize: $defaultBoardSize, ')
          ..write('defaultGameMode: $defaultGameMode, ')
          ..write('themeMode: $themeMode, ')
          ..write('playerXName: $playerXName, ')
          ..write('playerOName: $playerOName, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    soundEnabled,
    hapticEnabled,
    aiDifficulty,
    defaultBoardSize,
    defaultGameMode,
    themeMode,
    playerXName,
    playerOName,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRecord &&
          other.id == this.id &&
          other.soundEnabled == this.soundEnabled &&
          other.hapticEnabled == this.hapticEnabled &&
          other.aiDifficulty == this.aiDifficulty &&
          other.defaultBoardSize == this.defaultBoardSize &&
          other.defaultGameMode == this.defaultGameMode &&
          other.themeMode == this.themeMode &&
          other.playerXName == this.playerXName &&
          other.playerOName == this.playerOName &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<SettingsRecord> {
  final Value<int> id;
  final Value<bool> soundEnabled;
  final Value<bool> hapticEnabled;
  final Value<String> aiDifficulty;
  final Value<String> defaultBoardSize;
  final Value<String> defaultGameMode;
  final Value<String> themeMode;
  final Value<String> playerXName;
  final Value<String> playerOName;
  final Value<DateTime> updatedAt;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.hapticEnabled = const Value.absent(),
    this.aiDifficulty = const Value.absent(),
    this.defaultBoardSize = const Value.absent(),
    this.defaultGameMode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.playerXName = const Value.absent(),
    this.playerOName = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.hapticEnabled = const Value.absent(),
    this.aiDifficulty = const Value.absent(),
    this.defaultBoardSize = const Value.absent(),
    this.defaultGameMode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.playerXName = const Value.absent(),
    this.playerOName = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<SettingsRecord> custom({
    Expression<int>? id,
    Expression<bool>? soundEnabled,
    Expression<bool>? hapticEnabled,
    Expression<String>? aiDifficulty,
    Expression<String>? defaultBoardSize,
    Expression<String>? defaultGameMode,
    Expression<String>? themeMode,
    Expression<String>? playerXName,
    Expression<String>? playerOName,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
      if (hapticEnabled != null) 'haptic_enabled': hapticEnabled,
      if (aiDifficulty != null) 'ai_difficulty': aiDifficulty,
      if (defaultBoardSize != null) 'default_board_size': defaultBoardSize,
      if (defaultGameMode != null) 'default_game_mode': defaultGameMode,
      if (themeMode != null) 'theme_mode': themeMode,
      if (playerXName != null) 'player_x_name': playerXName,
      if (playerOName != null) 'player_o_name': playerOName,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? soundEnabled,
    Value<bool>? hapticEnabled,
    Value<String>? aiDifficulty,
    Value<String>? defaultBoardSize,
    Value<String>? defaultGameMode,
    Value<String>? themeMode,
    Value<String>? playerXName,
    Value<String>? playerOName,
    Value<DateTime>? updatedAt,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    if (hapticEnabled.present) {
      map['haptic_enabled'] = Variable<bool>(hapticEnabled.value);
    }
    if (aiDifficulty.present) {
      map['ai_difficulty'] = Variable<String>(aiDifficulty.value);
    }
    if (defaultBoardSize.present) {
      map['default_board_size'] = Variable<String>(defaultBoardSize.value);
    }
    if (defaultGameMode.present) {
      map['default_game_mode'] = Variable<String>(defaultGameMode.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (playerXName.present) {
      map['player_x_name'] = Variable<String>(playerXName.value);
    }
    if (playerOName.present) {
      map['player_o_name'] = Variable<String>(playerOName.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('hapticEnabled: $hapticEnabled, ')
          ..write('aiDifficulty: $aiDifficulty, ')
          ..write('defaultBoardSize: $defaultBoardSize, ')
          ..write('defaultGameMode: $defaultGameMode, ')
          ..write('themeMode: $themeMode, ')
          ..write('playerXName: $playerXName, ')
          ..write('playerOName: $playerOName, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GamesTable games = $GamesTable(this);
  late final $StatisticsTable statistics = $StatisticsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    games,
    statistics,
    settings,
  ];
}

typedef $$GamesTableCreateCompanionBuilder =
    GamesCompanion Function({
      required String id,
      required String boardSize,
      required String gameMode,
      required String winner,
      required int movesCount,
      Value<int> durationSeconds,
      Value<String> moveHistory,
      required DateTime createdAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$GamesTableUpdateCompanionBuilder =
    GamesCompanion Function({
      Value<String> id,
      Value<String> boardSize,
      Value<String> gameMode,
      Value<String> winner,
      Value<int> movesCount,
      Value<int> durationSeconds,
      Value<String> moveHistory,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

class $$GamesTableFilterComposer extends Composer<_$AppDatabase, $GamesTable> {
  $$GamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardSize => $composableBuilder(
    column: $table.boardSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gameMode => $composableBuilder(
    column: $table.gameMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get winner => $composableBuilder(
    column: $table.winner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get movesCount => $composableBuilder(
    column: $table.movesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moveHistory => $composableBuilder(
    column: $table.moveHistory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GamesTableOrderingComposer
    extends Composer<_$AppDatabase, $GamesTable> {
  $$GamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardSize => $composableBuilder(
    column: $table.boardSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gameMode => $composableBuilder(
    column: $table.gameMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get winner => $composableBuilder(
    column: $table.winner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get movesCount => $composableBuilder(
    column: $table.movesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moveHistory => $composableBuilder(
    column: $table.moveHistory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GamesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GamesTable> {
  $$GamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get boardSize =>
      $composableBuilder(column: $table.boardSize, builder: (column) => column);

  GeneratedColumn<String> get gameMode =>
      $composableBuilder(column: $table.gameMode, builder: (column) => column);

  GeneratedColumn<String> get winner =>
      $composableBuilder(column: $table.winner, builder: (column) => column);

  GeneratedColumn<int> get movesCount => $composableBuilder(
    column: $table.movesCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get moveHistory => $composableBuilder(
    column: $table.moveHistory,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$GamesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GamesTable,
          GameRecord,
          $$GamesTableFilterComposer,
          $$GamesTableOrderingComposer,
          $$GamesTableAnnotationComposer,
          $$GamesTableCreateCompanionBuilder,
          $$GamesTableUpdateCompanionBuilder,
          (GameRecord, BaseReferences<_$AppDatabase, $GamesTable, GameRecord>),
          GameRecord,
          PrefetchHooks Function()
        > {
  $$GamesTableTableManager(_$AppDatabase db, $GamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> boardSize = const Value.absent(),
                Value<String> gameMode = const Value.absent(),
                Value<String> winner = const Value.absent(),
                Value<int> movesCount = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<String> moveHistory = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GamesCompanion(
                id: id,
                boardSize: boardSize,
                gameMode: gameMode,
                winner: winner,
                movesCount: movesCount,
                durationSeconds: durationSeconds,
                moveHistory: moveHistory,
                createdAt: createdAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String boardSize,
                required String gameMode,
                required String winner,
                required int movesCount,
                Value<int> durationSeconds = const Value.absent(),
                Value<String> moveHistory = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GamesCompanion.insert(
                id: id,
                boardSize: boardSize,
                gameMode: gameMode,
                winner: winner,
                movesCount: movesCount,
                durationSeconds: durationSeconds,
                moveHistory: moveHistory,
                createdAt: createdAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GamesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GamesTable,
      GameRecord,
      $$GamesTableFilterComposer,
      $$GamesTableOrderingComposer,
      $$GamesTableAnnotationComposer,
      $$GamesTableCreateCompanionBuilder,
      $$GamesTableUpdateCompanionBuilder,
      (GameRecord, BaseReferences<_$AppDatabase, $GamesTable, GameRecord>),
      GameRecord,
      PrefetchHooks Function()
    >;
typedef $$StatisticsTableCreateCompanionBuilder =
    StatisticsCompanion Function({
      Value<int> id,
      required String boardSize,
      required String gameMode,
      Value<int> totalGames,
      Value<int> xWins,
      Value<int> oWins,
      Value<int> draws,
      Value<int> totalMoves,
      Value<int> totalDurationSeconds,
      Value<int> xWinStreak,
      Value<int> oWinStreak,
      Value<int> xBestStreak,
      Value<int> oBestStreak,
      required DateTime updatedAt,
    });
typedef $$StatisticsTableUpdateCompanionBuilder =
    StatisticsCompanion Function({
      Value<int> id,
      Value<String> boardSize,
      Value<String> gameMode,
      Value<int> totalGames,
      Value<int> xWins,
      Value<int> oWins,
      Value<int> draws,
      Value<int> totalMoves,
      Value<int> totalDurationSeconds,
      Value<int> xWinStreak,
      Value<int> oWinStreak,
      Value<int> xBestStreak,
      Value<int> oBestStreak,
      Value<DateTime> updatedAt,
    });

class $$StatisticsTableFilterComposer
    extends Composer<_$AppDatabase, $StatisticsTable> {
  $$StatisticsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardSize => $composableBuilder(
    column: $table.boardSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gameMode => $composableBuilder(
    column: $table.gameMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalGames => $composableBuilder(
    column: $table.totalGames,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xWins => $composableBuilder(
    column: $table.xWins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get oWins => $composableBuilder(
    column: $table.oWins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get draws => $composableBuilder(
    column: $table.draws,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalMoves => $composableBuilder(
    column: $table.totalMoves,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalDurationSeconds => $composableBuilder(
    column: $table.totalDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xWinStreak => $composableBuilder(
    column: $table.xWinStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get oWinStreak => $composableBuilder(
    column: $table.oWinStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xBestStreak => $composableBuilder(
    column: $table.xBestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get oBestStreak => $composableBuilder(
    column: $table.oBestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StatisticsTableOrderingComposer
    extends Composer<_$AppDatabase, $StatisticsTable> {
  $$StatisticsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardSize => $composableBuilder(
    column: $table.boardSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gameMode => $composableBuilder(
    column: $table.gameMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalGames => $composableBuilder(
    column: $table.totalGames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xWins => $composableBuilder(
    column: $table.xWins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get oWins => $composableBuilder(
    column: $table.oWins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get draws => $composableBuilder(
    column: $table.draws,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalMoves => $composableBuilder(
    column: $table.totalMoves,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalDurationSeconds => $composableBuilder(
    column: $table.totalDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xWinStreak => $composableBuilder(
    column: $table.xWinStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get oWinStreak => $composableBuilder(
    column: $table.oWinStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xBestStreak => $composableBuilder(
    column: $table.xBestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get oBestStreak => $composableBuilder(
    column: $table.oBestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StatisticsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatisticsTable> {
  $$StatisticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get boardSize =>
      $composableBuilder(column: $table.boardSize, builder: (column) => column);

  GeneratedColumn<String> get gameMode =>
      $composableBuilder(column: $table.gameMode, builder: (column) => column);

  GeneratedColumn<int> get totalGames => $composableBuilder(
    column: $table.totalGames,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xWins =>
      $composableBuilder(column: $table.xWins, builder: (column) => column);

  GeneratedColumn<int> get oWins =>
      $composableBuilder(column: $table.oWins, builder: (column) => column);

  GeneratedColumn<int> get draws =>
      $composableBuilder(column: $table.draws, builder: (column) => column);

  GeneratedColumn<int> get totalMoves => $composableBuilder(
    column: $table.totalMoves,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalDurationSeconds => $composableBuilder(
    column: $table.totalDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xWinStreak => $composableBuilder(
    column: $table.xWinStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get oWinStreak => $composableBuilder(
    column: $table.oWinStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xBestStreak => $composableBuilder(
    column: $table.xBestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get oBestStreak => $composableBuilder(
    column: $table.oBestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StatisticsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StatisticsTable,
          StatisticsRecord,
          $$StatisticsTableFilterComposer,
          $$StatisticsTableOrderingComposer,
          $$StatisticsTableAnnotationComposer,
          $$StatisticsTableCreateCompanionBuilder,
          $$StatisticsTableUpdateCompanionBuilder,
          (
            StatisticsRecord,
            BaseReferences<_$AppDatabase, $StatisticsTable, StatisticsRecord>,
          ),
          StatisticsRecord,
          PrefetchHooks Function()
        > {
  $$StatisticsTableTableManager(_$AppDatabase db, $StatisticsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatisticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatisticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatisticsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> boardSize = const Value.absent(),
                Value<String> gameMode = const Value.absent(),
                Value<int> totalGames = const Value.absent(),
                Value<int> xWins = const Value.absent(),
                Value<int> oWins = const Value.absent(),
                Value<int> draws = const Value.absent(),
                Value<int> totalMoves = const Value.absent(),
                Value<int> totalDurationSeconds = const Value.absent(),
                Value<int> xWinStreak = const Value.absent(),
                Value<int> oWinStreak = const Value.absent(),
                Value<int> xBestStreak = const Value.absent(),
                Value<int> oBestStreak = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StatisticsCompanion(
                id: id,
                boardSize: boardSize,
                gameMode: gameMode,
                totalGames: totalGames,
                xWins: xWins,
                oWins: oWins,
                draws: draws,
                totalMoves: totalMoves,
                totalDurationSeconds: totalDurationSeconds,
                xWinStreak: xWinStreak,
                oWinStreak: oWinStreak,
                xBestStreak: xBestStreak,
                oBestStreak: oBestStreak,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String boardSize,
                required String gameMode,
                Value<int> totalGames = const Value.absent(),
                Value<int> xWins = const Value.absent(),
                Value<int> oWins = const Value.absent(),
                Value<int> draws = const Value.absent(),
                Value<int> totalMoves = const Value.absent(),
                Value<int> totalDurationSeconds = const Value.absent(),
                Value<int> xWinStreak = const Value.absent(),
                Value<int> oWinStreak = const Value.absent(),
                Value<int> xBestStreak = const Value.absent(),
                Value<int> oBestStreak = const Value.absent(),
                required DateTime updatedAt,
              }) => StatisticsCompanion.insert(
                id: id,
                boardSize: boardSize,
                gameMode: gameMode,
                totalGames: totalGames,
                xWins: xWins,
                oWins: oWins,
                draws: draws,
                totalMoves: totalMoves,
                totalDurationSeconds: totalDurationSeconds,
                xWinStreak: xWinStreak,
                oWinStreak: oWinStreak,
                xBestStreak: xBestStreak,
                oBestStreak: oBestStreak,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StatisticsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StatisticsTable,
      StatisticsRecord,
      $$StatisticsTableFilterComposer,
      $$StatisticsTableOrderingComposer,
      $$StatisticsTableAnnotationComposer,
      $$StatisticsTableCreateCompanionBuilder,
      $$StatisticsTableUpdateCompanionBuilder,
      (
        StatisticsRecord,
        BaseReferences<_$AppDatabase, $StatisticsTable, StatisticsRecord>,
      ),
      StatisticsRecord,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<bool> soundEnabled,
      Value<bool> hapticEnabled,
      Value<String> aiDifficulty,
      Value<String> defaultBoardSize,
      Value<String> defaultGameMode,
      Value<String> themeMode,
      Value<String> playerXName,
      Value<String> playerOName,
      required DateTime updatedAt,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<bool> soundEnabled,
      Value<bool> hapticEnabled,
      Value<String> aiDifficulty,
      Value<String> defaultBoardSize,
      Value<String> defaultGameMode,
      Value<String> themeMode,
      Value<String> playerXName,
      Value<String> playerOName,
      Value<DateTime> updatedAt,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hapticEnabled => $composableBuilder(
    column: $table.hapticEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiDifficulty => $composableBuilder(
    column: $table.aiDifficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultBoardSize => $composableBuilder(
    column: $table.defaultBoardSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultGameMode => $composableBuilder(
    column: $table.defaultGameMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerXName => $composableBuilder(
    column: $table.playerXName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerOName => $composableBuilder(
    column: $table.playerOName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hapticEnabled => $composableBuilder(
    column: $table.hapticEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiDifficulty => $composableBuilder(
    column: $table.aiDifficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultBoardSize => $composableBuilder(
    column: $table.defaultBoardSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultGameMode => $composableBuilder(
    column: $table.defaultGameMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerXName => $composableBuilder(
    column: $table.playerXName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerOName => $composableBuilder(
    column: $table.playerOName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hapticEnabled => $composableBuilder(
    column: $table.hapticEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aiDifficulty => $composableBuilder(
    column: $table.aiDifficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultBoardSize => $composableBuilder(
    column: $table.defaultBoardSize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultGameMode => $composableBuilder(
    column: $table.defaultGameMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get playerXName => $composableBuilder(
    column: $table.playerXName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get playerOName => $composableBuilder(
    column: $table.playerOName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          SettingsRecord,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            SettingsRecord,
            BaseReferences<_$AppDatabase, $SettingsTable, SettingsRecord>,
          ),
          SettingsRecord,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<bool> hapticEnabled = const Value.absent(),
                Value<String> aiDifficulty = const Value.absent(),
                Value<String> defaultBoardSize = const Value.absent(),
                Value<String> defaultGameMode = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> playerXName = const Value.absent(),
                Value<String> playerOName = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                soundEnabled: soundEnabled,
                hapticEnabled: hapticEnabled,
                aiDifficulty: aiDifficulty,
                defaultBoardSize: defaultBoardSize,
                defaultGameMode: defaultGameMode,
                themeMode: themeMode,
                playerXName: playerXName,
                playerOName: playerOName,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<bool> hapticEnabled = const Value.absent(),
                Value<String> aiDifficulty = const Value.absent(),
                Value<String> defaultBoardSize = const Value.absent(),
                Value<String> defaultGameMode = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> playerXName = const Value.absent(),
                Value<String> playerOName = const Value.absent(),
                required DateTime updatedAt,
              }) => SettingsCompanion.insert(
                id: id,
                soundEnabled: soundEnabled,
                hapticEnabled: hapticEnabled,
                aiDifficulty: aiDifficulty,
                defaultBoardSize: defaultBoardSize,
                defaultGameMode: defaultGameMode,
                themeMode: themeMode,
                playerXName: playerXName,
                playerOName: playerOName,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      SettingsRecord,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (
        SettingsRecord,
        BaseReferences<_$AppDatabase, $SettingsTable, SettingsRecord>,
      ),
      SettingsRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GamesTableTableManager get games =>
      $$GamesTableTableManager(_db, _db.games);
  $$StatisticsTableTableManager get statistics =>
      $$StatisticsTableTableManager(_db, _db.statistics);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
