// lib/data/models/user_model.dart
class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;
  final UserRole role;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final UserPreferences preferences;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
    required this.role,
    this.isVerified = false,
    required this.createdAt,
    this.lastLoginAt,
    required this.preferences,
  });

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImageUrl: json['profileImageUrl'],
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == json['role'],
        orElse: () => UserRole.alumni,
      ),
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
      preferences: UserPreferences.fromJson(json['preferences'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profileImageUrl': profileImageUrl,
      'role': role.toString().split('.').last,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'preferences': preferences.toJson(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    UserRole? role,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    UserPreferences? preferences,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      preferences: preferences ?? this.preferences,
    );
  }
}

enum UserRole { alumni, admin, staff }

class UserPreferences {
  final bool emailNotifications;
  final bool pushNotifications;
  final bool surveyReminders;
  final bool eventNotifications;
  final bool jobAlerts;
  final String language;
  final bool darkMode;

  UserPreferences({
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.surveyReminders = true,
    this.eventNotifications = true,
    this.jobAlerts = true,
    this.language = 'en',
    this.darkMode = false,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      emailNotifications: json['emailNotifications'] ?? true,
      pushNotifications: json['pushNotifications'] ?? true,
      surveyReminders: json['surveyReminders'] ?? true,
      eventNotifications: json['eventNotifications'] ?? true,
      jobAlerts: json['jobAlerts'] ?? true,
      language: json['language'] ?? 'en',
      darkMode: json['darkMode'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'surveyReminders': surveyReminders,
      'eventNotifications': eventNotifications,
      'jobAlerts': jobAlerts,
      'language': language,
      'darkMode': darkMode,
    };
  }

  UserPreferences copyWith({
    bool? emailNotifications,
    bool? pushNotifications,
    bool? surveyReminders,
    bool? eventNotifications,
    bool? jobAlerts,
    String? language,
    bool? darkMode,
  }) {
    return UserPreferences(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      surveyReminders: surveyReminders ?? this.surveyReminders,
      eventNotifications: eventNotifications ?? this.eventNotifications,
      jobAlerts: jobAlerts ?? this.jobAlerts,
      language: language ?? this.language,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
