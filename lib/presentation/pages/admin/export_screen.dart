// lib/presentation/pages/admin/export_screen.dart
/*
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/export_service.dart';
import '../../widgets/common/atu_button.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  final ExportService _exportService = ExportServiceImpl();

  ExportFormat _selectedFormat = ExportFormat.csv;
  String _selectedDataType = 'Alumni Data';
  bool _isExporting = false;

  final List<String> _dataTypes = [
    'Alumni Data',
    'Survey Results',
    'Employment Analytics',
    'Program Effectiveness',
    'User Activity Report',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Data'),
        backgroundColor: ATUColors.primaryBlue,
        foregroundColor: ATUColors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: ATUColors.backgroundGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExportOptions(),
              const SizedBox(height: 32),
              _buildQuickExports(),
              const SizedBox(height: 32),
              _buildRecentExports(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExportOptions() {
    return Container(
          padding: const EdgeInsets.all(24),
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
                'Custom Export',
                style: ATUTextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ATUColors.grey900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Configure and export specific data sets',
                style: ATUTextStyles.bodyMedium.copyWith(
                  color: ATUColors.grey600,
                ),
              ),
              const SizedBox(height: 24),

              // Data type selection
              Text(
                'Data Type',
                style: ATUTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ATUColors.grey700,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: ATUColors.grey300),
                  borderRadius: BorderRadius.circular(12),
                  color: ATUColors.grey50,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedDataType,
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        _selectedDataType = value!;
                      });
                    },
                    items: _dataTypes.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Format selection
              Text(
                'Export Format',
                style: ATUTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ATUColors.grey700,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: ExportFormat.values.map((format) {
                  final isSelected = format == _selectedFormat;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFormat = format;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ATUColors.primaryBlue
                            : ATUColors.grey100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? ATUColors.primaryBlue
                              : ATUColors.grey300,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getFormatIcon(format),
                            color: isSelected
                                ? ATUColors.white
                                : ATUColors.grey600,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            format.name.toUpperCase(),
                            style: ATUTextStyles.bodyMedium.copyWith(
                              color: isSelected
                                  ? ATUColors.white
                                  : ATUColors.grey600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32),

              // Export button
              ATUButton(
                text: 'Generate Export',
                onPressed: _isExporting ? null : _performExport,
                type: ATUButtonType.primary,
                isFullWidth: true,
                isLoading: _isExporting,
                icon: Icons.download_rounded,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms);
  }

  Widget _buildQuickExports() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Exports',
              style: ATUTextStyles.h4.copyWith(
                fontWeight: FontWeight.bold,
                color: ATUColors.grey900,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildQuickExportCard(
                    'Alumni Directory',
                    'Complete alumni database',
                    Icons.people_rounded,
                    ATUColors.primaryBlue,
                    () => _quickExport('alumni'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickExportCard(
                    'Survey Results',
                    'All survey responses',
                    Icons.poll_rounded,
                    ATUColors.success,
                    () => _quickExport('surveys'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildQuickExportCard(
                    'Employment Data',
                    'Career outcomes report',
                    Icons.work_rounded,
                    ATUColors.primaryGold,
                    () => _quickExport('employment'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickExportCard(
                    'Analytics Report',
                    'Performance metrics',
                    Icons.analytics_rounded,
                    ATUColors.info,
                    () => _quickExport('analytics'),
                  ),
                ),
              ],
            ),
          ],
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildQuickExportCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ATUColors.white,
          borderRadius: BorderRadius.circular(12),
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: ATUTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: ATUColors.grey900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: ATUTextStyles.bodySmall.copyWith(color: ATUColors.grey600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentExports() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Exports',
              style: ATUTextStyles.h4.copyWith(
                fontWeight: FontWeight.bold,
                color: ATUColors.grey900,
              ),
            ),
            const SizedBox(height: 16),

            Container(
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
                children: [
                  _buildExportHistoryItem(
                    'Alumni Directory Export',
                    'CSV • 2,847 records',
                    'Dec 10, 2024 • 3:45 PM',
                    'alumni_directory_20241210.csv',
                    Icons.people_rounded,
                    ATUColors.primaryBlue,
                  ),
                  const Divider(),
                  _buildExportHistoryItem(
                    'Employment Survey Results',
                    'Excel • 456 responses',
                    'Dec 8, 2024 • 11:20 AM',
                    'employment_survey_results.xlsx',
                    Icons.poll_rounded,
                    ATUColors.success,
                  ),
                  const Divider(),
                  _buildExportHistoryItem(
                    'Q4 Analytics Report',
                    'PDF • 24 pages',
                    'Dec 5, 2024 • 2:15 PM',
                    'q4_analytics_report.pdf',
                    Icons.analytics_rounded,
                    ATUColors.info,
                  ),
                ],
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildExportHistoryItem(
    String title,
    String details,
    String date,
    String filename,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ATUTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ATUColors.grey900,
                  ),
                ),
                Text(
                  details,
                  style: ATUTextStyles.bodySmall.copyWith(
                    color: ATUColors.grey600,
                  ),
                ),
                Text(
                  date,
                  style: ATUTextStyles.caption.copyWith(
                    color: ATUColors.grey500,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _downloadExport(filename),
                icon: const Icon(Icons.download_rounded),
                color: ATUColors.primaryBlue,
              ),
              IconButton(
                onPressed: () => _shareExport(filename, title),
                icon: const Icon(Icons.share_rounded),
                color: ATUColors.grey500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getFormatIcon(ExportFormat format) {
    switch (format) {
      case ExportFormat.csv:
        return Icons.table_chart_rounded;
      case ExportFormat.excel:
        return Icons.grid_on_rounded;
      case ExportFormat.pdf:
        return Icons.picture_as_pdf_rounded;
      case ExportFormat.json:
        return Icons.data_object_rounded;
    }
  }

  void _performExport() async {
    setState(() {
      _isExporting = true;
    });

    try {
      String filename;

      switch (_selectedDataType) {
        case 'Alumni Data':
          filename = await _exportService.exportAlumniData([], _selectedFormat);
          break;
        case 'Survey Results':
          filename = await _exportService.exportSurveyResults(
            'survey_123',
            _selectedFormat,
          );
          break;
        default:
          filename = await _exportService.exportAnalyticsReport({
            'total_alumni': 2847,
            'employment_rate': 87.5,
            'survey_responses': 1234,
          }, _selectedFormat);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export completed: $filename'),
            backgroundColor: ATUColors.success,
            action: SnackBarAction(
              label: 'Download',
              textColor: ATUColors.white,
              onPressed: () => _downloadExport(filename),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: ${e.toString()}'),
            backgroundColor: ATUColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
        });
      }
    }
  }

  void _quickExport(String type) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Generating $type export...'),
        backgroundColor: ATUColors.primaryBlue,
      ),
    );

    // Simulate quick export
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$type export completed'),
          backgroundColor: ATUColors.success,
        ),
      );
    }
  }

  void _downloadExport(String filename) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading $filename...'),
        backgroundColor: ATUColors.info,
      ),
    );
  }

  void _shareExport(String filename, String title) async {
    await _exportService.shareExport(filename, title);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sharing $title...'),
          backgroundColor: ATUColors.primaryGold,
        ),
      );
    }
  }
}

// lib/core/utils/validators.dart
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    final nameRegex = RegExp(r"^[a-zA-Z\s\-\'\.]+$");
    if (!nameRegex.hasMatch(value)) {
      return 'Please enter a valid name';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 10) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  static String? validateStudentId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Student ID is required';
    }

    // ATU student ID format: ATU followed by year and numbers
    final studentIdRegex = RegExp(r'^ATU\d{7,}$');
    if (!studentIdRegex.hasMatch(value.toUpperCase())) {
      return 'Please enter a valid ATU student ID (e.g., ATU2020001)';
    }

    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  static String? validateGraduationYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Graduation year is required';
    }

    final year = int.tryParse(value);
    if (year == null) {
      return 'Please enter a valid year';
    }

    final currentYear = DateTime.now().year;
    if (year < 1950 || year > currentYear + 10) {
      return 'Please enter a valid graduation year';
    }

    return null;
  }

  static String? validateSalaryRange(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Salary is optional
    }

    // Basic validation for salary format
    if (!value.contains('₵') && !value.contains('\$')) {
      return 'Please include currency symbol (₵ or \$)';
    }

    return null;
  }
}
*/
