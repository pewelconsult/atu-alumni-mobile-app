// lib/data/models/survey_response_model.dart
class SurveyResponseModel {
  final String id;
  final String surveyId;
  final String respondentId;
  final Map<String, dynamic> responses;
  final ResponseStatus status;
  final DateTime startedAt;
  final DateTime? completedAt;
  final DateTime lastUpdatedAt;
  final String? userAgent;
  final String? ipAddress;

  SurveyResponseModel({
    required this.id,
    required this.surveyId,
    required this.respondentId,
    required this.responses,
    required this.status,
    required this.startedAt,
    this.completedAt,
    required this.lastUpdatedAt,
    this.userAgent,
    this.ipAddress,
  });

  factory SurveyResponseModel.fromJson(Map<String, dynamic> json) {
    return SurveyResponseModel(
      id: json['id'],
      surveyId: json['surveyId'],
      respondentId: json['respondentId'],
      responses: Map<String, dynamic>.from(json['responses']),
      status: ResponseStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      startedAt: DateTime.parse(json['startedAt']),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt']),
      userAgent: json['userAgent'],
      ipAddress: json['ipAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surveyId': surveyId,
      'respondentId': respondentId,
      'responses': responses,
      'status': status.toString().split('.').last,
      'startedAt': startedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'lastUpdatedAt': lastUpdatedAt.toIso8601String(),
      'userAgent': userAgent,
      'ipAddress': ipAddress,
    };
  }
}

enum ResponseStatus { started, inProgress, completed, abandoned }
