// lib/presentation/widgets/charts/employment_chart.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class EmploymentChart extends StatelessWidget {
  const EmploymentChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chart legend
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLegendItem('Employed', 87.5, ATUColors.success),
            _buildLegendItem('Unemployed', 8.2, ATUColors.warning),
            _buildLegendItem('Continuing Education', 4.3, ATUColors.info),
          ],
        ),
        const SizedBox(height: 20),

        // Simplified chart representation
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBar('2021', 85, ATUColors.primaryBlue),
              _buildBar('2022', 88, ATUColors.primaryBlue),
              _buildBar('2023', 90, ATUColors.success),
              _buildBar('2024', 87.5, ATUColors.success),
            ],
          ),
        ),

        const SizedBox(height: 16),
        Text(
          'Employment Rate by Graduation Year',
          style: ATUTextStyles.bodySmall.copyWith(color: ATUColors.grey600),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, double percentage, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$label (${percentage.toStringAsFixed(1)}%)',
          style: ATUTextStyles.caption.copyWith(color: ATUColors.grey600),
        ),
      ],
    );
  }

  Widget _buildBar(String year, double percentage, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: ATUTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: ATUColors.grey700,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: (percentage / 100) * 200, // Max height 200
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          year,
          style: ATUTextStyles.caption.copyWith(color: ATUColors.grey600),
        ),
      ],
    );
  }
}
