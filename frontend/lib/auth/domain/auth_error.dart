/// Authentication error types
enum AuthError {
  // Network errors
  networkError,
  serverError,
  
  // Authentication errors
  invalidCredentials,
  userNotFound,
  userDisabled,
  emailAlreadyInUse,
  weakPassword,
  
  // OTP errors
  invalidOtp,
  otpExpired,
  tooManyRequests,
  
  // Phone auth errors
  invalidPhoneNumber,
  phoneNumberAlreadyInUse,
  
  // General errors
  unknown,
  cancelled,
  
  // Validation errors
  invalidEmail,
  invalidName,
  passwordTooShort,
  passwordMismatch,
}

extension AuthErrorExtension on AuthError {
  String get message {
    switch (this) {
      case AuthError.networkError:
        return 'Network error. Please check your connection.';
      case AuthError.serverError:
        return 'Server error. Please try again later.';
      case AuthError.invalidCredentials:
        return 'Invalid email or password.';
      case AuthError.userNotFound:
        return 'No account found with this email.';
      case AuthError.userDisabled:
        return 'This account has been disabled.';
      case AuthError.emailAlreadyInUse:
        return 'An account already exists with this email.';
      case AuthError.weakPassword:
        return 'Password is too weak. Please choose a stronger password.';
      case AuthError.invalidOtp:
        return 'Invalid OTP code. Please try again.';
      case AuthError.otpExpired:
        return 'OTP code has expired. Please request a new one.';
      case AuthError.tooManyRequests:
        return 'Too many requests. Please try again later.';
      case AuthError.invalidPhoneNumber:
        return 'Invalid phone number format.';
      case AuthError.phoneNumberAlreadyInUse:
        return 'This phone number is already registered.';
      case AuthError.unknown:
        return 'An unknown error occurred. Please try again.';
      case AuthError.cancelled:
        return 'Operation was cancelled.';
      case AuthError.invalidEmail:
        return 'Please enter a valid email address.';
      case AuthError.invalidName:
        return 'Please enter a valid name.';
      case AuthError.passwordTooShort:
        return 'Password must be at least 6 characters long.';
      case AuthError.passwordMismatch:
        return 'Passwords do not match.';
    }
  }
}
