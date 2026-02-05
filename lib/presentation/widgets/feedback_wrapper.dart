import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/providers.dart';

class FeedbackWrapper extends ConsumerWidget {
  final Widget child;
  final VoidCallback? onTap;

  const FeedbackWrapper({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(feedbackServiceProvider).buttonFeedback();
        onTap?.call();
      },
      child: child,
    );
  }
}
