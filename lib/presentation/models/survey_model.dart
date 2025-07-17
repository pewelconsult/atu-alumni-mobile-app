// lib/data/models/survey_model.dart
import 'package:atu_alumni_app/data/models/alumni_model.dart';

class SurveyModel {
  final String id;
  final String title;
  final String description;
  final SurveyType type;
  final SurveyStatus status;
  final List<SurveyQuestion> questions;
  final SurveyTargeting targeting;
  final SurveySettings settings;
  final SurveyAnalytics analytics;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? publishedAt;
  final DateTime? expiresAt;

  SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.questions,
    required this.targeting,
    required this.settings,
    required this.analytics,
    required this.createdBy,
    required this.createdAt,
    this.publishedAt,
    this.expiresAt,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: SurveyType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      status: SurveyStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => SurveyQuestion.fromJson(e))
          .toList(),
      targeting: SurveyTargeting.fromJson(json['targeting']),
      settings: SurveySettings.fromJson(json['settings']),
      analytics: SurveyAnalytics.fromJson(json['analytics']),
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'questions': questions.map((e) => e.toJson()).toList(),
      'targeting': targeting.toJson(),
      'settings': settings.toJson(),
      'analytics': analytics.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'publishedAt': publishedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }
}

enum SurveyType {
  employmentStatus,
  careerProgression,
  skillsAssessment,
  programEvaluation,
  generalFeedback,
  custom,
}

enum SurveyStatus { draft, active, paused, completed, archived }

class SurveyQuestion {
  final String id;
  final String question;
  final String? description;
  final QuestionType type;
  final List<String> options;
  final bool isRequired;
  final ValidationRules? validation;
  final ConditionalLogic? conditional;

  SurveyQuestion({
    required this.id,
    required this.question,
    this.description,
    required this.type,
    this.options = const [],
    this.isRequired = true,
    this.validation,
    this.conditional,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    return SurveyQuestion(
      id: json['id'],
      question: json['question'],
      description: json['description'],
      type: QuestionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      options: List<String>.from(json['options'] ?? []),
      isRequired: json['isRequired'] ?? true,
      validation: json['validation'] != null
          ? ValidationRules.fromJson(json['validation'])
          : null,
      conditional: json['conditional'] != null
          ? ConditionalLogic.fromJson(json['conditional'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'description': description,
      'type': type.toString().split('.').last,
      'options': options,
      'isRequired': isRequired,
      'validation': validation?.toJson(),
      'conditional': conditional?.toJson(),
    };
  }
}

enum QuestionType {
  text,
  email,
  number,
  phone,
  multipleChoice,
  checkbox,
  dropdown,
  rating,
  scale,
  date,
  file,
}

class ValidationRules {
  final int? minLength;
  final int? maxLength;
  final double? minValue;
  final double? maxValue;
  final String? pattern;
  final List<String>? allowedFileTypes;

  ValidationRules({
    this.minLength,
    this.maxLength,
    this.minValue,
    this.maxValue,
    this.pattern,
    this.allowedFileTypes,
  });

  factory ValidationRules.fromJson(Map<String, dynamic> json) {
    return ValidationRules(
      minLength: json['minLength'],
      maxLength: json['maxLength'],
      minValue: json['minValue']?.toDouble(),
      maxValue: json['maxValue']?.toDouble(),
      pattern: json['pattern'],
      allowedFileTypes: json['allowedFileTypes'] != null
          ? List<String>.from(json['allowedFileTypes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minLength': minLength,
      'maxLength': maxLength,
      'minValue': minValue,
      'maxValue': maxValue,
      'pattern': pattern,
      'allowedFileTypes': allowedFileTypes,
    };
  }
}

class ConditionalLogic {
  final String dependsOnQuestionId;
  final String operator; // equals, notEquals, contains, greaterThan, etc.
  final dynamic value;
  final ConditionalAction action; // show, hide, required, optional

  ConditionalLogic({
    required this.dependsOnQuestionId,
    required this.operator,
    required this.value,
    required this.action,
  });

  factory ConditionalLogic.fromJson(Map<String, dynamic> json) {
    return ConditionalLogic(
      dependsOnQuestionId: json['dependsOnQuestionId'],
      operator: json['operator'],
      value: json['value'],
      action: ConditionalAction.values.firstWhere(
        (e) => e.toString().split('.').last == json['action'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dependsOnQuestionId': dependsOnQuestionId,
      'operator': operator,
      'value': value,
      'action': action.toString().split('.').last,
    };
  }
}

enum ConditionalAction { show, hide, required, optional }

class SurveyTargeting {
  final List<int> graduationYears;
  final List<String> programs;
  final List<String> faculties;
  final List<EmploymentStatus> employmentStatuses;
  final bool isOpenToAll;

  SurveyTargeting({
    this.graduationYears = const [],
    this.programs = const [],
    this.faculties = const [],
    this.employmentStatuses = const [],
    this.isOpenToAll = true,
  });

  factory SurveyTargeting.fromJson(Map<String, dynamic> json) {
    return SurveyTargeting(
      graduationYears: List<int>.from(json['graduationYears'] ?? []),
      programs: List<String>.from(json['programs'] ?? []),
      faculties: List<String>.from(json['faculties'] ?? []),
      employmentStatuses:
          (json['employmentStatuses'] as List<dynamic>?)
              ?.map(
                (e) => EmploymentStatus.values.firstWhere(
                  (status) => status.toString().split('.').last == e,
                ),
              )
              .toList() ??
          [],
      isOpenToAll: json['isOpenToAll'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'graduationYears': graduationYears,
      'programs': programs,
      'faculties': faculties,
      'employmentStatuses': employmentStatuses
          .map((e) => e.toString().split('.').last)
          .toList(),
      'isOpenToAll': isOpenToAll,
    };
  }
}

class SurveySettings {
  final bool allowMultipleResponses;
  final bool requireLogin;
  final bool showProgressBar;
  final bool randomizeQuestions;
  final bool allowBackNavigation;
  final String? thankYouMessage;
  final String? redirectUrl;

  SurveySettings({
    this.allowMultipleResponses = false,
    this.requireLogin = true,
    this.showProgressBar = true,
    this.randomizeQuestions = false,
    this.allowBackNavigation = true,
    this.thankYouMessage,
    this.redirectUrl,
  });

  factory SurveySettings.fromJson(Map<String, dynamic> json) {
    return SurveySettings(
      allowMultipleResponses: json['allowMultipleResponses'] ?? false,
      requireLogin: json['requireLogin'] ?? true,
      showProgressBar: json['showProgressBar'] ?? true,
      randomizeQuestions: json['randomizeQuestions'] ?? false,
      allowBackNavigation: json['allowBackNavigation'] ?? true,
      thankYouMessage: json['thankYouMessage'],
      redirectUrl: json['redirectUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'allowMultipleResponses': allowMultipleResponses,
      'requireLogin': requireLogin,
      'showProgressBar': showProgressBar,
      'randomizeQuestions': randomizeQuestions,
      'allowBackNavigation': allowBackNavigation,
      'thankYouMessage': thankYouMessage,
      'redirectUrl': redirectUrl,
    };
  }
}

class SurveyAnalytics {
  final int totalTargeted;
  final int totalResponses;
  final int completedResponses;
  final int partialResponses;
  final double completionRate;
  final double responseRate;
  final Map<String, int> responsesByProgram;
  final Map<String, int> responsesByYear;
  final DateTime? lastResponseAt;

  SurveyAnalytics({
    this.totalTargeted = 0,
    this.totalResponses = 0,
    this.completedResponses = 0,
    this.partialResponses = 0,
    this.completionRate = 0.0,
    this.responseRate = 0.0,
    this.responsesByProgram = const {},
    this.responsesByYear = const {},
    this.lastResponseAt,
  });

  factory SurveyAnalytics.fromJson(Map<String, dynamic> json) {
    return SurveyAnalytics(
      totalTargeted: json['totalTargeted'] ?? 0,
      totalResponses: json['totalResponses'] ?? 0,
      completedResponses: json['completedResponses'] ?? 0,
      partialResponses: json['partialResponses'] ?? 0,
      completionRate: (json['completionRate'] ?? 0.0).toDouble(),
      responseRate: (json['responseRate'] ?? 0.0).toDouble(),
      responsesByProgram: Map<String, int>.from(
        json['responsesByProgram'] ?? {},
      ),
      responsesByYear: Map<String, int>.from(json['responsesByYear'] ?? {}),
      lastResponseAt: json['lastResponseAt'] != null
          ? DateTime.parse(json['lastResponseAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalTargeted': totalTargeted,
      'totalResponses': totalResponses,
      'completedResponses': completedResponses,
      'partialResponses': partialResponses,
      'completionRate': completionRate,
      'responseRate': responseRate,
      'responsesByProgram': responsesByProgram,
      'responsesByYear': responsesByYear,
      'lastResponseAt': lastResponseAt?.toIso8601String(),
    };
  }
}
