// lib/presentation/models/user_profile_model.dart

class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String graduationYear;
  final String program;
  final String currentPosition;
  final String currentCompany;
  final String location;
  final String bio;
  final List<String> skills;
  final String linkedIn;
  final String github;
  final String website;
  final int profileCompletion;
  final int connectionsCount;
  final int eventsAttended;
  final int surveysCompleted;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.graduationYear,
    required this.program,
    required this.currentPosition,
    required this.currentCompany,
    required this.location,
    required this.bio,
    required this.skills,
    required this.linkedIn,
    required this.github,
    required this.website,
    required this.profileCompletion,
    required this.connectionsCount,
    required this.eventsAttended,
    required this.surveysCompleted,
  });
}
