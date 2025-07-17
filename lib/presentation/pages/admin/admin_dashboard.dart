// lib/presentation/pages/admin/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/atu_button.dart';
import '../auth/login_screen.dart';
import 'dart:math' as math;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _floatingController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _floatingController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Enhanced background with floating elements
          _buildEnhancedBackground(),

          Container(
            decoration: const BoxDecoration(
              gradient: ATUColors.backgroundGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildEnhancedHeader(),
                  _buildEnhancedStatsOverview(),
                  _buildEnhancedTabBar(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildEnhancedOverviewTab(),
                        _buildEnhancedSurveysTab(),
                        _buildEnhancedAlumniTab(),
                        _buildEnhancedReportsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildAdminFAB(),
    );
  }

  Widget _buildEnhancedBackground() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ATUColors.primaryBlue.withValues(alpha: .03),
                    ATUColors.primaryGold.withValues(alpha: .02),
                    ATUColors.white,
                  ],
                ),
              ),
            ),
            ...List.generate(6, (index) {
              final animationOffset =
                  (_floatingController.value + index * 0.15) % 1.0;
              return _buildFloatingElement(index, animationOffset);
            }),
          ],
        );
      },
    );
  }

  Widget _buildFloatingElement(int index, double animationOffset) {
    final screenSize = MediaQuery.of(context).size;

    return Positioned(
      left:
          (screenSize.width * 0.1) +
          (screenSize.width * 0.8 * (index % 3) / 3) +
          (math.sin(animationOffset * 2 * math.pi) * 20),
      top:
          (screenSize.height * 0.1) +
          (screenSize.height * 0.8 * animationOffset) +
          (math.cos(animationOffset * 2 * math.pi) * 15),
      child: Container(
        width: 6 + (index % 2) * 2,
        height: 6 + (index % 2) * 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ATUColors.primaryBlue.withValues(
                alpha: 0.2 - animationOffset * 0.15,
              ),
              ATUColors.primaryGold.withValues(
                alpha: 0.1 - animationOffset * 0.08,
              ),
            ],
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildEnhancedHeader() {
    return Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Dashboard',
                      style: ATUTextStyles.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ATUColors.grey900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ATU Alumni & Tracer Study Management',
                      style: ATUTextStyles.bodyMedium.copyWith(
                        color: ATUColors.grey600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ATUColors.success.withValues(alpha: .1),
                            ATUColors.success.withValues(alpha: .05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ATUColors.success.withValues(alpha: .3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: ATUColors.success,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'System Online',
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
              ),
              Row(
                children: [
                  // Logout button
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ATUColors.white.withValues(alpha: .9),
                          ATUColors.white.withValues(alpha: .7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ATUColors.white.withValues(alpha: .3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ATUColors.grey400.withValues(alpha: .15),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: _logout,
                      child: const Icon(
                        Icons.logout_rounded,
                        color: ATUColors.error,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Admin profile
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ATUColors.white.withValues(alpha: .9),
                          ATUColors.white.withValues(alpha: .7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ATUColors.white.withValues(alpha: .3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ATUColors.grey400.withValues(alpha: .15),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.admin_panel_settings_rounded,
                          color: ATUColors.primaryBlue,
                          size: 24,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: ATUColors.success,
                              shape: BoxShape.circle,
                            ),
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

  Widget _buildEnhancedStatsOverview() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(
                child: _buildEnhancedStatCard(
                  'Total Alumni',
                  '2,847',
                  Icons.people_rounded,
                  ATUColors.primaryBlue,
                  '+12% this month',
                  87.5, // Progress percentage
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildEnhancedStatCard(
                  'Survey Responses',
                  '1,234',
                  Icons.poll_rounded,
                  ATUColors.success,
                  '67% response rate',
                  67.0,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildEnhancedStatCard(
                  'Active Jobs',
                  '89',
                  Icons.work_rounded,
                  ATUColors.primaryGold,
                  '23 posted this week',
                  92.3,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildEnhancedStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
    double progress,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ATUColors.white.withValues(alpha: .95),
            ATUColors.white.withValues(alpha: .85),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: .15), width: 1),
        boxShadow: [
          BoxShadow(
            color: ATUColors.grey400.withValues(alpha: .1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: ATUColors.white.withValues(alpha: .8),
            blurRadius: 15,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: .7)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: ATUColors.white, size: 20),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.trending_up_rounded, color: color, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: ATUTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: ATUTextStyles.bodySmall.copyWith(
              color: ATUColors.grey600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: ATUTextStyles.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          // Progress bar
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: .7)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedTabBar() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ATUColors.white.withValues(alpha: .9),
                ATUColors.white.withValues(alpha: .7),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ATUColors.white.withValues(alpha: .3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: ATUColors.grey400.withValues(alpha: .1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              gradient: ATUColors.primaryGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: ATUColors.primaryBlue.withValues(alpha: .3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: ATUColors.white,
            unselectedLabelColor: ATUColors.grey600,
            labelStyle: ATUTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Surveys'),
              Tab(text: 'Alumni'),
              Tab(text: 'Reports'),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildEnhancedOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Actions
          Text(
            'Quick Actions',
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: EnhancedAdminActionCard(
                  title: 'Create Survey',
                  subtitle: 'Launch new tracer study',
                  icon: Icons.add_chart_rounded,
                  color: ATUColors.primaryBlue,
                  onTap: () => _showCreateSurveyDialog(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: EnhancedAdminActionCard(
                  title: 'Export Data',
                  subtitle: 'Download alumni reports',
                  icon: Icons.download_rounded,
                  color: ATUColors.success,
                  onTap: () => _showExportDialog(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: EnhancedAdminActionCard(
                  title: 'Send Reminders',
                  subtitle: 'Survey follow-ups',
                  icon: Icons.notifications_active_rounded,
                  color: ATUColors.primaryGold,
                  onTap: () => _showRemindersDialog(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: EnhancedAdminActionCard(
                  title: 'User Management',
                  subtitle: 'Manage alumni accounts',
                  icon: Icons.manage_accounts_rounded,
                  color: ATUColors.info,
                  onTap: () => _showUserManagementDialog(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Recent Activity with enhanced design
          Text(
            'Recent Activity',
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ATUColors.white.withValues(alpha: .95),
                  ATUColors.white.withValues(alpha: .85),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ATUColors.white.withValues(alpha: .3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: ATUColors.grey400.withValues(alpha: .1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildEnhancedActivityItem(
                  'New survey "Employment Status 2024" created',
                  '2 hours ago',
                  Icons.add_chart_rounded,
                  ATUColors.primaryBlue,
                ),
                const SizedBox(height: 16),
                _buildEnhancedActivityItem(
                  '45 alumni responded to current survey',
                  '5 hours ago',
                  Icons.poll_rounded,
                  ATUColors.success,
                ),
                const SizedBox(height: 16),
                _buildEnhancedActivityItem(
                  'Monthly report exported by Dr. Nyanor',
                  '1 day ago',
                  Icons.download_rounded,
                  ATUColors.primaryGold,
                ),
                const SizedBox(height: 16),
                _buildEnhancedActivityItem(
                  '12 new alumni registered in the system',
                  '2 days ago',
                  Icons.person_add_rounded,
                  ATUColors.info,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildEnhancedActivityItem(
    String description,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: .1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: .7)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: ATUColors.white, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ATUColors.grey900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: color.withValues(alpha: .6),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedSurveysTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Survey Management',
                style: ATUTextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              ATUButton(
                text: 'Create Survey',
                onPressed: () => _showCreateSurveyDialog(),
                type: ATUButtonType.primary,
                size: ATUButtonSize.small,
                icon: Icons.add_rounded,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Survey Statistics
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: ATUColors.brandGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: ATUShadows.brand,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildSurveyStatItem('Active', '2', ATUColors.white),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: ATUColors.white.withValues(alpha: .3),
                ),
                Expanded(
                  child: _buildSurveyStatItem('Draft', '1', ATUColors.white),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: ATUColors.white.withValues(alpha: .3),
                ),
                Expanded(
                  child: _buildSurveyStatItem(
                    'Completed',
                    '1',
                    ATUColors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Active Surveys
          _buildEnhancedSurveySection(
            'Active Surveys',
            _mockActiveSurveys,
            true,
          ),
          const SizedBox(height: 24),

          // Draft Surveys
          _buildEnhancedSurveySection(
            'Draft Surveys',
            _mockDraftSurveys,
            false,
          ),
          const SizedBox(height: 24),

          // Completed Surveys
          _buildEnhancedSurveySection(
            'Completed Surveys',
            _mockCompletedSurveys,
            false,
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSurveyStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: ATUTextStyles.h3.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: ATUTextStyles.bodySmall.copyWith(
            color: color.withValues(alpha: .9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedSurveySection(
    String title,
    List<SurveyModel> surveys,
    bool isActive,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ATUTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: ATUColors.grey800,
          ),
        ),
        const SizedBox(height: 12),
        if (surveys.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ATUColors.grey50.withValues(alpha: .8),
                  ATUColors.grey50.withValues(alpha: .6),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ATUColors.grey200),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.poll_outlined, size: 48, color: ATUColors.grey400),
                  const SizedBox(height: 16),
                  Text(
                    'No ${title.toLowerCase()} found',
                    style: ATUTextStyles.bodyMedium.copyWith(
                      color: ATUColors.grey500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...surveys.map(
            (survey) => _buildEnhancedSurveyCard(survey, isActive),
          ),
      ],
    );
  }

  Widget _buildEnhancedSurveyCard(SurveyModel survey, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ATUColors.white.withValues(alpha: .95),
            ATUColors.white.withValues(alpha: .85),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? ATUColors.success.withValues(alpha: .3)
              : _getSurveyStatusColor(survey.status).withValues(alpha: .2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: ATUColors.grey400.withValues(alpha: .08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  survey.title,
                  style: ATUTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ATUColors.grey900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getSurveyStatusColor(survey.status),
                      _getSurveyStatusColor(
                        survey.status,
                      ).withValues(alpha: .7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  survey.status,
                  style: ATUTextStyles.caption.copyWith(
                    color: ATUColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            survey.description,
            style: ATUTextStyles.bodyMedium.copyWith(
              color: ATUColors.grey600,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),

          // Progress indicator
          if (survey.status == 'Active') ...[
            Row(
              children: [
                Text(
                  'Progress: ',
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.grey600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${survey.responseCount}/${survey.targetCount}',
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: ATUColors.grey200,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (survey.responseCount / survey.targetCount).clamp(
                  0.0,
                  1.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: ATUColors.primaryGradient,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          Row(
            children: [
              _buildSurveyInfo(
                Icons.people_rounded,
                '${survey.targetCount} target',
              ),
              const SizedBox(width: 16),
              _buildSurveyInfo(
                Icons.check_circle_rounded,
                '${survey.responseCount} responses',
              ),
              const SizedBox(width: 16),
              _buildSurveyInfo(
                Icons.calendar_today_rounded,
                survey.createdDate,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ATUButton(
                  text: 'View Details',
                  onPressed: () => _viewSurveyDetails(survey),
                  type: ATUButtonType.outline,
                  size: ATUButtonSize.small,
                  icon: Icons.visibility_rounded,
                ),
              ),
              const SizedBox(width: 12),
              if (survey.status == 'Active')
                Expanded(
                  child: ATUButton(
                    text: 'Send Reminder',
                    onPressed: () => _sendSurveyReminder(survey),
                    type: ATUButtonType.secondary,
                    size: ATUButtonSize.small,
                    icon: Icons.notifications_rounded,
                  ),
                ),
              if (survey.status == 'Draft')
                Expanded(
                  child: ATUButton(
                    text: 'Publish',
                    onPressed: () => _publishSurvey(survey),
                    type: ATUButtonType.primary,
                    size: ATUButtonSize.small,
                    icon: Icons.publish_rounded,
                  ),
                ),
              if (survey.status == 'Completed')
                Expanded(
                  child: ATUButton(
                    text: 'Download',
                    onPressed: () => _downloadSurveyData(survey),
                    type: ATUButtonType.primary,
                    size: ATUButtonSize.small,
                    icon: Icons.download_rounded,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedAlumniTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alumni Management',
                style: ATUTextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              ATUButton(
                text: 'Add Alumni',
                onPressed: () => _showAddAlumniDialog(),
                type: ATUButtonType.primary,
                size: ATUButtonSize.small,
                icon: Icons.person_add_rounded,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Alumni statistics
          Row(
            children: [
              Expanded(
                child: _buildAlumniStatCard(
                  'Total Alumni',
                  '2,847',
                  Icons.people_rounded,
                  ATUColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAlumniStatCard(
                  'Active This Month',
                  '1,234',
                  Icons.login_rounded,
                  ATUColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAlumniStatCard(
                  'New This Week',
                  '47',
                  Icons.person_add_rounded,
                  ATUColors.primaryGold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Search and filter
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ATUColors.white.withValues(alpha: .95),
                  ATUColors.white.withValues(alpha: .85),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ATUColors.white.withValues(alpha: .3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: ATUColors.grey400.withValues(alpha: .1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: ATUColors.grey50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ATUColors.grey200),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search alumni...',
                            prefixIcon: const Icon(Icons.search_rounded),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ATUButton(
                      text: 'Filter',
                      onPressed: () => _showAlumniFilters(),
                      type: ATUButtonType.outline,
                      size: ATUButtonSize.small,
                      icon: Icons.filter_list_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ATUButton(
                        text: 'Export List',
                        onPressed: () => _exportAlumniList(),
                        type: ATUButtonType.secondary,
                        size: ATUButtonSize.small,
                        icon: Icons.download_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ATUButton(
                        text: 'Send Bulk Email',
                        onPressed: () => _showBulkEmailDialog(),
                        type: ATUButtonType.outline,
                        size: ATUButtonSize.small,
                        icon: Icons.email_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Recent alumni
          Text(
            'Recent Registrations',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey800,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(5, (index) => _buildAlumniListItem(index)),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildAlumniStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: .1), color.withValues(alpha: .05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: .2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: ATUTextStyles.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAlumniListItem(int index) {
    final names = [
      'John Doe',
      'Sarah Johnson',
      'Michael Asante',
      'Jennifer Lee',
      'David Mensah',
    ];
    final programs = [
      'Computer Science',
      'Business Administration',
      'Engineering',
      'Architecture',
      'Applied Sciences',
    ];
    final years = ['2024', '2023', '2024', '2022', '2023'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ATUColors.white.withValues(alpha: .95),
            ATUColors.white.withValues(alpha: .85),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ATUColors.grey200),
        boxShadow: [
          BoxShadow(
            color: ATUColors.grey400.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: ATUColors.primaryBlue,
            child: Text(
              names[index].substring(0, 2).toUpperCase(),
              style: ATUTextStyles.bodySmall.copyWith(
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
                  names[index],
                  style: ATUTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ATUColors.grey900,
                  ),
                ),
                Text(
                  '${programs[index]} • Class of ${years[index]}',
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _editAlumni(index),
                icon: const Icon(Icons.edit_rounded, size: 18),
                style: IconButton.styleFrom(
                  backgroundColor: ATUColors.info.withValues(alpha: .1),
                  foregroundColor: ATUColors.info,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _deleteAlumni(index),
                icon: const Icon(Icons.delete_rounded, size: 18),
                style: IconButton.styleFrom(
                  backgroundColor: ATUColors.error.withValues(alpha: .1),
                  foregroundColor: ATUColors.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics & Reports',
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 16),

          // Quick stats grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildReportCard(
                'Employment Rate',
                '87.5%',
                Icons.work_rounded,
                ATUColors.success,
                '+5.2% vs last year',
              ),
              _buildReportCard(
                'Average Salary',
                '₵8,420',
                Icons.payments_rounded,
                ATUColors.primaryGold,
                '+12% increase',
              ),
              _buildReportCard(
                'Survey Response',
                '67%',
                Icons.poll_rounded,
                ATUColors.primaryBlue,
                'Above target',
              ),
              _buildReportCard(
                'Alumni Satisfaction',
                '4.3/5',
                Icons.star_rounded,
                ATUColors.primaryGold,
                'Excellent rating',
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Report generation
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ATUColors.white.withValues(alpha: .95),
                  ATUColors.white.withValues(alpha: .85),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ATUColors.white.withValues(alpha: .3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: ATUColors.grey400.withValues(alpha: .1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Generate Reports',
                  style: ATUTextStyles.h5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ATUColors.grey900,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildReportButton(
                        'Alumni Report',
                        'Complete alumni database',
                        Icons.people_rounded,
                        ATUColors.primaryBlue,
                        () => _generateReport('alumni'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildReportButton(
                        'Survey Report',
                        'Response analysis',
                        Icons.analytics_rounded,
                        ATUColors.success,
                        () => _generateReport('survey'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildReportButton(
                        'Employment Report',
                        'Job placement data',
                        Icons.work_rounded,
                        ATUColors.primaryGold,
                        () => _generateReport('employment'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildReportButton(
                        'Custom Report',
                        'Build your own',
                        Icons.build_rounded,
                        ATUColors.info,
                        () => _showCustomReportDialog(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildReportCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: .1), color.withValues(alpha: .05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: .2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const Spacer(),
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
              color: ATUColors.grey700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: ATUTextStyles.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportButton(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: .2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: ATUTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: ATUColors.grey900,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: ATUTextStyles.caption.copyWith(color: ATUColors.grey600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSurveyInfo(IconData icon, String text) {
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

  Color _getSurveyStatusColor(String status) {
    switch (status) {
      case 'Active':
        return ATUColors.success;
      case 'Draft':
        return ATUColors.warning;
      case 'Completed':
        return ATUColors.info;
      default:
        return ATUColors.grey500;
    }
  }

  Widget _buildAdminFAB() {
    return FloatingActionButton.extended(
      onPressed: () => _showQuickActions(),
      backgroundColor: ATUColors.primaryGold,
      foregroundColor: ATUColors.white,
      elevation: 8,
      icon: const Icon(Icons.dashboard_customize_rounded),
      label: Text(
        'Quick Actions',
        style: ATUTextStyles.buttonTextSmall.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    ).animate().scale(delay: 800.ms);
  }

  // Action methods
  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text(
          'Are you sure you want to logout from admin dashboard?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ATUButton(
            text: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            type: ATUButtonType.primary,
            size: ATUButtonSize.small,
          ),
        ],
      ),
    );
  }

  void _showCreateSurveyDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildCreateSurveyDialog(),
    );
  }

  Widget _buildCreateSurveyDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Create New Survey',
        style: ATUTextStyles.h5.copyWith(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Survey Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ATUButton(
          text: 'Create',
          onPressed: () {
            Navigator.pop(context);
            _showSuccessMessage('Survey created successfully!');
          },
          type: ATUButtonType.primary,
          size: ATUButtonSize.small,
        ),
      ],
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Export Data'),
        content: const Text('Choose export format:'),
        actions: [
          ATUButton(
            text: 'Excel',
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Exporting to Excel...');
            },
            type: ATUButtonType.outline,
            size: ATUButtonSize.small,
          ),
          ATUButton(
            text: 'PDF',
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Exporting to PDF...');
            },
            type: ATUButtonType.primary,
            size: ATUButtonSize.small,
          ),
        ],
      ),
    );
  }

  void _showRemindersDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Send Reminders'),
        content: const Text('Send survey reminders to all pending alumni?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ATUButton(
            text: 'Send',
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Reminders sent to 234 alumni');
            },
            type: ATUButtonType.primary,
            size: ATUButtonSize.small,
          ),
        ],
      ),
    );
  }

  void _showUserManagementDialog() {
    _showSuccessMessage('User management feature coming soon!');
  }

  void _showAddAlumniDialog() {
    _showSuccessMessage('Add alumni feature coming soon!');
  }

  void _showAlumniFilters() {
    _showSuccessMessage('Alumni filters coming soon!');
  }

  void _exportAlumniList() {
    _showSuccessMessage('Exporting alumni list...');
  }

  void _showBulkEmailDialog() {
    _showSuccessMessage('Bulk email feature coming soon!');
  }

  void _editAlumni(int index) {
    _showSuccessMessage('Edit alumni feature coming soon!');
  }

  void _deleteAlumni(int index) {
    _showSuccessMessage('Delete alumni feature coming soon!');
  }

  void _showCustomReportDialog() {
    _showSuccessMessage('Custom report builder coming soon!');
  }

  void _generateReport(String type) {
    _showSuccessMessage('Generating $type report...');
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: ATUColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Actions',
              style: ATUTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildQuickActionItem(
                  'Create Survey',
                  Icons.add_chart_rounded,
                  ATUColors.primaryBlue,
                ),
                _buildQuickActionItem(
                  'Export Data',
                  Icons.download_rounded,
                  ATUColors.success,
                ),
                _buildQuickActionItem(
                  'Send Reminders',
                  Icons.notifications_rounded,
                  ATUColors.primaryGold,
                ),
                _buildQuickActionItem(
                  'View Reports',
                  Icons.analytics_rounded,
                  ATUColors.info,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: .3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: ATUTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _viewSurveyDetails(SurveyModel survey) {
    _showSuccessMessage('Viewing details for ${survey.title}');
  }

  void _sendSurveyReminder(SurveyModel survey) {
    _showSuccessMessage('Reminder sent for ${survey.title}');
  }

  void _publishSurvey(SurveyModel survey) {
    _showSuccessMessage('${survey.title} published successfully');
  }

  void _downloadSurveyData(SurveyModel survey) {
    _showSuccessMessage('Downloading data for ${survey.title}');
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: ATUColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: ATUColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// Enhanced Admin Action Card Widget
class EnhancedAdminActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const EnhancedAdminActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ATUColors.white.withValues(alpha: .95),
              ATUColors.white.withValues(alpha: .85),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: .15), width: 1),
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: .7)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: .3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: ATUColors.white, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: ATUTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: ATUColors.grey900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: ATUTextStyles.bodySmall.copyWith(
                color: ATUColors.grey600,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Survey Model (keeping existing structure)
class SurveyModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final int targetCount;
  final int responseCount;
  final String createdDate;

  SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.targetCount,
    required this.responseCount,
    required this.createdDate,
  });
}

// Mock survey data (keeping existing data)
final List<SurveyModel> _mockActiveSurveys = [
  SurveyModel(
    id: '1',
    title: 'Employment Status Survey 2024',
    description:
        'Current employment status and salary information for Class of 2024 graduates.',
    status: 'Active',
    targetCount: 150,
    responseCount: 87,
    createdDate: 'Dec 1, 2024',
  ),
  SurveyModel(
    id: '2',
    title: 'Career Progression Analysis',
    description:
        'Track career advancement and professional development of alumni from 2020-2023.',
    status: 'Active',
    targetCount: 200,
    responseCount: 134,
    createdDate: 'Nov 28, 2024',
  ),
];

final List<SurveyModel> _mockDraftSurveys = [
  SurveyModel(
    id: '3',
    title: 'Skills Gap Analysis',
    description:
        'Identify skills gaps in current curriculum based on industry demands.',
    status: 'Draft',
    targetCount: 300,
    responseCount: 0,
    createdDate: 'Dec 5, 2024',
  ),
];

final List<SurveyModel> _mockCompletedSurveys = [
  SurveyModel(
    id: '4',
    title: 'Alumni Satisfaction Survey',
    description:
        'Overall satisfaction with ATU education and recommendations for improvement.',
    status: 'Completed',
    targetCount: 100,
    responseCount: 95,
    createdDate: 'Oct 15, 2024',
  ),
];
