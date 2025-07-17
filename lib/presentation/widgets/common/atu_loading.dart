// lib/presentation/widgets/common/atu_loading.dart
import 'package:atu_alumni_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ATULoading extends StatelessWidget {
  final String? message;
  final bool isFullScreen;

  const ATULoading({
    super.key,
    this.message,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: ATUColors.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: const CircularProgressIndicator(
            color: ATUColors.white,
            strokeWidth: 3,
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .rotate(duration: 2.seconds),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: ATUTextStyles.bodyMedium.copyWith(
              color: ATUColors.grey600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (isFullScreen) {
      return Scaffold(
        backgroundColor: ATUColors.grey50,
        body: Center(child: content),
      );
    }

    return Center(child: content);
  }
}
