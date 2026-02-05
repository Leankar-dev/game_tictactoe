import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/database.dart';
import '../../data/repositories/repositories.dart';
import '../../domain/usecases/check_winner_usecase.dart';
import '../../domain/usecases/make_move_usecase.dart';
import '../../domain/usecases/ai_move_usecase.dart';
import '../../domain/usecases/difficulty_ai_usecase.dart';
import '../utils/feedback_service.dart';
import '../../presentation/providers/settings_provider.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();

  ref.onDispose(() {
    database.close();
  });

  return database;
});

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return GameRepository(database);
});

final statisticsRepositoryProvider = Provider<StatisticsRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return StatisticsRepository(database);
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return SettingsRepository(database);
});

final checkWinnerUseCaseProvider = Provider<CheckWinnerUseCase>((ref) {
  return const CheckWinnerUseCase();
});

final makeMoveUseCaseProvider = Provider<MakeMoveUseCase>((ref) {
  final checkWinnerUseCase = ref.watch(checkWinnerUseCaseProvider);
  return MakeMoveUseCase(checkWinnerUseCase: checkWinnerUseCase);
});

final aiMoveUseCaseProvider = Provider<AiMoveUseCase>((ref) {
  final checkWinnerUseCase = ref.watch(checkWinnerUseCaseProvider);
  return AiMoveUseCase(checkWinnerUseCase: checkWinnerUseCase);
});

final difficultyAiUseCaseProvider = Provider<DifficultyAiUseCase>((ref) {
  final checkWinnerUseCase = ref.watch(checkWinnerUseCaseProvider);
  return DifficultyAiUseCase(checkWinnerUseCase: checkWinnerUseCase);
});

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  final service = FeedbackService();

  ref.listen(settingsProvider, (previous, next) {
    service.setSoundEnabled(next.settings.soundEnabled);
    service.setHapticEnabled(next.settings.hapticEnabled);
  });

  return service;
});
