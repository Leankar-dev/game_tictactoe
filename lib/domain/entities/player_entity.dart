import 'package:equatable/equatable.dart';
import '../enums/player_type.dart';

class PlayerEntity extends Equatable {
  final PlayerType type;
  final String name;
  final bool isCpu;

  const PlayerEntity({
    required this.type,
    required this.name,
    this.isCpu = false,
  });

  factory PlayerEntity.playerX({String? name, bool isCpu = false}) {
    return PlayerEntity(
      type: PlayerType.x,
      name: name ?? 'Player X',
      isCpu: isCpu,
    );
  }

  factory PlayerEntity.playerO({String? name, bool isCpu = false}) {
    return PlayerEntity(
      type: PlayerType.o,
      name: name ?? 'Player O',
      isCpu: isCpu,
    );
  }

  PlayerEntity copyWith({PlayerType? type, String? name, bool? isCpu}) {
    return PlayerEntity(
      type: type ?? this.type,
      name: name ?? this.name,
      isCpu: isCpu ?? this.isCpu,
    );
  }

  @override
  List<Object?> get props => [type, name, isCpu];

  @override
  String toString() =>
      'PlayerEntity(type: ${type.symbol}, name: $name, isCpu: $isCpu)';
}
