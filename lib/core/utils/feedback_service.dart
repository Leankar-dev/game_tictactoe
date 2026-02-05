import 'package:flutter/services.dart';

class FeedbackService {
  bool _soundEnabled = true;
  bool _hapticEnabled = true;

  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  void setHapticEnabled(bool enabled) {
    _hapticEnabled = enabled;
  }

  Future<void> playMoveSound() async {
    if (!_soundEnabled) return;
    await SystemSound.play(SystemSoundType.click);
  }

  Future<void> playWinSound() async {
    if (!_soundEnabled) return;
    await SystemSound.play(SystemSoundType.click);
  }

  Future<void> playDrawSound() async {
    if (!_soundEnabled) return;
    await SystemSound.play(SystemSoundType.click);
  }

  Future<void> moveFeedback() async {
    if (!_hapticEnabled) return;
    await HapticFeedback.lightImpact();
  }

  Future<void> winFeedback() async {
    if (!_hapticEnabled) return;
    await HapticFeedback.heavyImpact();
  }

  Future<void> errorFeedback() async {
    if (!_hapticEnabled) return;
    await HapticFeedback.vibrate();
  }

  Future<void> buttonFeedback() async {
    if (!_hapticEnabled) return;
    await HapticFeedback.selectionClick();
  }

  Future<void> onMove() async {
    await Future.wait([playMoveSound(), moveFeedback()]);
  }

  Future<void> onWin() async {
    await Future.wait([playWinSound(), winFeedback()]);
  }

  Future<void> onDraw() async {
    await Future.wait([playDrawSound(), moveFeedback()]);
  }
}
