// lib/core/utils/helpers.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

class Helpers {
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy • h:mm a').format(dateTime);
  }

  static String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  static String formatNumber(int number) {
    return NumberFormat('#,###').format(number);
  }

  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(1)}%';
  }

  static String formatCurrency(double amount, {String currency = '₵'}) {
    return '$currency${NumberFormat('#,##0.00').format(amount)}';
  }

  static String getInitials(String firstName, String lastName) {
    return '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
        .toUpperCase();
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'completed':
      case 'verified':
      case 'approved':
        return ATUColors.success;
      case 'pending':
      case 'draft':
      case 'review':
        return ATUColors.warning;
      case 'inactive':
      case 'rejected':
      case 'failed':
      case 'expired':
        return ATUColors.error;
      case 'processing':
      case 'in progress':
        return ATUColors.info;
      default:
        return ATUColors.grey500;
    }
  }

  static IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'completed':
      case 'verified':
      case 'approved':
        return Icons.check_circle_rounded;
      case 'pending':
      case 'draft':
      case 'review':
        return Icons.schedule_rounded;
      case 'inactive':
      case 'rejected':
      case 'failed':
      case 'expired':
        return Icons.cancel_rounded;
      case 'processing':
      case 'in progress':
        return Icons.refresh_rounded;
      default:
        return Icons.help_rounded;
    }
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ATUColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ATUColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void showInfoSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ATUColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
    String cancelText = 'Cancel',
    Color? confirmColor,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(cancelText),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor ?? ATUColors.primaryBlue,
              foregroundColor: ATUColors.white,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  static List<T> paginate<T>(List<T> items, int page, int itemsPerPage) {
    final startIndex = page * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, items.length);

    if (startIndex >= items.length) return [];

    return items.sublist(startIndex, endIndex);
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isStrongPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static Map<String, dynamic> sanitizeUserInput(Map<String, dynamic> input) {
    final sanitized = <String, dynamic>{};

    input.forEach((key, value) {
      if (value is String) {
        // Remove potentially harmful characters
        sanitized[key] = value
            .replaceAll(
              RegExp(r'<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>'),
              '',
            )
            .replaceAll(RegExp(r'[<>]'), '')
            .trim();
      } else {
        sanitized[key] = value;
      }
    });

    return sanitized;
  }
}

// lib/core/constants/app_constants.dart
class AppConstants {
  // App Information
  static const String appName = 'ATU Alumni Connect';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Connect alumni and track career outcomes';

  // University Information
  static const String universityName = 'Accra Technical University';
  static const String universityAbbreviation = 'ATU';
  static const String universityWebsite = 'https://atu.edu.gh';
  static const String universityEmail = 'info@atu.edu.gh';
  static const String universityPhone = '+233 30 220 5311';

  // Contact Information
  static const String supportEmail = 'support@atuconnect.edu.gh';
  static const String feedbackEmail = 'feedback@atuconnect.edu.gh';
  static const String directorEmail = 'pnyanor@atu.edu.gh';
  static const String directorName = 'Dr. Peter Nyanor';
  static const String directorTitle =
      'Director of Research, Innovation, Publication and Technology Transfer (DRIPTT)';

  // API Configuration
  static const String baseUrl = 'https://api.atuconnect.edu.gh';
  static const String apiVersion = 'v1';
  static const int connectionTimeout = 30; // seconds
  static const int receiveTimeout = 30; // seconds

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedDocumentFormats = ['pdf', 'doc', 'docx'];

  // Validation
  static const int minPasswordLength = 6;
  static const int maxBioLength = 500;
  static const int maxSkillsCount = 10;

  // Survey Configuration
  static const int maxSurveyQuestions = 50;
  static const int maxQuestionOptions = 20;
  static const int surveyReminderIntervalDays = 7;

  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 24);
  static const Duration shortCacheDuration = Duration(hours: 1);

  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // Routes
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String profileRoute = '/profile';
  static const String surveysRoute = '/surveys';
  static const String eventsRoute = '/events';
  static const String jobsRoute = '/jobs';
  static const String adminRoute = '/admin';

  // Local Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String preferencesKey = 'user_preferences';
  static const String onboardingCompletedKey = 'onboarding_completed';

  // Export Formats
  static const Map<String, String> exportMimeTypes = {
    'csv': 'text/csv',
    'excel':
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'pdf': 'application/pdf',
    'json': 'application/json',
  };

  // Social Media
  static const String linkedinUrl =
      'https://linkedin.com/school/accra-technical-university';
  static const String facebookUrl =
      'https://facebook.com/AccraTechnicalUniversity';
  static const String twitterUrl = 'https://twitter.com/ATU_Ghana';

  // Help & Support
  static const String helpCenterUrl = 'https://help.atuconnect.edu.gh';
  static const String privacyPolicyUrl = 'https://atuconnect.edu.gh/privacy';
  static const String termsOfServiceUrl = 'https://atuconnect.edu.gh/terms';

  // Feature Flags (for development)
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableDebugMode = false;

  // Graduation Years (for dropdowns)
  static List<int> get availableGraduationYears {
    final currentYear = DateTime.now().year;
    return List.generate(
      currentYear - 1950 + 5,
      (index) => currentYear + 5 - index,
    );
  }

  // ATU Programs
  static const List<String> atuPrograms = [
    'Computer Science',
    'Information Technology',
    'Software Engineering',
    'Civil Engineering',
    'Mechanical Engineering',
    'Electrical Engineering',
    'Architecture',
    'Business Administration',
    'Accounting',
    'Marketing',
    'Hospitality Management',
    'Tourism Management',
    'Applied Sciences',
    'Fashion Design',
    'Graphic Design',
  ];

  // Salary Ranges
  static const List<String> salaryRanges = [
    'Below ₵2,000',
    '₵2,000 - ₵4,999',
    '₵5,000 - ₵9,999',
    '₵10,000 - ₵19,999',
    '₵20,000 - ₵29,999',
    '₵30,000 - ₵49,999',
    '₵50,000 and above',
    'Prefer not to say',
  ];

  // Industries
  static const List<String> industries = [
    'Technology',
    'Finance & Banking',
    'Healthcare',
    'Education',
    'Construction',
    'Manufacturing',
    'Retail',
    'Hospitality & Tourism',
    'Government',
    'Non-Profit',
    'Consulting',
    'Media & Communications',
    'Agriculture',
    'Mining',
    'Transportation',
    'Other',
  ];
}
