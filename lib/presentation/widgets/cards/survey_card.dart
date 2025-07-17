// lib/presentation/widgets/cards/survey_card.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../common/atu_button.dart';
import '../../pages/surveys/surveys_screen.dart';

class SurveyCard extends StatelessWidget {
  final DetailedSurveyModel survey;
  final VoidCallback? onTap;
  final bool isAvailable;

  const SurveyCard({
    super.key,
    required this.survey,
    this.onTap,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isAvailable
                  ? ATUColors.primaryBlue.withValues(alpha: .3)
                  : ATUColors.grey200,
              width: isAvailable ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: ATUColors.grey400.withValues(alpha: .1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with category and status
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(
                        survey.category,
                      ).withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      survey.category,
                      style: ATUTextStyles.caption.copyWith(
                        color: _getCategoryColor(survey.category),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (survey.isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ATUColors.success.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 14,
                            color: ATUColors.success,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Completed',
                            style: ATUTextStyles.caption.copyWith(
                              color: ATUColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Survey title and description
              Text(
                survey.title,
                style: ATUTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                survey.description,
                style: ATUTextStyles.bodyMedium.copyWith(
                  color: ATUColors.grey600,
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 16),

              // Survey details
              Row(
                children: [
                  _buildSurveyDetail(
                    Icons.access_time_rounded,
                    '${survey.estimatedMinutes} min',
                  ),
                  const SizedBox(width: 16),
                  _buildSurveyDetail(
                    Icons.help_rounded,
                    '${survey.questions.length} questions',
                  ),
                  const SizedBox(width: 16),
                  _buildSurveyDetail(
                    Icons.calendar_today_rounded,
                    'Due ${survey.deadline}',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Action buttons
              if (isAvailable && !survey.isCompleted)
                Row(
                  children: [
                    Expanded(
                      child: ATUButton(
                        text: 'Take Survey',
                        onPressed: onTap,
                        type: ATUButtonType.primary,
                        size: ATUButtonSize.small,
                        icon: Icons.play_arrow_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ATUButton(
                      text: '',
                      onPressed: () => _shareSurvey(context),
                      type: ATUButtonType.outline,
                      size: ATUButtonSize.small,
                      icon: Icons.share_rounded,
                    ),
                  ],
                )
              else if (survey.isCompleted)
                Row(
                  children: [
                    Expanded(
                      child: ATUButton(
                        text: 'View Response',
                        onPressed: onTap,
                        type: ATUButtonType.outline,
                        size: ATUButtonSize.small,
                        icon: Icons.visibility_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ATUButton(
                      text: '',
                      onPressed: () => _downloadResponse(context),
                      type: ATUButtonType.text,
                      size: ATUButtonSize.small,
                      icon: Icons.download_rounded,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSurveyDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: ATUColors.grey500),
        const SizedBox(width: 4),
        Text(
          text,
          style: ATUTextStyles.caption.copyWith(color: ATUColors.grey500),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Employment':
        return ATUColors.primaryBlue;
      case 'Skills Development':
        return ATUColors.success;
      case 'Education':
        return ATUColors.info;
      case 'Satisfaction':
        return ATUColors.primaryGold;
      default:
        return ATUColors.grey500;
    }
  }

  void _shareSurvey(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${survey.title}'),
        backgroundColor: ATUColors.info,
      ),
    );
  }

  void _downloadResponse(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading response for ${survey.title}'),
        backgroundColor: ATUColors.success,
      ),
    );
  }
}
