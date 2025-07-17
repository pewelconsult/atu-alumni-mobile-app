// lib/presentation/widgets/common/atu_empty_state.dart
import 'package:atu_alumni_app/core/theme/app_theme.dart';
import 'package:atu_alumni_app/presentation/widgets/common/atu_button.dart';
import 'package:flutter/material.dart';

class ATUEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onAction;
  final String? actionText;

  const ATUEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ATUSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ATUColors.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: ATUColors.grey400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: ATUTextStyles.h4.copyWith(
                color: ATUColors.grey700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: ATUTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onAction != null && actionText != null) ...[
              const SizedBox(height: 24),
              ATUButton(
                text: actionText!,
                onPressed: onAction,
                type: ATUButtonType.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
