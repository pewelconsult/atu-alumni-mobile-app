// lib/presentation/widgets/common/atu_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class ATUCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final bool hasShadow;
  final Color? backgroundColor;

  const ATUCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.hasShadow = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding ?? const EdgeInsets.all(ATUSpacing.md),
        decoration: BoxDecoration(
          color: backgroundColor ?? ATUColors.white,
          borderRadius: BorderRadius.circular(ATURadius.lg),
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: ATUColors.grey400.withValues(alpha: .1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    ).animate().fadeIn(duration: ATUAnimations.medium).slideY(
          begin: 0.1,
          end: 0,
          duration: ATUAnimations.medium,
        );
  }
}
