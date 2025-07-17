// lib/data/models/survey_model.dart

/// Survey Types enum
enum SurveyType {
  employmentStatus,
  careerProgression,
  skillsAssessment,
  programEvaluation,
  generalFeedback,
  custom,
}

/// Question Types enum
enum QuestionType {
  text,
  multipleChoice,
  dropdown,
  rating,
  scale,
  checkbox,
  date,
  email,
  number,
  phone,
  file,
}

/// Survey Status enum
enum SurveyStatus { draft, active, completed, archived }

/// Main Survey Model
class SurveyModel {
  final String id;
  final String title;
  final String description;
  final SurveyType type;
  final SurveyStatus status;
  final List<SurveyQuestion> questions;
  final SurveyTargeting targeting;
  final SurveySettings settings;
  final DateTime createdAt;
  final DateTime? publishedAt;
  final DateTime? closedAt;
  final String createdBy;
  final int targetCount;
  final int responseCount;
  final double responseRate;

  SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.questions,
    required this.targeting,
    required this.settings,
    required this.createdAt,
    this.publishedAt,
    this.closedAt,
    required this.createdBy,
    required this.targetCount,
    required this.responseCount,
    required this.responseRate,
  });

  /// Create a copy of the survey with updated fields
  SurveyModel copyWith({
    String? id,
    String? title,
    String? description,
    SurveyType? type,
    SurveyStatus? status,
    List<SurveyQuestion>? questions,
    SurveyTargeting? targeting,
    SurveySettings? settings,
    DateTime? createdAt,
    DateTime? publishedAt,
    DateTime? closedAt,
    String? createdBy,
    int? targetCount,
    int? responseCount,
    double? responseRate,
  }) {
    return SurveyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      questions: questions ?? this.questions,
      targeting: targeting ?? this.targeting,
      settings: settings ?? this.settings,
      createdAt: createdAt ?? this.createdAt,
      publishedAt: publishedAt ?? this.publishedAt,
      closedAt: closedAt ?? this.closedAt,
      createdBy: createdBy ?? this.createdBy,
      targetCount: targetCount ?? this.targetCount,
      responseCount: responseCount ?? this.responseCount,
      responseRate: responseRate ?? this.responseRate,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'status': status.name,
      'questions': questions.map((q) => q.toJson()).toList(),
      'targeting': targeting.toJson(),
      'settings': settings.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'publishedAt': publishedAt?.toIso8601String(),
      'closedAt': closedAt?.toIso8601String(),
      'createdBy': createdBy,
      'targetCount': targetCount,
      'responseCount': responseCount,
      'responseRate': responseRate,
    };
  }

  /// Create from JSON
  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: SurveyType.values.firstWhere((e) => e.name == json['type']),
      status: SurveyStatus.values.firstWhere((e) => e.name == json['status']),
      questions: (json['questions'] as List)
          .map((q) => SurveyQuestion.fromJson(q))
          .toList(),
      targeting: SurveyTargeting.fromJson(json['targeting']),
      settings: SurveySettings.fromJson(json['settings']),
      createdAt: DateTime.parse(json['createdAt']),
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      closedAt: json['closedAt'] != null
          ? DateTime.parse(json['closedAt'])
          : null,
      createdBy: json['createdBy'],
      targetCount: json['targetCount'],
      responseCount: json['responseCount'],
      responseRate: json['responseRate']?.toDouble() ?? 0.0,
    );
  }

  /// Get formatted creation date
  String get createdDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  /// Check if survey is editable
  bool get isEditable {
    return status == SurveyStatus.draft;
  }

  /// Check if survey is active
  bool get isActive {
    return status == SurveyStatus.active;
  }

  /// Check if survey is completed
  bool get isCompleted {
    return status == SurveyStatus.completed;
  }
}

/// Survey Question Model
class SurveyQuestion {
  final String id;
  final String question;
  final String description;
  final QuestionType type;
  final List<String> options;
  final bool isRequired;
  final int? minRating;
  final int? maxRating;
  final String? placeholder;
  final bool allowMultipleSelections;
  final int? maxFileSize; // in MB
  final List<String>? allowedFileTypes;

  SurveyQuestion({
    required this.id,
    required this.question,
    this.description = '',
    required this.type,
    this.options = const [],
    this.isRequired = false,
    this.minRating,
    this.maxRating,
    this.placeholder,
    this.allowMultipleSelections = false,
    this.maxFileSize,
    this.allowedFileTypes,
  });

  /// Create a copy with updated fields
  SurveyQuestion copyWith({
    String? id,
    String? question,
    String? description,
    QuestionType? type,
    List<String>? options,
    bool? isRequired,
    int? minRating,
    int? maxRating,
    String? placeholder,
    bool? allowMultipleSelections,
    int? maxFileSize,
    List<String>? allowedFileTypes,
  }) {
    return SurveyQuestion(
      id: id ?? this.id,
      question: question ?? this.question,
      description: description ?? this.description,
      type: type ?? this.type,
      options: options ?? this.options,
      isRequired: isRequired ?? this.isRequired,
      minRating: minRating ?? this.minRating,
      maxRating: maxRating ?? this.maxRating,
      placeholder: placeholder ?? this.placeholder,
      allowMultipleSelections:
          allowMultipleSelections ?? this.allowMultipleSelections,
      maxFileSize: maxFileSize ?? this.maxFileSize,
      allowedFileTypes: allowedFileTypes ?? this.allowedFileTypes,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'description': description,
      'type': type.name,
      'options': options,
      'isRequired': isRequired,
      'minRating': minRating,
      'maxRating': maxRating,
      'placeholder': placeholder,
      'allowMultipleSelections': allowMultipleSelections,
      'maxFileSize': maxFileSize,
      'allowedFileTypes': allowedFileTypes,
    };
  }

  /// Create from JSON
  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    return SurveyQuestion(
      id: json['id'],
      question: json['question'],
      description: json['description'] ?? '',
      type: QuestionType.values.firstWhere((e) => e.name == json['type']),
      options: List<String>.from(json['options'] ?? []),
      isRequired: json['isRequired'] ?? false,
      minRating: json['minRating'],
      maxRating: json['maxRating'],
      placeholder: json['placeholder'],
      allowMultipleSelections: json['allowMultipleSelections'] ?? false,
      maxFileSize: json['maxFileSize'],
      allowedFileTypes: json['allowedFileTypes'] != null
          ? List<String>.from(json['allowedFileTypes'])
          : null,
    );
  }
}

/// Survey Targeting Model
class SurveyTargeting {
  final bool isOpenToAll;
  final List<int> graduationYears;
  final List<String> programs;
  final List<String> faculties;
  final List<String> locations;
  final List<String> industries;
  final String? customCriteria;

  SurveyTargeting({
    this.isOpenToAll = true,
    this.graduationYears = const [],
    this.programs = const [],
    this.faculties = const [],
    this.locations = const [],
    this.industries = const [],
    this.customCriteria,
  });

  /// Create a copy with updated fields
  SurveyTargeting copyWith({
    bool? isOpenToAll,
    List<int>? graduationYears,
    List<String>? programs,
    List<String>? faculties,
    List<String>? locations,
    List<String>? industries,
    String? customCriteria,
  }) {
    return SurveyTargeting(
      isOpenToAll: isOpenToAll ?? this.isOpenToAll,
      graduationYears: graduationYears ?? this.graduationYears,
      programs: programs ?? this.programs,
      faculties: faculties ?? this.faculties,
      locations: locations ?? this.locations,
      industries: industries ?? this.industries,
      customCriteria: customCriteria ?? this.customCriteria,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'isOpenToAll': isOpenToAll,
      'graduationYears': graduationYears,
      'programs': programs,
      'faculties': faculties,
      'locations': locations,
      'industries': industries,
      'customCriteria': customCriteria,
    };
  }

  /// Create from JSON
  factory SurveyTargeting.fromJson(Map<String, dynamic> json) {
    return SurveyTargeting(
      isOpenToAll: json['isOpenToAll'] ?? true,
      graduationYears: List<int>.from(json['graduationYears'] ?? []),
      programs: List<String>.from(json['programs'] ?? []),
      faculties: List<String>.from(json['faculties'] ?? []),
      locations: List<String>.from(json['locations'] ?? []),
      industries: List<String>.from(json['industries'] ?? []),
      customCriteria: json['customCriteria'],
    );
  }

  /// Check if targeting has any filters
  bool get hasFilters {
    return !isOpenToAll &&
        (graduationYears.isNotEmpty ||
            programs.isNotEmpty ||
            faculties.isNotEmpty ||
            locations.isNotEmpty ||
            industries.isNotEmpty);
  }
}

/// Survey Settings Model
class SurveySettings {
  final bool requireLogin;
  final bool allowMultipleResponses;
  final bool showProgressBar;
  final bool allowBackNavigation;
  final bool randomizeQuestions;
  final bool showQuestionNumbers;
  final bool allowSaveAndResume;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? responseLimit;
  final String? thankYouMessage;
  final String? redirectUrl;
  final bool collectEmailAddresses;
  final bool sendConfirmationEmail;

  SurveySettings({
    this.requireLogin = true,
    this.allowMultipleResponses = false,
    this.showProgressBar = true,
    this.allowBackNavigation = true,
    this.randomizeQuestions = false,
    this.showQuestionNumbers = true,
    this.allowSaveAndResume = false,
    this.startDate,
    this.endDate,
    this.responseLimit,
    this.thankYouMessage,
    this.redirectUrl,
    this.collectEmailAddresses = false,
    this.sendConfirmationEmail = false,
  });

  /// Create a copy with updated fields
  SurveySettings copyWith({
    bool? requireLogin,
    bool? allowMultipleResponses,
    bool? showProgressBar,
    bool? allowBackNavigation,
    bool? randomizeQuestions,
    bool? showQuestionNumbers,
    bool? allowSaveAndResume,
    DateTime? startDate,
    DateTime? endDate,
    int? responseLimit,
    String? thankYouMessage,
    String? redirectUrl,
    bool? collectEmailAddresses,
    bool? sendConfirmationEmail,
  }) {
    return SurveySettings(
      requireLogin: requireLogin ?? this.requireLogin,
      allowMultipleResponses:
          allowMultipleResponses ?? this.allowMultipleResponses,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      allowBackNavigation: allowBackNavigation ?? this.allowBackNavigation,
      randomizeQuestions: randomizeQuestions ?? this.randomizeQuestions,
      showQuestionNumbers: showQuestionNumbers ?? this.showQuestionNumbers,
      allowSaveAndResume: allowSaveAndResume ?? this.allowSaveAndResume,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      responseLimit: responseLimit ?? this.responseLimit,
      thankYouMessage: thankYouMessage ?? this.thankYouMessage,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      collectEmailAddresses:
          collectEmailAddresses ?? this.collectEmailAddresses,
      sendConfirmationEmail:
          sendConfirmationEmail ?? this.sendConfirmationEmail,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'requireLogin': requireLogin,
      'allowMultipleResponses': allowMultipleResponses,
      'showProgressBar': showProgressBar,
      'allowBackNavigation': allowBackNavigation,
      'randomizeQuestions': randomizeQuestions,
      'showQuestionNumbers': showQuestionNumbers,
      'allowSaveAndResume': allowSaveAndResume,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'responseLimit': responseLimit,
      'thankYouMessage': thankYouMessage,
      'redirectUrl': redirectUrl,
      'collectEmailAddresses': collectEmailAddresses,
      'sendConfirmationEmail': sendConfirmationEmail,
    };
  }

  /// Create from JSON
  factory SurveySettings.fromJson(Map<String, dynamic> json) {
    return SurveySettings(
      requireLogin: json['requireLogin'] ?? true,
      allowMultipleResponses: json['allowMultipleResponses'] ?? false,
      showProgressBar: json['showProgressBar'] ?? true,
      allowBackNavigation: json['allowBackNavigation'] ?? true,
      randomizeQuestions: json['randomizeQuestions'] ?? false,
      showQuestionNumbers: json['showQuestionNumbers'] ?? true,
      allowSaveAndResume: json['allowSaveAndResume'] ?? false,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      responseLimit: json['responseLimit'],
      thankYouMessage: json['thankYouMessage'],
      redirectUrl: json['redirectUrl'],
      collectEmailAddresses: json['collectEmailAddresses'] ?? false,
      sendConfirmationEmail: json['sendConfirmationEmail'] ?? false,
    );
  }
}

/// Survey Response Model
class SurveyResponse {
  final String id;
  final String surveyId;
  final String respondentId;
  final Map<String, dynamic> answers;
  final DateTime submittedAt;
  final DateTime? startedAt;
  final bool isComplete;
  final String? ipAddress;
  final String? userAgent;

  SurveyResponse({
    required this.id,
    required this.surveyId,
    required this.respondentId,
    required this.answers,
    required this.submittedAt,
    this.startedAt,
    required this.isComplete,
    this.ipAddress,
    this.userAgent,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surveyId': surveyId,
      'respondentId': respondentId,
      'answers': answers,
      'submittedAt': submittedAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'isComplete': isComplete,
      'ipAddress': ipAddress,
      'userAgent': userAgent,
    };
  }

  /// Create from JSON
  factory SurveyResponse.fromJson(Map<String, dynamic> json) {
    return SurveyResponse(
      id: json['id'],
      surveyId: json['surveyId'],
      respondentId: json['respondentId'],
      answers: Map<String, dynamic>.from(json['answers']),
      submittedAt: DateTime.parse(json['submittedAt']),
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'])
          : null,
      isComplete: json['isComplete'],
      ipAddress: json['ipAddress'],
      userAgent: json['userAgent'],
    );
  }
}

/// Survey Analytics Model
class SurveyAnalytics {
  final String surveyId;
  final int totalResponses;
  final int completeResponses;
  final int incompleteResponses;
  final double completionRate;
  final Duration averageCompletionTime;
  final Map<String, dynamic> questionAnalytics;
  final DateTime lastUpdated;

  SurveyAnalytics({
    required this.surveyId,
    required this.totalResponses,
    required this.completeResponses,
    required this.incompleteResponses,
    required this.completionRate,
    required this.averageCompletionTime,
    required this.questionAnalytics,
    required this.lastUpdated,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'surveyId': surveyId,
      'totalResponses': totalResponses,
      'completeResponses': completeResponses,
      'incompleteResponses': incompleteResponses,
      'completionRate': completionRate,
      'averageCompletionTime': averageCompletionTime.inSeconds,
      'questionAnalytics': questionAnalytics,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  /// Create from JSON
  factory SurveyAnalytics.fromJson(Map<String, dynamic> json) {
    return SurveyAnalytics(
      surveyId: json['surveyId'],
      totalResponses: json['totalResponses'],
      completeResponses: json['completeResponses'],
      incompleteResponses: json['incompleteResponses'],
      completionRate: json['completionRate']?.toDouble() ?? 0.0,
      averageCompletionTime: Duration(seconds: json['averageCompletionTime']),
      questionAnalytics: Map<String, dynamic>.from(json['questionAnalytics']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}
