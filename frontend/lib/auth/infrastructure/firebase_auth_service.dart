import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:result_type/result_type.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import '../domain/i_auth_service.dart';
import '../domain/user_model.dart';
import '../domain/auth_error.dart';

class FirebaseAuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // Stream controller for auth state changes
  final StreamController<UserModel?> _authStateController = StreamController<UserModel?>.broadcast();

  FirebaseAuthService({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn(
         scopes: ['email', 'profile'],
       ) {
    // Listen to Firebase auth state changes and convert to our domain model
    _firebaseAuth.authStateChanges().listen((User? user) {
      _authStateController.add(user != null ? _userFromFirebase(user) : null);
    });

    // Initialize Google Sign-In
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      // Google Sign-In 7.x doesn't require explicit initialization
      // The initialization happens automatically when needed
    } catch (e) {
      // Handle initialization error
      // In production, use a proper logging framework
      debugPrint('Google Sign-In initialization error: $e');
    }
  }

  @override
  UserModel? get currentUser {
    final user = _firebaseAuth.currentUser;
    return user != null ? _userFromFirebase(user) : null;
  }

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  @override
  Stream<UserModel?> get authStateChanges => _authStateController.stream;

  @override
  Future<Result<UserModel, AuthError>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user != null) {
        return Success(_userFromFirebase(credential.user!));
      } else {
        return Failure(AuthError.unknown);
      }
    } on FirebaseAuthException catch (e) {
      return Failure(_mapFirebaseError(e));
    } catch (e) {
      return Failure(AuthError.unknown);
    }
  }

  @override
  Future<Result<UserModel, AuthError>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user != null) {
        // Update display name
        await credential.user!.updateDisplayName(name);
        await credential.user!.reload();
        
        final updatedUser = _firebaseAuth.currentUser;
        return Success(_userFromFirebase(updatedUser!));
      } else {
        return Failure(AuthError.unknown);
      }
    } on FirebaseAuthException catch (e) {
      return Failure(_mapFirebaseError(e));
    } catch (e) {
      return Failure(AuthError.unknown);
    }
  }

  @override
  Future<Result<UserModel, AuthError>> signInWithGoogle() async {
    try {
      print('🔐 Starting Google Sign-In process...');

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print('🔐 Google Sign-In result: ${googleUser?.email ?? 'null'}');

      if (googleUser == null) {
        // User cancelled the sign-in
        print('🔐 Google Sign-In cancelled by user');
        return Failure(AuthError.cancelled);
      }

      print('🔐 Getting Google authentication details...');
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('🔐 Got access token: ${googleAuth.accessToken != null}');
      print('🔐 Got ID token: ${googleAuth.idToken != null}');

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('🔐 Created Firebase credential');

      // Sign in to Firebase with the Google credential
      print('🔐 Signing in to Firebase...');
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      print('🔐 Firebase sign-in result: ${userCredential.user?.email ?? 'null'}');

      if (userCredential.user != null) {
        final user = _userFromFirebase(userCredential.user!);
        print('🔐 Created user model: ${user.email}, onboarding complete: ${user.isOnboardingComplete}');
        return Success(user);
      } else {
        print('🔐 Firebase sign-in failed: no user returned');
        return Failure(AuthError.unknown);
      }
    } on PlatformException catch (e) {
      print('🔐 Platform Exception: ${e.code} - ${e.message}');
      // Handle Google Sign-In specific errors
      switch (e.code) {
        case 'sign_in_canceled':
          return Failure(AuthError.cancelled);
        case 'network_error':
          return Failure(AuthError.networkError);
        case 'sign_in_failed':
          // This usually indicates a configuration issue
          print('🔐 Google Sign-In configuration error. Check SHA-1 fingerprint and package name in Firebase Console.');
          return Failure(AuthError.serverError);
        default:
          return Failure(AuthError.unknown);
      }
    } on FirebaseAuthException catch (e) {
      print('🔐 Firebase Auth Exception: ${e.code} - ${e.message}');
      return Failure(_mapFirebaseError(e));
    } catch (e) {
      print('🔐 Unknown error during Google Sign-In: $e');
      return Failure(AuthError.unknown);
    }
  }

  @override
  Future<Result<UserModel, AuthError>> signInWithApple() async {
    try {
      // Check if Apple Sign-In is available
      if (!await SignInWithApple.isAvailable()) {
        return Failure(AuthError.unknown);
      }

      // Generate a random nonce for security
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Request credential from Apple
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create Firebase credential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(oauthCredential);

      if (userCredential.user != null) {
        // Update display name if available from Apple
        if (appleCredential.givenName != null || appleCredential.familyName != null) {
          final displayName = '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'.trim();
          if (displayName.isNotEmpty) {
            await userCredential.user!.updateDisplayName(displayName);
            await userCredential.user!.reload();
          }
        }

        final updatedUser = _firebaseAuth.currentUser;
        return Success(_userFromFirebase(updatedUser!));
      } else {
        return Failure(AuthError.unknown);
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
          return Failure(AuthError.cancelled);
        case AuthorizationErrorCode.failed:
        case AuthorizationErrorCode.invalidResponse:
        case AuthorizationErrorCode.notHandled:
        case AuthorizationErrorCode.unknown:
        default:
          return Failure(AuthError.unknown);
      }
    } on FirebaseAuthException catch (e) {
      return Failure(_mapFirebaseError(e));
    } catch (e) {
      return Failure(AuthError.unknown);
    }
  }

  @override
  Future<Result<String, AuthError>> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      // Validate phone number format first
      if (!isValidPhoneNumber(phoneNumber)) {
        return Failure(AuthError.invalidPhoneNumber);
      }

      final completer = Completer<Result<String, AuthError>>();

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60), // Set timeout for verification
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification completed (Android only)
          try {
            final userCredential = await _firebaseAuth.signInWithCredential(credential);
            if (userCredential.user != null) {
              completer.complete(Success('auto-verified'));
            } else {
              completer.complete(Failure(AuthError.unknown));
            }
          } catch (e) {
            completer.complete(Failure(AuthError.unknown));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          // Enhanced error handling for phone verification failures
          AuthError error;
          switch (e.code) {
            case 'invalid-phone-number':
              error = AuthError.invalidPhoneNumber;
              break;
            case 'too-many-requests':
              error = AuthError.tooManyRequests;
              break;
            case 'quota-exceeded':
              error = AuthError.tooManyRequests;
              break;
            case 'network-request-failed':
              error = AuthError.networkError;
              break;
            default:
              error = _mapFirebaseError(e);
          }
          completer.complete(Failure(error));
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(Success(verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Only complete if not already completed
          if (!completer.isCompleted) {
            completer.complete(Success(verificationId));
          }
        },
      );

      return await completer.future;
    } on FirebaseAuthException catch (e) {
      return Failure(_mapFirebaseError(e));
    } catch (e) {
      return Failure(AuthError.unknown);
    }
  }

  @override
  Future<Result<UserModel, AuthError>> verifyPhoneNumber({
    required String verificationId,
    required String otpCode,
  }) async {
    try {
      // Validate OTP code format
      if (otpCode.trim().isEmpty || otpCode.trim().length != 6) {
        return Failure(AuthError.invalidOtp);
      }

      // Ensure OTP contains only digits
      if (!RegExp(r'^\d{6}$').hasMatch(otpCode.trim())) {
        return Failure(AuthError.invalidOtp);
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode.trim(),
      );

      print('🔐 Verifying OTP with credential');

      // Get the current user (should be Google-authenticated)
      final currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        print('🔐 Linking phone credential to existing user');
        // Link the phone credential to the existing Google user
        await currentUser.linkWithCredential(credential);
        await currentUser.reload();
        final updatedUser = _firebaseAuth.currentUser;
        print('🔐 Phone credential linked successfully');
        return Success(_userFromFirebase(updatedUser!));
      } else {
        print('🔐 No current user, signing in with phone credential');
        // If no current user, sign in with the credential
        final userCredential = await _firebaseAuth.signInWithCredential(credential);
        if (userCredential.user != null) {
          return Success(_userFromFirebase(userCredential.user!));
        } else {
          return Failure(AuthError.unknown);
        }
      }
    } on FirebaseAuthException catch (e) {
      // Enhanced error handling for OTP verification
      AuthError error;
      switch (e.code) {
        case 'invalid-verification-code':
          error = AuthError.invalidOtp;
          break;
        case 'session-expired':
        case 'code-expired':
          error = AuthError.otpExpired;
          break;
        case 'too-many-requests':
          error = AuthError.tooManyRequests;
          break;
        case 'network-request-failed':
          error = AuthError.networkError;
          break;
        default:
          error = _mapFirebaseError(e);
      }
      return Failure(error);
    } catch (e) {
      return Failure(AuthError.unknown);
    }
  }

  @override
  Future<Result<String, AuthError>> resendOtp({
    required String phoneNumber,
  }) async {
    // Resend OTP by calling signInWithPhoneNumber again
    return await signInWithPhoneNumber(phoneNumber: phoneNumber);
  }

  @override
  Future<Result<void, AuthError>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return Success(null);
    } on FirebaseAuthException catch (e) {
      return Failure(_mapFirebaseError(e));
    } catch (e) {
      return Failure(AuthError.unknown);
    }
  }

  @override
  Future<Result<UserModel, AuthError>> updateUserProfile({
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Failure(AuthError.userNotFound);
      }

      print('🔐 Updating user profile: name=$name, phone=$phoneNumber');

      if (name != null) {
        await user.updateDisplayName(name);
        print('🔐 Updated display name to: $name');
      }

      if (profileImageUrl != null) {
        await user.updatePhotoURL(profileImageUrl);
        print('🔐 Updated profile image URL');
      }

      // Note: Phone number updates require re-authentication in Firebase
      // The phone number will be updated when the user completes phone verification

      await user.reload();
      final updatedUser = _firebaseAuth.currentUser;
      final userModel = _userFromFirebase(updatedUser!);
      print('🔐 Profile updated successfully');
      return Success(userModel);
    } on FirebaseAuthException catch (e) {
      print('🔐 Firebase error updating profile: ${e.code} - ${e.message}');
      return Failure(_mapFirebaseError(e));
    } catch (e) {
      print('🔐 Unknown error updating profile: $e');
      return Failure(AuthError.unknown);
    }
  }

  @override
  Future<Result<void, AuthError>> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      return Success(null);
    } catch (e) {
      return Failure(AuthError.unknown);
    }
  }

  @override
  Future<Result<void, AuthError>> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Failure(AuthError.userNotFound);
      }

      await user.delete();
      return Success(null);
    } on FirebaseAuthException catch (e) {
      return Failure(_mapFirebaseError(e));
    } catch (e) {
      return Failure(AuthError.unknown);
    }
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
    // Enhanced phone number validation
    // Must start with + followed by country code and number
    // Total length should be between 10-15 digits (including country code)
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // Check basic format: starts with + and has proper length
    if (!RegExp(r'^\+[1-9]\d{8,14}$').hasMatch(cleanNumber)) {
      return false;
    }

    // Additional validation for common country codes
    final countryCodePatterns = [
      r'^\+1\d{10}$',        // US/Canada (11 digits total)
      r'^\+44\d{10}$',       // UK (12 digits total)
      r'^\+91\d{10}$',       // India (12 digits total)
      r'^\+86\d{11}$',       // China (13 digits total)
      r'^\+49\d{10,11}$',    // Germany (12-13 digits total)
      r'^\+33\d{9}$',        // France (11 digits total)
      r'^\+81\d{10,11}$',    // Japan (12-13 digits total)
      r'^\+82\d{9,10}$',     // South Korea (11-12 digits total)
      r'^\+61\d{9}$',        // Australia (11 digits total)
      r'^\+55\d{10,11}$',    // Brazil (12-13 digits total)
    ];

    // If it matches any known pattern, it's valid
    for (final pattern in countryCodePatterns) {
      if (RegExp(pattern).hasMatch(cleanNumber)) {
        return true;
      }
    }

    // For other countries, use the basic validation
    return RegExp(r'^\+[1-9]\d{8,14}$').hasMatch(cleanNumber);
  }

  @override
  bool isValidName(String name) {
    return name.trim().length >= 2 && name.trim().length <= 50;
  }

  @override
  String formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters except +
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    if (!cleanNumber.startsWith('+')) {
      return phoneNumber; // Return original if not in international format
    }

    // Format based on common country codes
    if (cleanNumber.startsWith('+1')) {
      // US/Canada format: +1 (XXX) XXX-XXXX
      if (cleanNumber.length == 12) {
        return '+1 (${cleanNumber.substring(2, 5)}) ${cleanNumber.substring(5, 8)}-${cleanNumber.substring(8)}';
      }
    } else if (cleanNumber.startsWith('+44')) {
      // UK format: +44 XXXX XXX XXX
      if (cleanNumber.length == 13) {
        return '+44 ${cleanNumber.substring(3, 7)} ${cleanNumber.substring(7, 10)} ${cleanNumber.substring(10)}';
      }
    } else if (cleanNumber.startsWith('+91')) {
      // India format: +91 XXXXX XXXXX
      if (cleanNumber.length == 13) {
        return '+91 ${cleanNumber.substring(3, 8)} ${cleanNumber.substring(8)}';
      }
    }

    // Default formatting for other countries
    if (cleanNumber.length > 4) {
      final countryCode = cleanNumber.substring(0, cleanNumber.length - 10);
      final number = cleanNumber.substring(cleanNumber.length - 10);
      if (number.length == 10) {
        return '$countryCode ${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6)}';
      }
    }

    return cleanNumber; // Return cleaned number if no specific format applies
  }

  @override
  String getCountryCodeFromPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    if (!cleanNumber.startsWith('+')) {
      return '';
    }

    // Extract country code based on known patterns
    final countryCodeMap = {
      '+1': 'US/CA',
      '+44': 'UK',
      '+91': 'IN',
      '+86': 'CN',
      '+49': 'DE',
      '+33': 'FR',
      '+81': 'JP',
      '+82': 'KR',
      '+61': 'AU',
      '+55': 'BR',
    };

    for (final entry in countryCodeMap.entries) {
      if (cleanNumber.startsWith(entry.key)) {
        return entry.key;
      }
    }

    // For unknown country codes, try to extract first 1-4 digits after +
    final match = RegExp(r'^\+(\d{1,4})').firstMatch(cleanNumber);
    return match != null ? '+${match.group(1)}' : '';
  }

  /// Convert Firebase User to our domain UserModel
  UserModel _userFromFirebase(User user) {
    final hasName = user.displayName != null && user.displayName!.isNotEmpty;
    final hasPhone = user.phoneNumber != null && user.phoneNumber!.isNotEmpty;
    final isPhoneVerified = hasPhone;

    // User is considered to have completed onboarding if they have name, phone, and phone is verified
    final isOnboardingComplete = hasName && hasPhone && isPhoneVerified;

    print('🔐 _userFromFirebase: name=$hasName, phone=$hasPhone, verified=$isPhoneVerified, onboarding=$isOnboardingComplete');

    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      phoneNumber: user.phoneNumber ?? '',
      profileImageUrl: user.photoURL ?? '',
      isEmailVerified: user.emailVerified,
      isPhoneVerified: isPhoneVerified,
      isOnboardingComplete: isOnboardingComplete,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      lastLoginAt: user.metadata.lastSignInTime ?? DateTime.now(),
    );
  }

  /// Map Firebase Auth exceptions to our domain errors
  AuthError _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthError.userNotFound;
      case 'wrong-password':
      case 'invalid-credential':
        return AuthError.invalidCredentials;
      case 'user-disabled':
        return AuthError.userDisabled;
      case 'email-already-in-use':
        return AuthError.emailAlreadyInUse;
      case 'weak-password':
        return AuthError.weakPassword;
      case 'invalid-phone-number':
        return AuthError.invalidPhoneNumber;
      case 'invalid-verification-code':
        return AuthError.invalidOtp;
      case 'session-expired':
        return AuthError.otpExpired;
      case 'too-many-requests':
        return AuthError.tooManyRequests;
      case 'network-request-failed':
        return AuthError.networkError;
      default:
        return AuthError.unknown;
    }
  }

  /// Generate a cryptographically secure random nonce
  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  /// Returns the sha256 hash of [input] in hex notation
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<Result<UserModel, AuthError>> completeOnboarding() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Failure(AuthError.userNotFound);
      }

      print('🔐 Completing onboarding for user: ${user.email}');

      // Reload user to get the latest information including linked phone number
      await user.reload();
      final updatedUser = _firebaseAuth.currentUser;

      if (updatedUser != null) {
        final userModel = _userFromFirebase(updatedUser);
        print('🔐 Onboarding completion check - Name: ${userModel.name.isNotEmpty}, Phone: ${userModel.phoneNumber.isNotEmpty}, Verified: ${userModel.isPhoneVerified}');
        print('🔐 Onboarding complete: ${userModel.isOnboardingComplete}');
        return Success(userModel);
      } else {
        return Failure(AuthError.unknown);
      }
    } on FirebaseAuthException catch (e) {
      print('🔐 Firebase error completing onboarding: ${e.code} - ${e.message}');
      return Failure(_mapFirebaseError(e));
    } catch (e) {
      print('🔐 Unknown error completing onboarding: $e');
      return Failure(AuthError.unknown);
    }
  }

  void dispose() {
    _authStateController.close();
  }
}
