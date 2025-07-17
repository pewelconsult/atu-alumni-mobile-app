// lib/data/models/alumni_model.dart

/// Employment Status enum
enum EmploymentStatus {
  employed,
  unemployed,
  selfEmployed,
  partTime,
  freelance,
  student,
  retired,
  other,
}

/// Employment Type enum
enum EmploymentType {
  fullTime,
  partTime,
  contract,
  internship,
  freelance,
  volunteer,
  other,
}

/// Industry Sector enum
enum IndustrySector {
  technology,
  finance,
  healthcare,
  education,
  manufacturing,
  retail,
  construction,
  agriculture,
  transportation,
  hospitality,
  government,
  nonprofit,
  other,
}

/// Alumni Model
class AlumniModel {
  final String id;
  final String userId;
  final String studentId;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String email;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? gender;

  // Academic Information
  final String program;
  final String faculty;
  final String department;
  final String graduationYear;
  final String admissionYear;
  final double? cgpa;
  final String? degreeClass;
  final String? thesis;
  final List<String> awards;
  final List<String> certifications;

  // Contact Information
  final AlumniAddress? currentAddress;
  final AlumniAddress? permanentAddress;
  final List<AlumniContact> contacts;
  final List<String> socialMediaLinks;

  // Professional Information
  final List<WorkExperience> workExperience;
  final EmploymentStatus currentEmploymentStatus;
  final String? currentJobTitle;
  final String? currentCompany;
  final String? currentIndustry;
  final double? currentSalary;
  final String? linkedInProfile;

  // Education & Skills
  final List<EducationHistory> furtherEducation;
  final List<String> skills;
  final List<String> languages;
  final List<String> interests;

  // Alumni Engagement
  final bool isActive;
  final bool isRecentlyActive;
  final bool isConnected;
  final DateTime? lastLoginAt;
  final List<String> connectedAlumni;
  final List<AlumniEngagement> engagements;

  // Verification & Status
  final bool isVerified;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final AlumniStatus status;
  final String? notes;

  // Metadata
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  AlumniModel({
    required this.id,
    required this.userId,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    required this.program,
    required this.faculty,
    required this.department,
    required this.graduationYear,
    required this.admissionYear,
    this.cgpa,
    this.degreeClass,
    this.thesis,
    this.awards = const [],
    this.certifications = const [],
    this.currentAddress,
    this.permanentAddress,
    this.contacts = const [],
    this.socialMediaLinks = const [],
    this.workExperience = const [],
    this.currentEmploymentStatus = EmploymentStatus.unemployed,
    this.currentJobTitle,
    this.currentCompany,
    this.currentIndustry,
    this.currentSalary,
    this.linkedInProfile,
    this.furtherEducation = const [],
    this.skills = const [],
    this.languages = const [],
    this.interests = const [],
    this.isActive = true,
    this.isRecentlyActive = false,
    this.isConnected = false,
    this.lastLoginAt,
    this.connectedAlumni = const [],
    this.engagements = const [],
    this.isVerified = false,
    this.verifiedAt,
    this.verifiedBy,
    this.status = AlumniStatus.active,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    this.metadata,
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

  /// Get initials
  String get initials {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }

  /// Get current position (job title at company)
  String get currentPosition {
    if (currentJobTitle != null && currentCompany != null) {
      return '$currentJobTitle at $currentCompany';
    } else if (currentJobTitle != null) {
      return currentJobTitle!;
    } else if (currentCompany != null) {
      return 'Employee at $currentCompany';
    }
    return 'Position not specified';
  }

  /// Get current location
  String get currentLocation {
    if (currentAddress != null) {
      return currentAddress!.cityCountry;
    }
    return 'Location not specified';
  }

  /// Get years since graduation
  int get yearsSinceGraduation {
    final currentYear = DateTime.now().year;
    final gradYear = int.tryParse(graduationYear) ?? currentYear;
    return currentYear - gradYear;
  }

  /// Check if alumni is employed
  bool get isEmployed {
    return currentEmploymentStatus == EmploymentStatus.employed ||
        currentEmploymentStatus == EmploymentStatus.selfEmployed ||
        currentEmploymentStatus == EmploymentStatus.partTime;
  }

  /// Get latest work experience
  WorkExperience? get latestWorkExperience {
    if (workExperience.isEmpty) return null;

    final sortedExperience = List<WorkExperience>.from(workExperience);
    sortedExperience.sort((a, b) {
      final aDate = a.endDate ?? DateTime.now();
      final bDate = b.endDate ?? DateTime.now();
      return bDate.compareTo(aDate);
    });

    return sortedExperience.first;
  }

  /// Get total work experience in years
  double get totalWorkExperienceYears {
    double totalYears = 0;

    for (final experience in workExperience) {
      final startDate = experience.startDate;
      final endDate = experience.endDate ?? DateTime.now();
      final duration = endDate.difference(startDate);
      totalYears += duration.inDays / 365.25;
    }

    return totalYears;
  }

  /// Create a copy with updated fields
  AlumniModel copyWith({
    String? id,
    String? userId,
    String? studentId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? program,
    String? faculty,
    String? department,
    String? graduationYear,
    String? admissionYear,
    double? cgpa,
    String? degreeClass,
    String? thesis,
    List<String>? awards,
    List<String>? certifications,
    AlumniAddress? currentAddress,
    AlumniAddress? permanentAddress,
    List<AlumniContact>? contacts,
    List<String>? socialMediaLinks,
    List<WorkExperience>? workExperience,
    EmploymentStatus? currentEmploymentStatus,
    String? currentJobTitle,
    String? currentCompany,
    String? currentIndustry,
    double? currentSalary,
    String? linkedInProfile,
    List<EducationHistory>? furtherEducation,
    List<String>? skills,
    List<String>? languages,
    List<String>? interests,
    bool? isActive,
    bool? isRecentlyActive,
    bool? isConnected,
    DateTime? lastLoginAt,
    List<String>? connectedAlumni,
    List<AlumniEngagement>? engagements,
    bool? isVerified,
    DateTime? verifiedAt,
    String? verifiedBy,
    AlumniStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return AlumniModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      studentId: studentId ?? this.studentId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      program: program ?? this.program,
      faculty: faculty ?? this.faculty,
      department: department ?? this.department,
      graduationYear: graduationYear ?? this.graduationYear,
      admissionYear: admissionYear ?? this.admissionYear,
      cgpa: cgpa ?? this.cgpa,
      degreeClass: degreeClass ?? this.degreeClass,
      thesis: thesis ?? this.thesis,
      awards: awards ?? this.awards,
      certifications: certifications ?? this.certifications,
      currentAddress: currentAddress ?? this.currentAddress,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      contacts: contacts ?? this.contacts,
      socialMediaLinks: socialMediaLinks ?? this.socialMediaLinks,
      workExperience: workExperience ?? this.workExperience,
      currentEmploymentStatus:
          currentEmploymentStatus ?? this.currentEmploymentStatus,
      currentJobTitle: currentJobTitle ?? this.currentJobTitle,
      currentCompany: currentCompany ?? this.currentCompany,
      currentIndustry: currentIndustry ?? this.currentIndustry,
      currentSalary: currentSalary ?? this.currentSalary,
      linkedInProfile: linkedInProfile ?? this.linkedInProfile,
      furtherEducation: furtherEducation ?? this.furtherEducation,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
      interests: interests ?? this.interests,
      isActive: isActive ?? this.isActive,
      isRecentlyActive: isRecentlyActive ?? this.isRecentlyActive,
      isConnected: isConnected ?? this.isConnected,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      connectedAlumni: connectedAlumni ?? this.connectedAlumni,
      engagements: engagements ?? this.engagements,
      isVerified: isVerified ?? this.isVerified,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'program': program,
      'faculty': faculty,
      'department': department,
      'graduationYear': graduationYear,
      'admissionYear': admissionYear,
      'cgpa': cgpa,
      'degreeClass': degreeClass,
      'thesis': thesis,
      'awards': awards,
      'certifications': certifications,
      'currentAddress': currentAddress?.toJson(),
      'permanentAddress': permanentAddress?.toJson(),
      'contacts': contacts.map((c) => c.toJson()).toList(),
      'socialMediaLinks': socialMediaLinks,
      'workExperience': workExperience.map((w) => w.toJson()).toList(),
      'currentEmploymentStatus': currentEmploymentStatus.name,
      'currentJobTitle': currentJobTitle,
      'currentCompany': currentCompany,
      'currentIndustry': currentIndustry,
      'currentSalary': currentSalary,
      'linkedInProfile': linkedInProfile,
      'furtherEducation': furtherEducation.map((e) => e.toJson()).toList(),
      'skills': skills,
      'languages': languages,
      'interests': interests,
      'isActive': isActive,
      'isRecentlyActive': isRecentlyActive,
      'isConnected': isConnected,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'connectedAlumni': connectedAlumni,
      'engagements': engagements.map((e) => e.toJson()).toList(),
      'isVerified': isVerified,
      'verifiedAt': verifiedAt?.toIso8601String(),
      'verifiedBy': verifiedBy,
      'status': status.name,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  /// Create from JSON
  factory AlumniModel.fromJson(Map<String, dynamic> json) {
    return AlumniModel(
      id: json['id'],
      userId: json['userId'],
      studentId: json['studentId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      gender: json['gender'],
      program: json['program'],
      faculty: json['faculty'],
      department: json['department'],
      graduationYear: json['graduationYear'],
      admissionYear: json['admissionYear'],
      cgpa: json['cgpa']?.toDouble(),
      degreeClass: json['degreeClass'],
      thesis: json['thesis'],
      awards: List<String>.from(json['awards'] ?? []),
      certifications: List<String>.from(json['certifications'] ?? []),
      currentAddress: json['currentAddress'] != null
          ? AlumniAddress.fromJson(json['currentAddress'])
          : null,
      permanentAddress: json['permanentAddress'] != null
          ? AlumniAddress.fromJson(json['permanentAddress'])
          : null,
      contacts: (json['contacts'] as List? ?? [])
          .map((c) => AlumniContact.fromJson(c))
          .toList(),
      socialMediaLinks: List<String>.from(json['socialMediaLinks'] ?? []),
      workExperience: (json['workExperience'] as List? ?? [])
          .map((w) => WorkExperience.fromJson(w))
          .toList(),
      currentEmploymentStatus: EmploymentStatus.values.firstWhere(
        (e) => e.name == (json['currentEmploymentStatus'] ?? 'unemployed'),
      ),
      currentJobTitle: json['currentJobTitle'],
      currentCompany: json['currentCompany'],
      currentIndustry: json['currentIndustry'],
      currentSalary: json['currentSalary']?.toDouble(),
      linkedInProfile: json['linkedInProfile'],
      furtherEducation: (json['furtherEducation'] as List? ?? [])
          .map((e) => EducationHistory.fromJson(e))
          .toList(),
      skills: List<String>.from(json['skills'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      interests: List<String>.from(json['interests'] ?? []),
      isActive: json['isActive'] ?? true,
      isRecentlyActive: json['isRecentlyActive'] ?? false,
      isConnected: json['isConnected'] ?? false,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
      connectedAlumni: List<String>.from(json['connectedAlumni'] ?? []),
      engagements: (json['engagements'] as List? ?? [])
          .map((e) => AlumniEngagement.fromJson(e))
          .toList(),
      isVerified: json['isVerified'] ?? false,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'])
          : null,
      verifiedBy: json['verifiedBy'],
      status: AlumniStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'active'),
      ),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
    );
  }
}

/// Alumni Status enum
enum AlumniStatus { active, inactive, suspended, archived }

/// Alumni Address Model
class AlumniAddress {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final bool isPrimary;

  AlumniAddress({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.isPrimary = false,
  });

  /// Get formatted address
  String get formattedAddress {
    final parts = [
      street,
      city,
      state,
      country,
    ].where((part) => part != null && part.isNotEmpty).toList();
    return parts.join(', ');
  }

  /// Get city and country
  String get cityCountry {
    final parts = [
      city,
      country,
    ].where((part) => part != null && part.isNotEmpty).toList();
    return parts.join(', ');
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'isPrimary': isPrimary,
    };
  }

  factory AlumniAddress.fromJson(Map<String, dynamic> json) {
    return AlumniAddress(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
      isPrimary: json['isPrimary'] ?? false,
    );
  }
}

/// Alumni Contact Model
class AlumniContact {
  final String type; // 'email', 'phone', 'whatsapp', etc.
  final String value;
  final bool isPrimary;
  final bool isVerified;

  AlumniContact({
    required this.type,
    required this.value,
    this.isPrimary = false,
    this.isVerified = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
      'isPrimary': isPrimary,
      'isVerified': isVerified,
    };
  }

  factory AlumniContact.fromJson(Map<String, dynamic> json) {
    return AlumniContact(
      type: json['type'],
      value: json['value'],
      isPrimary: json['isPrimary'] ?? false,
      isVerified: json['isVerified'] ?? false,
    );
  }
}

/// Work Experience Model
class WorkExperience {
  final String id;
  final String jobTitle;
  final String company;
  final String? department;
  final String? industry;
  final String? location;
  final EmploymentType employmentType;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String? description;
  final List<String> responsibilities;
  final List<String> achievements;
  final double? salary;
  final String? salaryCurrency;

  WorkExperience({
    required this.id,
    required this.jobTitle,
    required this.company,
    this.department,
    this.industry,
    this.location,
    required this.employmentType,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
    this.description,
    this.responsibilities = const [],
    this.achievements = const [],
    this.salary,
    this.salaryCurrency,
  });

  /// Get duration of work experience
  String get duration {
    final start = startDate;
    final end = endDate ?? DateTime.now();
    final diff = end.difference(start);

    final years = diff.inDays ~/ 365;
    final months = (diff.inDays % 365) ~/ 30;

    if (years > 0 && months > 0) {
      return '$years year${years > 1 ? 's' : ''}, $months month${months > 1 ? 's' : ''}';
    } else if (years > 0) {
      return '$years year${years > 1 ? 's' : ''}';
    } else if (months > 0) {
      return '$months month${months > 1 ? 's' : ''}';
    } else {
      return 'Less than a month';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobTitle': jobTitle,
      'company': company,
      'department': department,
      'industry': industry,
      'location': location,
      'employmentType': employmentType.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCurrent': isCurrent,
      'description': description,
      'responsibilities': responsibilities,
      'achievements': achievements,
      'salary': salary,
      'salaryCurrency': salaryCurrency,
    };
  }

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      id: json['id'],
      jobTitle: json['jobTitle'],
      company: json['company'],
      department: json['department'],
      industry: json['industry'],
      location: json['location'],
      employmentType: EmploymentType.values.firstWhere(
        (e) => e.name == (json['employmentType'] ?? 'fullTime'),
      ),
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isCurrent: json['isCurrent'] ?? false,
      description: json['description'],
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
      achievements: List<String>.from(json['achievements'] ?? []),
      salary: json['salary']?.toDouble(),
      salaryCurrency: json['salaryCurrency'],
    );
  }
}

/// Education History Model
class EducationHistory {
  final String id;
  final String institution;
  final String degree;
  final String fieldOfStudy;
  final String startYear;
  final String endYear;
  final double? gpa;
  final String? grade;
  final bool isCompleted;
  final String? thesis;
  final List<String> achievements;

  EducationHistory({
    required this.id,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    required this.startYear,
    required this.endYear,
    this.gpa,
    this.grade,
    this.isCompleted = true,
    this.thesis,
    this.achievements = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institution': institution,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startYear': startYear,
      'endYear': endYear,
      'gpa': gpa,
      'grade': grade,
      'isCompleted': isCompleted,
      'thesis': thesis,
      'achievements': achievements,
    };
  }

  factory EducationHistory.fromJson(Map<String, dynamic> json) {
    return EducationHistory(
      id: json['id'],
      institution: json['institution'],
      degree: json['degree'],
      fieldOfStudy: json['fieldOfStudy'],
      startYear: json['startYear'],
      endYear: json['endYear'],
      gpa: json['gpa']?.toDouble(),
      grade: json['grade'],
      isCompleted: json['isCompleted'] ?? true,
      thesis: json['thesis'],
      achievements: List<String>.from(json['achievements'] ?? []),
    );
  }
}

/// Alumni Engagement Model
class AlumniEngagement {
  final String id;
  final String type; // 'event', 'survey', 'job_post', 'mentorship', etc.
  final String title;
  final String? description;
  final DateTime date;
  final String? status;
  final Map<String, dynamic>? metadata;

  AlumniEngagement({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    required this.date,
    this.status,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'status': status,
      'metadata': metadata,
    };
  }

  factory AlumniEngagement.fromJson(Map<String, dynamic> json) {
    return AlumniEngagement(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
    );
  }
}
