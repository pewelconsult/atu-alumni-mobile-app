// lib/app/routes/route_names.dart
class RouteNames {
  // Authentication
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main App
  static const String dashboard = '/dashboard';
  static const String directory = '/directory';
  static const String events = '/events';
  static const String jobs = '/jobs';
  static const String profile = '/profile';
  static const String surveys = '/surveys';

  // Admin
  static const String admin = '/admin';

  // Detailed Views
  static const String userProfile = '/profile/:userId';
  static const String eventDetails = '/events/:eventId';
  static const String jobDetails = '/jobs/:jobId';
  static const String surveyForm = '/surveys/form/:surveyId';
}
