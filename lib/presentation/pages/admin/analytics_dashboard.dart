// lib/presentation/pages/admin/analytics_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/common/atu_button.dart';
import '../../widgets/charts/employment_chart.dart';
import '../../widgets/charts/program_effectiveness_chart.dart';
//import '../../widgets/charts/alumni_distribution_chart.dart';

class AnalyticsDashboard extends StatefulWidget {
  const AnalyticsDashboard({super.key});

  @override
  State<AnalyticsDashboard> createState() => _AnalyticsDashboardState();
}

class _AnalyticsDashboardState extends State<AnalyticsDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTimeRange = 'Last 12 Months';
  String _selectedProgram = 'All Programs';

  final List<String> _timeRanges = [
    'Last 3 Months',
    'Last 6 Months',
    'Last 12 Months',
    'Last 2 Years',
    'All Time',
  ];

  final List<String> _programs = [
    'All Programs',
    'Computer Science',
    'Engineering',
    'Business Administration',
    'Architecture',
    'Hospitality Management',
    'Applied Sciences',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: ATUColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildFilters(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildEmploymentAnalytics(),
                    _buildProgramAnalytics(),
                    _buildSurveyAnalytics(),
                    _buildReportsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _generateReport,
        backgroundColor: ATUColors.primaryGold,
        icon: const Icon(Icons.download_rounded),
        label: const Text('Export Report'),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analytics Dashboard',
                      style: ATUTextStyles.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ATUColors.grey900,
                      ),
                    ),
                    Text(
                      'Alumni career outcomes and program effectiveness',
                      style: ATUTextStyles.bodyMedium.copyWith(
                        color: ATUColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ATUColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: ATUColors.grey400.withValues(alpha: .2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: ATUColors.primaryBlue,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.2, end: 0, duration: 600.ms);
  }

  Widget _buildFilters() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: ATUColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ATUColors.grey300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedTimeRange,
                      onChanged: (value) {
                        setState(() {
                          _selectedTimeRange = value!;
                        });
                      },
                      items: _timeRanges.map((range) {
                        return DropdownMenuItem<String>(
                          value: range,
                          child: Text(range, style: ATUTextStyles.bodyMedium),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: ATUColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ATUColors.grey300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedProgram,
                      onChanged: (value) {
                        setState(() {
                          _selectedProgram = value!;
                        });
                      },
                      items: _programs.map((program) {
                        return DropdownMenuItem<String>(
                          value: program,
                          child: Text(program, style: ATUTextStyles.bodyMedium),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildTabBar() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: ATUColors.grey100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: ATUColors.primaryBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: ATUColors.white,
            unselectedLabelColor: ATUColors.grey600,
            labelStyle: ATUTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: 'Employment'),
              Tab(text: 'Programs'),
              Tab(text: 'Surveys'),
              Tab(text: 'Reports'),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildEmploymentAnalytics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key employment metrics
          _buildMetricsRow([
            _buildMetricCard(
              'Employment Rate',
              '87.5%',
              ATUColors.success,
              Icons.work_rounded,
            ),
            _buildMetricCard(
              'Avg. Salary',
              '₵8,500',
              ATUColors.primaryBlue,
              Icons.payments_rounded,
            ),
            _buildMetricCard(
              'Job Placement',
              '6 months',
              ATUColors.primaryGold,
              Icons.schedule_rounded,
            ),
          ]),

          const SizedBox(height: 24),

          // Employment status chart
          _buildChartSection(
            'Employment Status Distribution',
            'Current employment status of alumni',
            const EmploymentChart(),
          ),

          const SizedBox(height: 24),

          // Salary ranges
          _buildChartSection(
            'Salary Distribution by Experience Level',
            'Average salary ranges across different experience levels',
            _buildSalaryChart(),
          ),

          const SizedBox(height: 24),

          // Employment by industry
          _buildChartSection(
            'Employment by Industry',
            'Top industries where our alumni work',
            _buildIndustryChart(),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildProgramAnalytics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Program effectiveness metrics
          _buildMetricsRow([
            _buildMetricCard(
              'Best Program',
              'Computer Sci.',
              ATUColors.success,
              Icons.school_rounded,
            ),
            _buildMetricCard(
              'Avg. Rating',
              '4.2/5',
              ATUColors.primaryBlue,
              Icons.star_rounded,
            ),
            _buildMetricCard(
              'Skills Match',
              '78%',
              ATUColors.primaryGold,
              Icons.psychology_rounded,
            ),
          ]),

          const SizedBox(height: 24),

          // Program effectiveness chart
          _buildChartSection(
            'Program Effectiveness Analysis',
            'Employment outcomes by academic program',
            const ProgramEffectivenessChart(),
          ),

          const SizedBox(height: 24),

          // Skills gap analysis
          _buildChartSection(
            'Skills Gap Analysis',
            'Most requested skills vs. curriculum coverage',
            _buildSkillsGapChart(),
          ),

          const SizedBox(height: 24),

          // Graduate satisfaction
          _buildChartSection(
            'Graduate Satisfaction by Program',
            'Alumni satisfaction ratings for each program',
            _buildSatisfactionChart(),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSurveyAnalytics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Survey response metrics
          _buildMetricsRow([
            _buildMetricCard(
              'Response Rate',
              '67.3%',
              ATUColors.success,
              Icons.poll_rounded,
            ),
            _buildMetricCard(
              'Active Surveys',
              '3',
              ATUColors.primaryBlue,
              Icons.quiz_rounded,
            ),
            _buildMetricCard(
              'Total Responses',
              '1,234',
              ATUColors.primaryGold,
              Icons.people_rounded,
            ),
          ]),

          const SizedBox(height: 24),

          // Survey response trends
          _buildChartSection(
            'Survey Response Trends',
            'Response rates over time',
            _buildResponseTrendsChart(),
          ),

          const SizedBox(height: 24),

          // Survey completion rates
          _buildChartSection(
            'Survey Completion Analysis',
            'Completion rates by survey type and length',
            _buildCompletionRatesChart(),
          ),

          const SizedBox(height: 24),

          // Response quality metrics
          _buildChartSection(
            'Response Quality Metrics',
            'Analysis of response quality and engagement',
            _buildResponseQualityChart(),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Generated Reports',
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 16),

          // Quick report generation
          _buildQuickReports(),

          const SizedBox(height: 24),

          Text(
            'Recent Reports',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey800,
            ),
          ),
          const SizedBox(height: 12),

          // Recent reports list
          ..._mockReports.map((report) => _buildReportItem(report)),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildMetricsRow(List<Widget> metrics) {
    return Row(
      children: metrics
          .map((metric) => Expanded(child: metric))
          .expand((widget) => [widget, const SizedBox(width: 12)])
          .take(metrics.length * 2 - 1)
          .toList(),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.trending_up_rounded, color: color, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: ATUTextStyles.h4.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          Text(
            title,
            style: ATUTextStyles.bodySmall.copyWith(
              color: ATUColors.grey600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection(String title, String subtitle, Widget chart) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _exportChart(title),
                icon: const Icon(
                  Icons.download_rounded,
                  color: ATUColors.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(height: 300, child: chart),
        ],
      ),
    );
  }

  Widget _buildSalaryChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.bar_chart_rounded,
            size: 48,
            color: ATUColors.primaryBlue,
          ),
          const SizedBox(height: 16),
          Text(
            'Salary Distribution Chart',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
          Text(
            'Interactive chart will be rendered here',
            style: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey500),
          ),
        ],
      ),
    );
  }

  Widget _buildIndustryChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.pie_chart_rounded,
            size: 48,
            color: ATUColors.success,
          ),
          const SizedBox(height: 16),
          Text(
            'Industry Distribution Chart',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
          Text(
            'Pie chart showing employment by industry',
            style: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey500),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsGapChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.psychology_rounded,
            size: 48,
            color: ATUColors.primaryGold,
          ),
          const SizedBox(height: 16),
          Text(
            'Skills Gap Analysis',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
          Text(
            'Comparison of industry needs vs. curriculum',
            style: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey500),
          ),
        ],
      ),
    );
  }

  Widget _buildSatisfactionChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sentiment_satisfied_rounded,
            size: 48,
            color: ATUColors.success,
          ),
          const SizedBox(height: 16),
          Text(
            'Graduate Satisfaction',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
          Text(
            'Satisfaction ratings by program',
            style: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey500),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseTrendsChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.trending_up_rounded,
            size: 48,
            color: ATUColors.info,
          ),
          const SizedBox(height: 16),
          Text(
            'Response Trends',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
          Text(
            'Survey response rates over time',
            style: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey500),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionRatesChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            size: 48,
            color: ATUColors.success,
          ),
          const SizedBox(height: 16),
          Text(
            'Completion Rates',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
          Text(
            'Survey completion analysis',
            style: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey500),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseQualityChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.high_quality_rounded,
            size: 48,
            color: ATUColors.primaryGold,
          ),
          const SizedBox(height: 16),
          Text(
            'Response Quality',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: ATUColors.grey700,
            ),
          ),
          Text(
            'Quality metrics and engagement analysis',
            style: ATUTextStyles.bodyMedium.copyWith(color: ATUColors.grey500),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReports() {
    return Container(
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
          Text(
            'Quick Report Generation',
            style: ATUTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: ATUColors.grey900,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildQuickReportButton('Employment Report', Icons.work_rounded),
              _buildQuickReportButton('Graduate Survey', Icons.poll_rounded),
              _buildQuickReportButton('Program Analysis', Icons.school_rounded),
              _buildQuickReportButton(
                'Skills Assessment',
                Icons.psychology_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReportButton(String title, IconData icon) {
    return GestureDetector(
      onTap: () => _generateQuickReport(title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: ATUColors.primaryBlue.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ATUColors.primaryBlue.withValues(alpha: .3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: ATUColors.primaryBlue, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: ATUTextStyles.bodySmall.copyWith(
                color: ATUColors.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(ReportModel report) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ATUColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ATUColors.grey200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getReportTypeColor(report.type).withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getReportTypeIcon(report.type),
              color: _getReportTypeColor(report.type),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.title,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ATUColors.grey900,
                  ),
                ),
                Text(
                  'Generated on ${report.generatedAt}',
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          ATUButton(
            text: 'Download',
            onPressed: () => _downloadReport(report),
            type: ATUButtonType.outline,
            size: ATUButtonSize.small,
            icon: Icons.download_rounded,
          ),
        ],
      ),
    );
  }

  Color _getReportTypeColor(String type) {
    switch (type) {
      case 'Employment':
        return ATUColors.success;
      case 'Survey':
        return ATUColors.primaryBlue;
      case 'Program':
        return ATUColors.primaryGold;
      default:
        return ATUColors.grey500;
    }
  }

  IconData _getReportTypeIcon(String type) {
    switch (type) {
      case 'Employment':
        return Icons.work_rounded;
      case 'Survey':
        return Icons.poll_rounded;
      case 'Program':
        return Icons.school_rounded;
      default:
        return Icons.description_rounded;
    }
  }

  void _generateReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generating comprehensive report...'),
        backgroundColor: ATUColors.primaryBlue,
      ),
    );
  }

  void _exportChart(String chartTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting $chartTitle...'),
        backgroundColor: ATUColors.success,
      ),
    );
  }

  void _generateQuickReport(String reportType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Generating $reportType...'),
        backgroundColor: ATUColors.primaryGold,
      ),
    );
  }

  void _downloadReport(ReportModel report) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading ${report.title}...'),
        backgroundColor: ATUColors.info,
      ),
    );
  }
}

// Report Model
class ReportModel {
  final String id;
  final String title;
  final String type;
  final String generatedAt;
  final String generatedBy;
  final String? fileUrl;

  ReportModel({
    required this.id,
    required this.title,
    required this.type,
    required this.generatedAt,
    required this.generatedBy,
    this.fileUrl,
  });
}

// Mock reports data
final List<ReportModel> _mockReports = [
  ReportModel(
    id: '1',
    title: 'Q4 2024 Employment Outcomes Report',
    type: 'Employment',
    generatedAt: 'Dec 1, 2024',
    generatedBy: 'Dr. Peter Nyanor',
  ),
  ReportModel(
    id: '2',
    title: 'Alumni Survey Results - November 2024',
    type: 'Survey',
    generatedAt: 'Nov 28, 2024',
    generatedBy: 'Admin User',
  ),
  ReportModel(
    id: '3',
    title: 'Program Effectiveness Analysis 2024',
    type: 'Program',
    generatedAt: 'Nov 15, 2024',
    generatedBy: 'Dr. Peter Nyanor',
  ),
];
