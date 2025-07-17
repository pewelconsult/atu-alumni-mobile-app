// lib/presentation/widgets/charts/program_effectiveness_chart.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ProgramEffectivenessChart extends StatelessWidget {
  const ProgramEffectivenessChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Employment Rate by Program',
          style: ATUTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: ATUColors.grey700,
          ),
        ),
        const SizedBox(height: 16),

        Expanded(
          child: Column(
            children: [
              _buildProgramBar('Computer Science', 92.5, ATUColors.success),
              _buildProgramBar('Engineering', 89.3, ATUColors.success),
              _buildProgramBar('Business Admin', 85.7, ATUColors.primaryBlue),
              _buildProgramBar('Architecture', 81.2, ATUColors.primaryBlue),
              _buildProgramBar('Hospitality', 78.9, ATUColors.warning),
              _buildProgramBar('Applied Sciences', 83.4, ATUColors.primaryBlue),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgramBar(String program, double percentage, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                program,
                style: ATUTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ATUColors.grey700,
                ),
              ),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: ATUTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: ATUColors.grey200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
