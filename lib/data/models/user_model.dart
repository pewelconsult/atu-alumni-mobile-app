// lib/data/models/user_model.dart

/// User Role enum
enum UserRole { alumni, admin, staff }

/// User Status enum
enum UserStatus { active, inactive, suspended, pendingVerification }

/// Gender enum
enum Gender { male, female, other, preferNotToSay }

/// Main User Model
class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? middleName;
  final UserRole role;
  final UserStatus status;
  final bool isVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLoginAt;
  final DateTime? emailVerifiedAt;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final String? profileImageUrl;
  final String? bio;
  final UserPreferences preferences;
  final Map<String, dynamic>? metadata;

  // Alumni-specific fields (when role is alumni)
  final String? studentId;
  final String? graduationYear;
  final String? program;
  final String? faculty;
  final String? department;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.role,
    this.status = UserStatus.active,
    this.isVerified = false,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
    this.emailVerifiedAt,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.profileImageUrl,
    this.bio,
    required this.preferences,
    this.metadata,
    this.studentId,
    this.graduationYear,
    this.program,
    this.faculty,
    this.department,
  });

  /// Get full name
  String get fullName {
    final parts = [
      firstName,
      middleName,
      lastName,
    ].where((part) => part != null && part.isNotEmpty).toList();
    return parts.join(' ');
  }

  /// Get initials (first letter of first and last name)
  String get initials {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }

  /// Get display name (for UI purposes)
  String get displayName {
    return fullName.isNotEmpty ? fullName : email.split('@')[0];
  }

  /// Check if user is an alumni
  bool get isAlumni => role == UserRole.alumni;

  /// Check if user is an admin
  bool get isAdmin => role == UserRole.admin;

  /// Check if user is staff
  bool get isStaff => role == UserRole.staff;

  /// Check if user needs verification
  bool get needsVerification =>
      !isVerified || status == UserStatus.pendingVerification;

  /// Get formatted creation date
  String get createdDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  /// Create a copy with updated fields
  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? middleName,
    UserRole? role,
    UserStatus? status,
    bool? isVerified,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    DateTime? emailVerifiedAt,
    String? phoneNumber,
    DateTime? dateOfBirth,
    Gender? gender,
    String? profileImageUrl,
    String? bio,
    UserPreferences? preferences,
    Map<String, dynamic>? metadata,
    String? studentId,
    String? graduationYear,
    String? program,
    String? faculty,
    String? department,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      role: role ?? this.role,
      status: status ?? this.status,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      preferences: preferences ?? this.preferences,
      metadata: metadata ?? this.metadata,
      studentId: studentId ?? this.studentId,
      graduationYear: graduationYear ?? this.graduationYear,
      program: program ?? this.program,
      faculty: faculty ?? this.faculty,
      department: department ?? this.department,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'role': role.name,
      'status': status.name,
      'isVerified': isVerified,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'emailVerifiedAt': emailVerifiedAt?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender?.name,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'preferences': preferences.toJson(),
      'metadata': metadata,
      'studentId': studentId,
      'graduationYear': graduationYear,
      'program': program,
      'faculty': faculty,
      'department': department,
    };
  }

  /// Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      status: UserStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'active'),
      ),
      isVerified: json['isVerified'] ?? false,
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
      emailVerifiedAt: json['emailVerifiedAt'] != null
          ? DateTime.parse(json['emailVerifiedAt'])
          : null,
      phoneNumber: json['phoneNumber'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      gender: json['gender'] != null
          ? Gender.values.firstWhere((e) => e.name == json['gender'])
          : null,
      profileImageUrl: json['profileImageUrl'],
      bio: json['bio'],
      preferences: UserPreferences.fromJson(json['preferences'] ?? {}),
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
      studentId: json['studentId'],
      graduationYear: json['graduationYear'],
      program: json['program'],
      faculty: json['faculty'],
      department: json['department'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, fullName: $fullName, role: $role)';
  }
}

/// User Preferences Model
class UserPreferences {
  final bool emailNotifications;
  final bool pushNotifications;
  final bool smsNotifications;
  final bool marketingEmails;
  final bool eventNotifications;
  final bool jobAlerts;
  final bool profileVisibility;
  final bool showOnlineStatus;
  final String theme; // 'light', 'dark', 'system'
  final String language; // 'en', 'fr', etc.
  final String timezone;
  final Map<String, dynamic> customSettings;

  UserPreferences({
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.smsNotifications = false,
    this.marketingEmails = false,
    this.eventNotifications = true,
    this.jobAlerts = true,
    this.profileVisibility = true,
    this.showOnlineStatus = true,
    this.theme = 'system',
    this.language = 'en',
    this.timezone = 'UTC',
    this.customSettings = const {},
  });

  /// Create a copy with updated fields
  UserPreferences copyWith({
    bool? emailNotifications,
    bool? pushNotifications,
    bool? smsNotifications,
    bool? marketingEmails,
    bool? eventNotifications,
    bool? jobAlerts,
    bool? profileVisibility,
    bool? showOnlineStatus,
    String? theme,
    String? language,
    String? timezone,
    Map<String, dynamic>? customSettings,
  }) {
    return UserPreferences(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
      marketingEmails: marketingEmails ?? this.marketingEmails,
      eventNotifications: eventNotifications ?? this.eventNotifications,
      jobAlerts: jobAlerts ?? this.jobAlerts,
      profileVisibility: profileVisibility ?? this.profileVisibility,
      showOnlineStatus: showOnlineStatus ?? this.showOnlineStatus,
      theme: theme ?? this.theme,
      language: language ?? this.language,
      timezone: timezone ?? this.timezone,
      customSettings: customSettings ?? this.customSettings,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'smsNotifications': smsNotifications,
      'marketingEmails': marketingEmails,
      'eventNotifications': eventNotifications,
      'jobAlerts': jobAlerts,
      'profileVisibility': profileVisibility,
      'showOnlineStatus': showOnlineStatus,
      'theme': theme,
      'language': language,
      'timezone': timezone,
      'customSettings': customSettings,
    };
  }

  /// Create from JSON
  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      emailNotifications: json['emailNotifications'] ?? true,
      pushNotifications: json['pushNotifications'] ?? true,
      smsNotifications: json['smsNotifications'] ?? false,
      marketingEmails: json['marketingEmails'] ?? false,
      eventNotifications: json['eventNotifications'] ?? true,
      jobAlerts: json['jobAlerts'] ?? true,
      profileVisibility: json['profileVisibility'] ?? true,
      showOnlineStatus: json['showOnlineStatus'] ?? true,
      theme: json['theme'] ?? 'system',
      language: json['language'] ?? 'en',
      timezone: json['timezone'] ?? 'UTC',
      customSettings: json['customSettings'] != null
          ? Map<String, dynamic>.from(json['customSettings'])
          : {},
    );
  }
}

/// User Session Model
class UserSession {
  final String id;
  final String userId;
  final String deviceId;
  final String deviceName;
  final String ipAddress;
  final String userAgent;
  final DateTime createdAt;
  final DateTime lastAccessedAt;
  final bool isActive;
  final String? location;

  UserSession({
    required this.id,
    required this.userId,
    required this.deviceId,
    required this.deviceName,
    required this.ipAddress,
    required this.userAgent,
    required this.createdAt,
    required this.lastAccessedAt,
    this.isActive = true,
    this.location,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'deviceId': deviceId,
      'deviceName': deviceName,
      'ipAddress': ipAddress,
      'userAgent': userAgent,
      'createdAt': createdAt.toIso8601String(),
      'lastAccessedAt': lastAccessedAt.toIso8601String(),
      'isActive': isActive,
      'location': location,
    };
  }

  /// Create from JSON
  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      id: json['id'],
      userId: json['userId'],
      deviceId: json['deviceId'],
      deviceName: json['deviceName'],
      ipAddress: json['ipAddress'],
      userAgent: json['userAgent'],
      createdAt: DateTime.parse(json['createdAt']),
      lastAccessedAt: DateTime.parse(json['lastAccessedAt']),
      isActive: json['isActive'] ?? true,
      location: json['location'],
    );
  }
}

/// User Activity Model
class UserActivity {
  final String id;
  final String userId;
  final String action;
  final String? description;
  final Map<String, dynamic>? metadata;
  final DateTime timestamp;
  final String? ipAddress;
  final String? userAgent;

  UserActivity({
    required this.id,
    required this.userId,
    required this.action,
    this.description,
    this.metadata,
    required this.timestamp,
    this.ipAddress,
    this.userAgent,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'action': action,
      'description': description,
      'metadata': metadata,
      'timestamp': timestamp.toIso8601String(),
      'ipAddress': ipAddress,
      'userAgent': userAgent,
    };
  }

  /// Create from JSON
  factory UserActivity.fromJson(Map<String, dynamic> json) {
    return UserActivity(
      id: json['id'],
      userId: json['userId'],
      action: json['action'],
      description: json['description'],
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
      timestamp: DateTime.parse(json['timestamp']),
      ipAddress: json['ipAddress'],
      userAgent: json['userAgent'],
    );
  }
}

/// User Permission Model
class UserPermission {
  final String id;
  final String name;
  final String description;
  final String category;
  final bool isActive;

  UserPermission({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.isActive = true,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'isActive': isActive,
    };
  }

  /// Create from JSON
  factory UserPermission.fromJson(Map<String, dynamic> json) {
    return UserPermission(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      isActive: json['isActive'] ?? true,
    );
  }
}

/// User Role Permissions Model
class UserRolePermissions {
  final UserRole role;
  final List<UserPermission> permissions;

  UserRolePermissions({required this.role, required this.permissions});

  /// Check if role has specific permission
  bool hasPermission(String permissionName) {
    return permissions.any((p) => p.name == permissionName && p.isActive);
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'role': role.name,
      'permissions': permissions.map((p) => p.toJson()).toList(),
    };
  }

  /// Create from JSON
  factory UserRolePermissions.fromJson(Map<String, dynamic> json) {
    return UserRolePermissions(
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      permissions: (json['permissions'] as List)
          .map((p) => UserPermission.fromJson(p))
          .toList(),
    );
  }
}

/// User Statistics Model
class UserStatistics {
  final String userId;
  final int loginCount;
  final DateTime? lastLoginAt;
  final int surveyResponsesCount;
  final int eventsAttendedCount;
  final int jobApplicationsCount;
  final int connectionsCount;
  final int profileViewsCount;
  final Map<String, int> activityCounts;
  final DateTime lastUpdated;

  UserStatistics({
    required this.userId,
    this.loginCount = 0,
    this.lastLoginAt,
    this.surveyResponsesCount = 0,
    this.eventsAttendedCount = 0,
    this.jobApplicationsCount = 0,
    this.connectionsCount = 0,
    this.profileViewsCount = 0,
    this.activityCounts = const {},
    required this.lastUpdated,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'loginCount': loginCount,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'surveyResponsesCount': surveyResponsesCount,
      'eventsAttendedCount': eventsAttendedCount,
      'jobApplicationsCount': jobApplicationsCount,
      'connectionsCount': connectionsCount,
      'profileViewsCount': profileViewsCount,
      'activityCounts': activityCounts,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  /// Create from JSON
  factory UserStatistics.fromJson(Map<String, dynamic> json) {
    return UserStatistics(
      userId: json['userId'],
      loginCount: json['loginCount'] ?? 0,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
      surveyResponsesCount: json['surveyResponsesCount'] ?? 0,
      eventsAttendedCount: json['eventsAttendedCount'] ?? 0,
      jobApplicationsCount: json['jobApplicationsCount'] ?? 0,
      connectionsCount: json['connectionsCount'] ?? 0,
      profileViewsCount: json['profileViewsCount'] ?? 0,
      activityCounts: json['activityCounts'] != null
          ? Map<String, int>.from(json['activityCounts'])
          : {},
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}
