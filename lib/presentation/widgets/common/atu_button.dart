// lib/presentation/widgets/common/atu_button.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

enum ATUButtonType { primary, secondary, outline, text }

enum ATUButtonSize { small, medium, large }

class ATUButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ATUButtonType type;
  final ATUButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final Color? customColor;

  const ATUButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ATUButtonType.primary,
    this.size = ATUButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.customColor,
  });

  @override
  State<ATUButton> createState() => _ATUButtonState();
}

class _ATUButtonState extends State<ATUButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: ATUAnimations.fast,
      width: widget.isFullWidth ? double.infinity : null,
      child: GestureDetector(
        onTap: widget.isLoading
            ? null
            : () {
                debugPrint(
                  "🔍 ATUButton tapped! onPressed: ${widget.onPressed}",
                );
                widget.onPressed?.call();
              },
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : 1.0,
          duration: ATUAnimations.fast,
          child: Container(
            padding: _getPadding(),
            decoration: _getDecoration(),
            child: widget.isLoading
                ? _buildLoadingWidget()
                : _buildButtonContent(),
          ),
        ),
      ),
    );
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case ATUButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ATUButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ATUButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  BoxDecoration _getDecoration() {
    final isDisabled = widget.onPressed == null && !widget.isLoading;

    switch (widget.type) {
      case ATUButtonType.primary:
        return BoxDecoration(
          gradient: isDisabled ? null : ATUColors.primaryGradient,
          color: isDisabled ? ATUColors.grey300 : null,
          borderRadius: BorderRadius.circular(ATURadius.lg),
          boxShadow: isDisabled
              ? []
              : [
                  BoxShadow(
                    color: ATUColors.primaryBlue.withValues(alpha: .3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        );
      case ATUButtonType.secondary:
        return BoxDecoration(
          gradient: isDisabled ? null : ATUColors.goldGradient,
          color: isDisabled ? ATUColors.grey300 : null,
          borderRadius: BorderRadius.circular(ATURadius.lg),
          boxShadow: isDisabled
              ? []
              : [
                  BoxShadow(
                    color: ATUColors.primaryGold.withValues(alpha: .3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        );
      case ATUButtonType.outline:
        return BoxDecoration(
          color: ATUColors.white,
          border: Border.all(
            color: isDisabled
                ? ATUColors.grey300
                : (widget.customColor ?? ATUColors.primaryBlue),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(ATURadius.lg),
        );
      case ATUButtonType.text:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(ATURadius.lg),
        );
    }
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(color: _getTextColor(), strokeWidth: 2),
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, color: _getTextColor(), size: _getIconSize()),
          if (widget.text.isNotEmpty) const SizedBox(width: 8),
        ],
        if (widget.text.isNotEmpty) Text(widget.text, style: _getTextStyle()),
      ],
    );
  }

  Color _getTextColor() {
    final isDisabled = widget.onPressed == null && !widget.isLoading;

    if (isDisabled) {
      return ATUColors.grey500;
    }

    switch (widget.type) {
      case ATUButtonType.primary:
      case ATUButtonType.secondary:
        return ATUColors.white;
      case ATUButtonType.outline:
        return widget.customColor ?? ATUColors.primaryBlue;
      case ATUButtonType.text:
        return widget.customColor ?? ATUColors.primaryGold;
    }
  }

  TextStyle _getTextStyle() {
    final baseStyle = switch (widget.size) {
      ATUButtonSize.small => ATUTextStyles.bodySmall,
      ATUButtonSize.medium => ATUTextStyles.bodyMedium,
      ATUButtonSize.large => ATUTextStyles.bodyLarge,
    };

    return baseStyle.copyWith(
      color: _getTextColor(),
      fontWeight: FontWeight.w600,
    );
  }

  double _getIconSize() {
    switch (widget.size) {
      case ATUButtonSize.small:
        return 16;
      case ATUButtonSize.medium:
        return 20;
      case ATUButtonSize.large:
        return 24;
    }
  }
}
