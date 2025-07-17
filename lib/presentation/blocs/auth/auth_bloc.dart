// lib/presentation/blocs/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const AuthLoginRequested({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String studentId;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.studentId,
  });

  @override
  List<Object?> get props => [email, password, firstName, lastName, studentId];
}

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  const AuthForgotPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthForgotPasswordRequested>(_onAuthForgotPasswordRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Simulate checking stored credentials
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, assume user is not logged in
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: 'Failed to check authentication status'));
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock authentication logic
      if (event.email == 'testuser@gmail.com' && event.password == 'test123') {
        final user = UserModel(
          id: '1',
          email: event.email,
          firstName: 'John',
          lastName: 'Doe',
          role: UserRole.alumni,
          isVerified: true,
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
          preferences: UserPreferences(),
        );

        emit(AuthAuthenticated(user: user));
      } else if (event.email == 'admin@atu.edu.gh' &&
          event.password == 'admin123') {
        final user = UserModel(
          id: 'admin1',
          email: event.email,
          firstName: 'Peter',
          lastName: 'Nyanor',
          role: UserRole.admin,
          isVerified: true,
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
          preferences: UserPreferences(),
        );

        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthError(message: 'Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(message: 'Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Simulate logout process
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: 'Logout failed'));
    }
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Simulate registration API call
      await Future.delayed(const Duration(seconds: 3));

      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
        role: UserRole.alumni,
        isVerified: false,
        createdAt: DateTime.now(),
        preferences: UserPreferences(),
      );

      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: 'Registration failed: ${e.toString()}'));
    }
  }

  Future<void> _onAuthForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Simulate password reset email
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: 'Password reset failed'));
    }
  }
}
