import 'dart:async';
import 'package:result_type/result_type.dart';
import '../domain/i_auth_service.dart';
import '../domain/user_model.dart';
import '../domain/auth_error.dart';

/// Mock implementation of IAuthService for development and testing
class MockAuthService implements IAuthService {
  UserModel? _currentUser;
  final StreamController<UserModel?> _authStateController = StreamController<UserModel?>.broadcast();

  @override
  UserModel? get currentUser => _currentUser;

  @override
  bool get isAuthenticated => _currentUser != null;

  @override
  Stream<UserModel?> get authStateChanges => _authStateController.stream;

  @override
  Future<Result<UserModel, AuthError>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (!isValidEmail(email)) {
      return Failure(AuthError.invalidEmail);
    }

    if (password.length < 6) {
      return Failure(AuthError.weakPassword);
    }

    // Mock successful sign in
    final user = UserModel(
      id: 'mock_user_id',
      name: 'John Doe',
      email: email,
      isEmailVerified: true,
      stats: const UserStats(
        currentStreak: 2,
        bestStreak: 5,
        quizzesTaken: 12,
        minutesPracticed: 45,
        weeklyStreak: [true, true, false, true, false, false, false],
      ),
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastLoginAt: DateTime.now(),
    );

    _currentUser = user;
    _authStateController.add(user);
    return Success(user);
  }

  @override
  Future<Result<UserModel, AuthError>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (!isValidEmail(email)) {
      return Failure(AuthError.invalidEmail);
    }

    if (!isValidName(name)) {
      return Failure(AuthError.invalidName);
    }

    if (!isValidPassword(password)) {
      return Failure(AuthError.weakPassword);
    }

    // Mock successful sign up
    final user = UserModel(
      id: 'mock_new_user_id',
      name: name,
      email: email,
      isEmailVerified: false,
      stats: const UserStats(
        currentStreak: 0,
        bestStreak: 0,
        quizzesTaken: 0,
        minutesPracticed: 0,
        weeklyStreak: [false, false, false, false, false, false, false],
      ),
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );

    _currentUser = user;
    _authStateController.add(user);
    return Success(user);
  }

  @override
  Future<Result<UserModel, AuthError>> signInWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock successful Google sign in - user needs to complete onboarding
    final user = UserModel(
      id: 'mock_google_user_id',
      name: '', // No name initially - needs onboarding
      email: 'user@gmail.com',
      phoneNumber: '', // No phone initially - needs onboarding
      isEmailVerified: true,
      isPhoneVerified: false,
      isOnboardingComplete: false, // Needs to complete onboarding
      stats: const UserStats(
        currentStreak: 0,
        bestStreak: 0,
        quizzesTaken: 0,
        minutesPracticed: 0,
        weeklyStreak: [false, false, false, false, false, false, false],
      ),
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );

    _currentUser = user;
    _authStateController.add(user);
    return Success(user);
  }

  @override
  Future<Result<UserModel, AuthError>> signInWithApple() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock successful Apple sign in
    final user = UserModel(
      id: 'mock_apple_user_id',
      name: 'Apple User',
      email: 'user@privaterelay.appleid.com',
      isEmailVerified: true,
      stats: const UserStats(
        currentStreak: 2,
        bestStreak: 4,
        quizzesTaken: 6,
        minutesPracticed: 18,
        weeklyStreak: [true, true, false, false, false, false, false],
      ),
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      lastLoginAt: DateTime.now(),
    );

    _currentUser = user;
    _authStateController.add(user);
    return Success(user);
  }

  @override
  Future<Result<String, AuthError>> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (!isValidPhoneNumber(phoneNumber)) {
      return Failure(AuthError.invalidPhoneNumber);
    }

    // Mock verification ID
    return Success('mock_verification_id');
  }

  @override
  Future<Result<UserModel, AuthError>> verifyPhoneNumber({
    required String verificationId,
    required String otpCode,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (otpCode != '123456') {
      return Failure(AuthError.invalidOtp);
    }

    // Mock successful phone verification
    final user = UserModel(
      id: 'mock_phone_user_id',
      name: 'Phone User',
      phoneNumber: '+1234567890',
      isPhoneVerified: true,
      stats: const UserStats(
        currentStreak: 0,
        bestStreak: 0,
        quizzesTaken: 0,
        minutesPracticed: 0,
        weeklyStreak: [false, false, false, false, false, false, false],
      ),
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );

    _currentUser = user;
    _authStateController.add(user);
    return Success(user);
  }

  @override
  Future<Result<String, AuthError>> resendOtp({
    required String phoneNumber,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (!isValidPhoneNumber(phoneNumber)) {
      return Failure(AuthError.invalidPhoneNumber);
    }

    // Mock new verification ID
    return Success('mock_new_verification_id');
  }

  @override
  Future<Result<void, AuthError>> sendPasswordResetEmail({
    required String email,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (!isValidEmail(email)) {
      return Failure(AuthError.invalidEmail);
    }

    // Mock successful password reset email
    return Success(null);
  }

  @override
  Future<Result<UserModel, AuthError>> updateUserProfile({
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (_currentUser == null) {
      return Failure(AuthError.userNotFound);
    }

    // Mock profile update
    final updatedUser = _currentUser!.copyWith(
      name: name ?? _currentUser!.name,
      phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
      profileImageUrl: profileImageUrl ?? _currentUser!.profileImageUrl,
    );

    _currentUser = updatedUser;
    _authStateController.add(updatedUser);
    return Success(updatedUser);
  }

  @override
  Future<Result<void, AuthError>> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = null;
    _authStateController.add(null);
    return Success(null);
  }

  @override
  Future<Result<void, AuthError>> deleteAccount() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = null;
    _authStateController.add(null);
    return Success(null);
  }

  @override
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  @override
  bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phoneNumber);
  }

  @override
  bool isValidName(String name) {
    return name.trim().length >= 2;
  }

  @override
  String formatPhoneNumber(String phoneNumber) {
    // Simple mock formatting
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleanNumber.startsWith('+1') && cleanNumber.length == 12) {
      return '+1 (${cleanNumber.substring(2, 5)}) ${cleanNumber.substring(5, 8)}-${cleanNumber.substring(8)}';
    }
    return cleanNumber;
  }

  @override
  String getCountryCodeFromPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleanNumber.startsWith('+1')) return '+1';
    if (cleanNumber.startsWith('+44')) return '+44';
    if (cleanNumber.startsWith('+91')) return '+91';
    return '';
  }

  @override
  Future<Result<UserModel, AuthError>> completeOnboarding() async {
    await Future.delayed(const Duration(seconds: 1));

    if (_currentUser == null) {
      return Failure(AuthError.userNotFound);
    }

    // Mark onboarding as complete
    final updatedUser = _currentUser!.copyWith(
      isOnboardingComplete: true,
    );

    _currentUser = updatedUser;
    _authStateController.add(updatedUser);

    return Success(updatedUser);
  }

  void dispose() {
    _authStateController.close();
  }
}
