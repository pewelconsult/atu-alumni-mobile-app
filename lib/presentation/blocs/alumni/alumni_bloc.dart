// lib/presentation/blocs/alumni/alumni_bloc.dart
/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/alumni_model.dart';

// Events
abstract class AlumniEvent extends Equatable {
  const AlumniEvent();

  @override
  List<Object?> get props => [];
}

class AlumniLoadRequested extends AlumniEvent {
  final String? searchQuery;
  final List<String>? filters;

  const AlumniLoadRequested({this.searchQuery, this.filters});

  @override
  List<Object?> get props => [searchQuery, filters];
}

class AlumniProfileUpdateRequested extends AlumniEvent {
  final AlumniModel alumni;

  const AlumniProfileUpdateRequested({required this.alumni});

  @override
  List<Object?> get props => [alumni];
}

class AlumniConnectionRequested extends AlumniEvent {
  final String alumniId;

  const AlumniConnectionRequested({required this.alumniId});

  @override
  List<Object?> get props => [alumniId];
}

class AlumniSearchRequested extends AlumniEvent {
  final String query;

  const AlumniSearchRequested({required this.query});

  @override
  List<Object?> get props => [query];
}

// States
abstract class AlumniState extends Equatable {
  const AlumniState();

  @override
  List<Object?> get props => [];
}

class AlumniInitial extends AlumniState {}

class AlumniLoading extends AlumniState {}

class AlumniLoaded extends AlumniState {
  final List<AlumniModel> alumni;
  final List<AlumniModel> recentlyActive;
  final List<AlumniModel> connections;

  const AlumniLoaded({
    required this.alumni,
    required this.recentlyActive,
    required this.connections,
  });

  @override
  List<Object?> get props => [alumni, recentlyActive, connections];
}

class AlumniError extends AlumniState {
  final String message;

  const AlumniError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AlumniProfileUpdated extends AlumniState {
  final AlumniModel alumni;

  const AlumniProfileUpdated({required this.alumni});

  @override
  List<Object?> get props => [alumni];
}

class AlumniConnectionSent extends AlumniState {
  final String alumniId;

  const AlumniConnectionSent({required this.alumniId});

  @override
  List<Object?> get props => [alumniId];
}

// BLoC
class AlumniBloc extends Bloc<AlumniEvent, AlumniState> {
  AlumniBloc() : super(AlumniInitial()) {
    on<AlumniLoadRequested>(_onAlumniLoadRequested);
    on<AlumniProfileUpdateRequested>(_onAlumniProfileUpdateRequested);
    on<AlumniConnectionRequested>(_onAlumniConnectionRequested);
    on<AlumniSearchRequested>(_onAlumniSearchRequested);
  }

  Future<void> _onAlumniLoadRequested(
    AlumniLoadRequested event,
    Emitter<AlumniState> emit,
  ) async {
    emit(AlumniLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final alumni = _getMockAlumni();
      final recentlyActive = alumni
          .where(
            (a) => a.networking.lastActiveAt.isAfter(
              DateTime.now().subtract(const Duration(days: 7)),
            ),
          )
          .toList();
      final connections = alumni
          .where((a) => a.networking.connections.isNotEmpty)
          .toList();

      emit(
        AlumniLoaded(
          alumni: alumni,
          recentlyActive: recentlyActive,
          connections: connections,
        ),
      );
    } catch (e) {
      emit(AlumniError(message: 'Failed to load alumni: ${e.toString()}'));
    }
  }

  Future<void> _onAlumniProfileUpdateRequested(
    AlumniProfileUpdateRequested event,
    Emitter<AlumniState> emit,
  ) async {
    emit(AlumniLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      emit(AlumniProfileUpdated(alumni: event.alumni));

      // Reload alumni
      add(const AlumniLoadRequested());
    } catch (e) {
      emit(AlumniError(message: 'Failed to update profile: ${e.toString()}'));
    }
  }

  Future<void> _onAlumniConnectionRequested(
    AlumniConnectionRequested event,
    Emitter<AlumniState> emit,
  ) async {
    emit(AlumniLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      emit(AlumniConnectionSent(alumniId: event.alumniId));

      // Reload alumni
      add(const AlumniLoadRequested());
    } catch (e) {
      emit(
        AlumniError(
          message: 'Failed to send connection request: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onAlumniSearchRequested(
    AlumniSearchRequested event,
    Emitter<AlumniState> emit,
  ) async {
    emit(AlumniLoading());

    try {
      // Simulate search API call
      await Future.delayed(const Duration(milliseconds: 500));

      final allAlumni = _getMockAlumni();
      final filteredAlumni = allAlumni
          .where(
            (alumni) =>
                alumni.personal.bio?.toLowerCase().contains(
                  event.query.toLowerCase(),
                ) ??
                false ||
                    alumni.professional.currentPosition?.toLowerCase().contains(
                      event.query.toLowerCase(),
                    ) ??
                false ||
                    alumni.professional.currentCompany?.toLowerCase().contains(
                      event.query.toLowerCase(),
                    ) ??
                false,
          )
          .toList();

      emit(
        AlumniLoaded(
          alumni: filteredAlumni,
          recentlyActive: [],
          connections: [],
        ),
      );
    } catch (e) {
      emit(AlumniError(message: 'Search failed: ${e.toString()}'));
    }
  }

  List<AlumniModel> _getMockAlumni() {
    return [
      AlumniModel(
        id: '1',
        userId: 'user1',
        studentId: 'ATU2020001',
        education: EducationInfo(
          program: 'Computer Science',
          faculty: 'Applied Sciences',
          department: 'Computer Science',
          graduationYear: 2020,
          degree: 'Bachelor of Science',
          gpa: '3.8',
        ),
        personal: PersonalInfo(
          dateOfBirth: DateTime(1998, 5, 15),
          gender: 'Male',
          bio:
              'Passionate software engineer with expertise in mobile and web development.',
          interests: ['Technology', 'AI', 'Mobile Development'],
          socialMedia: SocialMediaLinks(
            linkedin: 'https://linkedin.com/in/johndoe',
            twitter: '@johndoe_dev',
          ),
        ),
        professional: ProfessionalInfo(
          currentPosition: 'Software Engineer',
          currentCompany: 'Google Ghana',
          industry: 'Technology',
          employmentStatus: EmploymentStatus.employed,
          salaryRange: '₵8,000 - ₵12,000',
          workHistory: [
            WorkExperience(
              position: 'Software Engineer',
              company: 'Google Ghana',
              industry: 'Technology',
              startDate: DateTime(2022, 1, 15),
              isCurrent: true,
              description:
                  'Working on Android development and machine learning projects.',
            ),
          ],
          lastUpdated: DateTime.now().subtract(const Duration(days: 30)),
        ),
        contact: ContactInfo(
          phoneNumber: '+233 24 123 4567',
          currentAddress: Address(
            street: '123 Labone Street',
            city: 'Accra',
            state: 'Greater Accra',
            country: 'Ghana',
          ),
        ),
        skills: ['Flutter', 'Dart', 'Python', 'Machine Learning', 'Android'],
        achievements: [
          Achievement(
            title: 'Best Graduate Award',
            description: 'Top graduate in Computer Science class of 2020',
            date: DateTime(2020, 7, 15),
            organization: 'ATU',
          ),
        ],
        networking: NetworkingInfo(
          isProfilePublic: true,
          allowMessaging: true,
          showInDirectory: true,
          connections: ['user2', 'user3'],
          lastActiveAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      // Add more mock alumni as needed
    ];
  }
}


*/
