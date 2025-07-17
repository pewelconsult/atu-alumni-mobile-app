// lib/presentation/blocs/surveys/survey_bloc.dart
/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/survey_model.dart';

// Events
abstract class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object?> get props => [];
}

class SurveyLoadRequested extends SurveyEvent {}

class SurveyCreateRequested extends SurveyEvent {
  final SurveyModel survey;

  const SurveyCreateRequested({required this.survey});

  @override
  List<Object?> get props => [survey];
}

class SurveyUpdateRequested extends SurveyEvent {
  final SurveyModel survey;

  const SurveyUpdateRequested({required this.survey});

  @override
  List<Object?> get props => [survey];
}

class SurveyDeleteRequested extends SurveyEvent {
  final String surveyId;

  const SurveyDeleteRequested({required this.surveyId});

  @override
  List<Object?> get props => [surveyId];
}

class SurveyPublishRequested extends SurveyEvent {
  final String surveyId;

  const SurveyPublishRequested({required this.surveyId});

  @override
  List<Object?> get props => [surveyId];
}

class SurveyResponseSubmitted extends SurveyEvent {
  final String surveyId;
  final Map<String, dynamic> responses;

  const SurveyResponseSubmitted({
    required this.surveyId,
    required this.responses,
  });

  @override
  List<Object?> get props => [surveyId, responses];
}

// States
abstract class SurveyState extends Equatable {
  const SurveyState();

  @override
  List<Object?> get props => [];
}

class SurveyInitial extends SurveyState {}

class SurveyLoading extends SurveyState {}

class SurveyLoaded extends SurveyState {
  final List<SurveyModel> surveys;
  final List<SurveyModel> activeSurveys;
  final List<SurveyModel> draftSurveys;
  final List<SurveyModel> completedSurveys;

  const SurveyLoaded({
    required this.surveys,
    required this.activeSurveys,
    required this.draftSurveys,
    required this.completedSurveys,
  });

  @override
  List<Object?> get props => [
    surveys,
    activeSurveys,
    draftSurveys,
    completedSurveys,
  ];
}

class SurveyError extends SurveyState {
  final String message;

  const SurveyError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SurveyCreated extends SurveyState {
  final SurveyModel survey;

  const SurveyCreated({required this.survey});

  @override
  List<Object?> get props => [survey];
}

class SurveyUpdated extends SurveyState {
  final SurveyModel survey;

  const SurveyUpdated({required this.survey});

  @override
  List<Object?> get props => [survey];
}

class SurveyResponseSubmittedState extends SurveyState {
  final String surveyId;

  const SurveyResponseSubmittedState({required this.surveyId});

  @override
  List<Object?> get props => [surveyId];
}

// BLoC
class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  SurveyBloc() : super(SurveyInitial()) {
    on<SurveyLoadRequested>(_onSurveyLoadRequested);
    on<SurveyCreateRequested>(_onSurveyCreateRequested);
    on<SurveyUpdateRequested>(_onSurveyUpdateRequested);
    on<SurveyDeleteRequested>(_onSurveyDeleteRequested);
    on<SurveyPublishRequested>(_onSurveyPublishRequested);
    on<SurveyResponseSubmitted>(_onSurveyResponseSubmitted);
  }

  Future<void> _onSurveyLoadRequested(
    SurveyLoadRequested event,
    Emitter<SurveyState> emit,
  ) async {
    emit(SurveyLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final surveys = _getMockSurveys();
      final activeSurveys = surveys
          .where((s) => s.status == SurveyStatus.active)
          .toList();
      final draftSurveys = surveys
          .where((s) => s.status == SurveyStatus.draft)
          .toList();
      final completedSurveys = surveys
          .where((s) => s.status == SurveyStatus.completed)
          .toList();

      emit(
        SurveyLoaded(
          surveys: surveys,
          activeSurveys: activeSurveys,
          draftSurveys: draftSurveys,
          completedSurveys: completedSurveys,
        ),
      );
    } catch (e) {
      emit(SurveyError(message: 'Failed to load surveys: ${e.toString()}'));
    }
  }

  Future<void> _onSurveyCreateRequested(
    SurveyCreateRequested event,
    Emitter<SurveyState> emit,
  ) async {
    emit(SurveyLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      emit(SurveyCreated(survey: event.survey));

      // Reload surveys
      add(SurveyLoadRequested());
    } catch (e) {
      emit(SurveyError(message: 'Failed to create survey: ${e.toString()}'));
    }
  }

  Future<void> _onSurveyUpdateRequested(
    SurveyUpdateRequested event,
    Emitter<SurveyState> emit,
  ) async {
    emit(SurveyLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      emit(SurveyUpdated(survey: event.survey));

      // Reload surveys
      add(SurveyLoadRequested());
    } catch (e) {
      emit(SurveyError(message: 'Failed to update survey: ${e.toString()}'));
    }
  }

  Future<void> _onSurveyDeleteRequested(
    SurveyDeleteRequested event,
    Emitter<SurveyState> emit,
  ) async {
    emit(SurveyLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Reload surveys
      add(SurveyLoadRequested());
    } catch (e) {
      emit(SurveyError(message: 'Failed to delete survey: ${e.toString()}'));
    }
  }

  Future<void> _onSurveyPublishRequested(
    SurveyPublishRequested event,
    Emitter<SurveyState> emit,
  ) async {
    emit(SurveyLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Reload surveys
      add(SurveyLoadRequested());
    } catch (e) {
      emit(SurveyError(message: 'Failed to publish survey: ${e.toString()}'));
    }
  }

  Future<void> _onSurveyResponseSubmitted(
    SurveyResponseSubmitted event,
    Emitter<SurveyState> emit,
  ) async {
    emit(SurveyLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      emit(SurveyResponseSubmittedState(surveyId: event.surveyId));
    } catch (e) {
      emit(SurveyError(message: 'Failed to submit response: ${e.toString()}'));
    }
  }

  List<SurveyModel> _getMockSurveys() {
    return [
      SurveyModel(
        id: '1',
        title: 'Employment Status Survey 2024',
        description:
            'Current employment status and salary information for recent graduates.',
        type: SurveyType.employmentStatus,
        status: SurveyStatus.active,
        questions: [
          SurveyQuestion(
            id: 'employment_status',
            question: 'What is your current employment status?',
            type: QuestionType.multipleChoice,
            options: [
              'Employed full-time',
              'Employed part-time',
              'Self-employed',
              'Unemployed - seeking work',
              'Unemployed - not seeking work',
              'Continuing education',
            ],
          ),
        ],
        targeting: SurveyTargeting(),
        settings: SurveySettings(),
        analytics: SurveyAnalytics(
          totalTargeted: 150,
          totalResponses: 87,
          completedResponses: 82,
          partialResponses: 5,
          completionRate: 94.3,
          responseRate: 58.0,
        ),
        createdBy: 'admin',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        publishedAt: DateTime.now().subtract(const Duration(days: 8)),
        expiresAt: DateTime.now().add(const Duration(days: 20)),
      ),
      SurveyModel(
        id: '2',
        title: 'Skills Gap Analysis',
        description:
            'Identify skills gaps in current curriculum based on industry demands.',
        type: SurveyType.skillsAssessment,
        status: SurveyStatus.draft,
        questions: [],
        targeting: SurveyTargeting(),
        settings: SurveySettings(),
        analytics: SurveyAnalytics(),
        createdBy: 'admin',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
}


*/
