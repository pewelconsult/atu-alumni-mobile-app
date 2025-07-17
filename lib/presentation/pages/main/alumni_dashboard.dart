// lib/presentation/pages/main/alumni_dashboard.dart
import 'package:atu_alumni_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AlumniDashboard extends StatelessWidget {
  const AlumniDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: ATUColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header
                _buildHeader(),

                // Profile Picture Section
                _buildProfileSection(),

                // Contact Info Section
                _buildContactInfoSection(),

                // Quick Stats
                _buildQuickStats(),

                // Priority Actions
                _buildPriorityActions(),

                // Recent Activities
                _buildRecentActivities(),

                // Add some bottom padding
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ATUColors.primaryBlue.withValues(alpha: .05),
                ATUColors.primaryGold.withValues(alpha: .05),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              // Top row with logo and notifications
              Row(
                children: [
                  // ATU Logo
                  _buildATULogo(),

                  const Spacer(),

                  // Notification bell
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ATUColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: ATUColors.primaryBlue.withValues(alpha: .15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.notifications_rounded,
                          color: ATUColors.primaryBlue,
                          size: 24,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: ATUColors.error,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ATUColors.white,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '3',
                                style: ATUTextStyles.caption.copyWith(
                                  color: ATUColors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Welcome section
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: ATUTextStyles.bodyMedium.copyWith(
                            color: ATUColors.grey600,
                          ),
                        ),
                        Text(
                          'John Doe',
                          style: ATUTextStyles.h3.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ATUColors.grey900,
                          ),
                        ),
                        // Profile completion
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: ATUColors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: ATUColors.grey400.withValues(alpha: .1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Profile Completion',
                                    style: ATUTextStyles.bodySmall.copyWith(
                                      color: ATUColors.grey600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '75%',
                                    style: ATUTextStyles.bodySmall.copyWith(
                                      color: ATUColors.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: ATUColors.grey200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 0.75,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          ATUColors.primaryBlue,
                                          ATUColors.primaryGold,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.2, end: 0, duration: 600.ms);
  }

  Widget _buildATULogo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ATUColors.primaryBlue.withValues(alpha: .15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo icon representation
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [ATUColors.primaryBlue, ATUColors.primaryGold],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.school, color: ATUColors.white, size: 20),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ATU',
                style: ATUTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.primaryBlue,
                ),
              ),
              Text(
                'Alumni',
                style: ATUTextStyles.caption.copyWith(
                  color: ATUColors.primaryGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ATUColors.grey400.withValues(alpha: .1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              // Profile Picture
              Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: ATUColors.primaryGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: ATUColors.primaryBlue.withValues(alpha: .3),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      color: ATUColors.white,
                      size: 40,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ATUColors.primaryGold,
                        shape: BoxShape.circle,
                        border: Border.all(color: ATUColors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: ATUColors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Profile Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: ATUTextStyles.h4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ATUColors.grey900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.school, size: 14, color: ATUColors.grey600),
                        const SizedBox(width: 4),
                        Text(
                          'Computer Science • Class of 2022',
                          style: ATUTextStyles.bodySmall.copyWith(
                            color: ATUColors.grey600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ATUColors.info.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: ATUTextStyles.caption.copyWith(
                          color: ATUColors.info,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 100.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 100.ms, duration: 600.ms);
  }

  Widget _buildContactInfoSection() {
    return Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ATUColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ATUColors.grey400.withValues(alpha: .1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Information',
                    style: ATUTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ATUColors.grey900,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ATUColors.success.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 12,
                          color: ATUColors.success,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Visible',
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
              _buildContactItem(
                icon: Icons.email_rounded,
                label: 'Email',
                value: 'john.doe@gmail.com',
                isVerified: true,
                color: ATUColors.primaryBlue,
              ),
              const SizedBox(height: 12),
              _buildContactItem(
                icon: Icons.phone_rounded,
                label: 'Phone',
                value: '+233 24 123 4567',
                isVerified: false,
                color: ATUColors.warning,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: ATUColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Update Contact Info',
                  style: ATUTextStyles.bodyMedium.copyWith(
                    color: ATUColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    required bool isVerified,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: ATUTextStyles.caption.copyWith(color: ATUColors.grey600),
              ),
              Text(
                value,
                style: ATUTextStyles.bodySmall.copyWith(
                  color: ATUColors.grey900,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isVerified
                ? ATUColors.success.withValues(alpha: .1)
                : ATUColors.warning.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isVerified ? Icons.verified : Icons.warning,
                size: 12,
                color: isVerified ? ATUColors.success : ATUColors.warning,
              ),
              const SizedBox(width: 4),
              Text(
                isVerified ? 'Verified' : 'Unverified',
                style: ATUTextStyles.caption.copyWith(
                  color: isVerified ? ATUColors.success : ATUColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Stats',
                style: ATUTextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Years Since Graduation',
                      '2',
                      Icons.school_rounded,
                      ATUColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Network Connections',
                      '142',
                      Icons.people_rounded,
                      ATUColors.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Unread Messages',
                      '7',
                      Icons.message_rounded,
                      ATUColors.error,
                      showBadge: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Forum Posts',
                      '24',
                      Icons.forum_rounded,
                      ATUColors.info,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildStatCard(
                'Events Attended This Year',
                '8 Events',
                Icons.event_rounded,
                ATUColors.primaryGold,
                isWide: true,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 300.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 300.ms, duration: 600.ms);
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    bool showBadge = false,
    bool isWide = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ATUColors.grey400.withValues(alpha: .1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: isWide
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withValues(alpha: .7)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: ATUColors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: ATUTextStyles.h3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        title,
                        style: ATUTextStyles.bodySmall.copyWith(
                          color: ATUColors.grey600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withValues(alpha: .7)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(icon, color: ATUColors.white, size: 24),
                    ),
                    if (showBadge)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: ATUColors.error,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ATUColors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  value,
                  style: ATUTextStyles.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: ATUTextStyles.caption.copyWith(
                    color: ATUColors.grey600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }

  Widget _buildPriorityActions() {
    return Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Priority Actions',
                style: ATUTextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildActionCard(
                    'Complete Profile',
                    'Add missing details',
                    Icons.person_outline_rounded,
                    ATUColors.warning,
                    hasUrgentBadge: true,
                  ),
                  _buildActionCard(
                    'Take Tracer Survey',
                    'Share your progress',
                    Icons.assignment_rounded,
                    ATUColors.primaryBlue,
                  ),
                  _buildActionCard(
                    'Check Messages',
                    '7 unread messages',
                    Icons.message_outlined,
                    ATUColors.error,
                    hasNotificationBadge: true,
                  ),
                  _buildActionCard(
                    'Join Forum Discussions',
                    'Connect with peers',
                    Icons.forum_outlined,
                    ATUColors.info,
                  ),
                  _buildActionCard(
                    'Update Employment',
                    'Current job status',
                    Icons.work_outline_rounded,
                    ATUColors.success,
                  ),
                  _buildActionCard(
                    'Verify Contacts',
                    'Confirm phone number',
                    Icons.verified_user_outlined,
                    ATUColors.primaryGold,
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildActionCard(
    String title,
    String subtitle,
    IconData icon,
    Color color, {
    bool hasUrgentBadge = false,
    bool hasNotificationBadge = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(20),
        border: hasUrgentBadge
            ? Border.all(
                color: ATUColors.warning.withValues(alpha: .3),
                width: 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: ATUColors.grey400.withValues(alpha: .1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: .7)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: ATUColors.white, size: 24),
              ),
              if (hasUrgentBadge)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: ATUColors.warning,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.priority_high,
                      color: ATUColors.white,
                      size: 12,
                    ),
                  ),
                ),
              if (hasNotificationBadge)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: ATUColors.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: ATUColors.white, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '7',
                        style: ATUTextStyles.caption.copyWith(
                          color: ATUColors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: ATUTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: ATUTextStyles.caption.copyWith(color: ATUColors.grey600),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activities',
                style: ATUTextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(4, (index) => _buildActivityItem(index)),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms, duration: 600.ms);
  }

  Widget _buildActivityItem(int index) {
    final activities = [
      {
        'title': 'New Forum Post',
        'subtitle': 'Discussion: "Tech Trends in 2025"',
        'time': '1 hour ago',
        'icon': Icons.forum,
        'color': ATUColors.info,
      },
      {
        'title': 'Survey Completed',
        'subtitle': 'Career Progress Survey 2024',
        'time': '2 hours ago',
        'icon': Icons.check_circle,
        'color': ATUColors.success,
      },
      {
        'title': 'New Message',
        'subtitle': 'Sarah Johnson sent you a message',
        'time': '1 day ago',
        'icon': Icons.message,
        'color': ATUColors.primaryBlue,
      },
      {
        'title': 'Event Registration',
        'subtitle': 'ATU Alumni Networking Night',
        'time': '3 days ago',
        'icon': Icons.event,
        'color': ATUColors.primaryGold,
      },
    ];

    final activity = activities[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  activity['color'] as Color,
                  (activity['color'] as Color).withValues(alpha: .7),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              activity['icon'] as IconData,
              color: ATUColors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'] as String,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ATUColors.grey900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity['subtitle'] as String,
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                activity['time'] as String,
                style: ATUTextStyles.caption.copyWith(color: ATUColors.grey500),
              ),
              const SizedBox(height: 4),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: activity['color'] as Color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
