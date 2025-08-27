import 'package:result_type/result_type.dart';
import 'user_model.dart';
import 'auth_error.dart';

/// Authentication service interface
abstract class IAuthService {
  /// Get current authenticated user
  /// Returns null if no user is authenticated
  UserModel? get currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated;

  /// Stream of authentication state changes
  Stream<UserModel?> get authStateChanges;

  /// Sign in with email and password
  /// Returns [Result.failure] with [AuthError] if sign in fails
  Future<Result<UserModel, AuthError>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  /// Returns [Result.failure] with [AuthError] if sign up fails
  Future<Result<UserModel, AuthError>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  /// Sign in with Google
  /// Returns [Result.failure] with [AuthError] if sign in fails
  Future<Result<UserModel, AuthError>> signInWithGoogle();

  /// Sign in with Apple
  /// Returns [Result.failure] with [AuthError] if sign in fails
  /// Only available on iOS 13.0+ and macOS 10.15+
  Future<Result<UserModel, AuthError>> signInWithApple();

  /// Sign in with phone number
  /// Returns [Result.failure] with [AuthError] if sign in fails
  Future<Result<String, AuthError>> signInWithPhoneNumber({
    required String phoneNumber,
  });

  /// Verify phone number with OTP
  /// Returns [Result.failure] with [AuthError] if verification fails
  Future<Result<UserModel, AuthError>> verifyPhoneNumber({
    required String verificationId,
    required String otpCode,
  });

  /// Resend OTP for phone verification
  /// Returns [Result.failure] with [AuthError] if resend fails
  Future<Result<String, AuthError>> resendOtp({
    required String phoneNumber,
  });

  /// Send password reset email
  /// Returns [Result.failure] with [AuthError] if sending fails
  Future<Result<void, AuthError>> sendPasswordResetEmail({
    required String email,
  });

  /// Update user profile
  /// Returns [Result.failure] with [AuthError] if update fails
  Future<Result<UserModel, AuthError>> updateUserProfile({
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
  });

  /// Sign out current user
  /// Returns [Result.failure] with [AuthError] if sign out fails
  Future<Result<void, AuthError>> signOut();

  /// Delete current user account
  /// Returns [Result.failure] with [AuthError] if deletion fails
  Future<Result<void, AuthError>> deleteAccount();

  /// Validate email format
  bool isValidEmail(String email);

  /// Validate password strength
  bool isValidPassword(String password);

  /// Validate phone number format
  bool isValidPhoneNumber(String phoneNumber);

  /// Validate name format
  bool isValidName(String name);

  /// Format phone number for display
  String formatPhoneNumber(String phoneNumber);

  /// Get country code from phone number
  String getCountryCodeFromPhoneNumber(String phoneNumber);

  /// Complete user onboarding
  /// Returns [Result.failure] with [AuthError] if completion fails
  Future<Result<UserModel, AuthError>> completeOnboarding();
}
