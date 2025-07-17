// lib/presentation/widgets/cards/job_card.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/atu_button.dart';
import '../../models/job_model.dart'; // Import the shared model

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;
  final VoidCallback? onSave;
  final VoidCallback? onApply;
  final bool showApplicationStatus;

  const JobCard({
    super.key,
    required this.job,
    this.onTap,
    this.onSave,
    this.onApply,
    this.showApplicationStatus = false,
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
              // Header with company info and save button
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: job.companyColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.business_rounded,
                      color: job.companyColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: ATUTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ATUColors.grey900,
                          ),
                        ),
                        Text(
                          job.company,
                          style: ATUTextStyles.bodyMedium.copyWith(
                            color: ATUColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onSave != null)
                    IconButton(
                      onPressed: onSave,
                      icon: Icon(
                        job.isSaved
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: job.isSaved
                            ? ATUColors.primaryGold
                            : ATUColors.grey400,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Job details
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 16,
                    color: ATUColors.grey500,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    job.location,
                    style: ATUTextStyles.bodySmall.copyWith(
                      color: ATUColors.grey600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.work_outline_rounded,
                    size: 16,
                    color: ATUColors.grey500,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    job.type,
                    style: ATUTextStyles.bodySmall.copyWith(
                      color: ATUColors.grey600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Tags
              Row(
                children: [
                  _buildJobTag(job.experienceLevel, ATUColors.success),
                  const SizedBox(width: 8),
                  _buildJobTag(job.salary, ATUColors.primaryGold),
                  const Spacer(),
                  if (showApplicationStatus && job.hasApplied)
                    _buildStatusTag(job.applicationStatus),
                ],
              ),

              const SizedBox(height: 16),

              // Job description preview
              Text(
                job.description,
                style: ATUTextStyles.bodyMedium.copyWith(
                  color: ATUColors.grey600,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 16),

              // Posted by alumni
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ATUColors.primaryBlue.withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: ATUColors.primaryBlue,
                      child: Text(
                        job.postedBy.substring(0, 1).toUpperCase(),
                        style: ATUTextStyles.caption.copyWith(
                          color: ATUColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Posted by Alumni',
                            style: ATUTextStyles.caption.copyWith(
                              color: ATUColors.grey500,
                            ),
                          ),
                          Text(
                            job.postedBy,
                            style: ATUTextStyles.bodySmall.copyWith(
                              color: ATUColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.verified_rounded,
                      color: ATUColors.success,
                      size: 16,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Action buttons
              if (!showApplicationStatus || !job.hasApplied)
                Row(
                  children: [
                    Expanded(
                      child: ATUButton(
                        text: 'View Details',
                        onPressed: onTap,
                        type: ATUButtonType.outline,
                        size: ATUButtonSize.small,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ATUButton(
                        text: job.hasApplied ? 'Applied' : 'Apply Now',
                        onPressed: job.hasApplied ? null : onApply,
                        type: job.hasApplied
                            ? ATUButtonType.outline
                            : ATUButtonType.primary,
                        size: ATUButtonSize.small,
                        icon: job.hasApplied
                            ? Icons.check_rounded
                            : Icons.send_rounded,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: ATUButton(
                        text: 'View Application',
                        onPressed: onTap,
                        type: ATUButtonType.outline,
                        size: ATUButtonSize.small,
                        icon: Icons.description_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ATUButton(
                        text: 'Track Status',
                        onPressed: () {
                          // TODO: Show application tracking
                        },
                        type: ATUButtonType.primary,
                        size: ATUButtonSize.small,
                        icon: Icons.track_changes_rounded,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: ATUTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatusTag(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'pending':
        color = ATUColors.warning;
        break;
      case 'under review':
        color = ATUColors.info;
        break;
      case 'interview scheduled':
        color = ATUColors.success;
        break;
      case 'rejected':
        color = ATUColors.error;
        break;
      case 'accepted':
        color = ATUColors.success;
        break;
      default:
        color = ATUColors.grey500;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: ATUTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
