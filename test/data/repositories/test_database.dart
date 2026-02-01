import 'package:drift/native.dart';
import 'package:game_tictactoe/data/datasources/local/database.dart';

AppDatabase createTestDatabase() {
  return AppDatabase.forTesting(
    NativeDatabase.memory(),
  );
}
