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
        return 'Network connection failed. Please check your internet connection and try again.';
      case AuthError.serverError:
        return 'Our servers are experiencing issues. Please try again in a few moments.';
      case AuthError.invalidCredentials:
        return 'The email or password you entered is incorrect. Please try again.';
      case AuthError.userNotFound:
        return 'No account found with this email address. Please check your email or sign up for a new account.';
      case AuthError.userDisabled:
        return 'This account has been temporarily disabled. Please contact support for assistance.';
      case AuthError.emailAlreadyInUse:
        return 'An account with this email already exists. Try signing in instead.';
      case AuthError.weakPassword:
        return 'Your password is too weak. Please use at least 8 characters with a mix of letters, numbers, and symbols.';
      case AuthError.invalidOtp:
        return 'The verification code you entered is incorrect. Please check and try again.';
      case AuthError.otpExpired:
        return 'Your verification code has expired. Please request a new one.';
      case AuthError.tooManyRequests:
        return 'Too many failed attempts. Please wait a few minutes before trying again.';
      case AuthError.invalidPhoneNumber:
        return 'Please enter a valid phone number with country code (e.g., +1 234 567 8900).';
      case AuthError.phoneNumberAlreadyInUse:
        return 'This phone number is already registered. Try signing in instead.';
      case AuthError.unknown:
        return 'Something went wrong. Please try again or contact support if the problem persists.';
      case AuthError.cancelled:
        return 'Sign-in was cancelled. Please try again when you\'re ready.';
      case AuthError.invalidEmail:
        return 'Please enter a valid email address (e.g., user@example.com).';
      case AuthError.invalidName:
        return 'Please enter your full name (at least 2 characters).';
      case AuthError.passwordTooShort:
        return 'Password must be at least 8 characters long for better security.';
      case AuthError.passwordMismatch:
        return 'The passwords you entered don\'t match. Please try again.';
    }
  }

  /// Returns a user-friendly title for error dialogs
  String get title {
    switch (this) {
      case AuthError.networkError:
        return 'Connection Problem';
      case AuthError.serverError:
        return 'Server Issue';
      case AuthError.invalidCredentials:
        return 'Sign In Failed';
      case AuthError.userNotFound:
        return 'Account Not Found';
      case AuthError.userDisabled:
        return 'Account Disabled';
      case AuthError.emailAlreadyInUse:
        return 'Email Already Registered';
      case AuthError.weakPassword:
        return 'Weak Password';
      case AuthError.invalidOtp:
        return 'Invalid Code';
      case AuthError.otpExpired:
        return 'Code Expired';
      case AuthError.tooManyRequests:
        return 'Too Many Attempts';
      case AuthError.invalidPhoneNumber:
        return 'Invalid Phone Number';
      case AuthError.phoneNumberAlreadyInUse:
        return 'Phone Already Registered';
      case AuthError.unknown:
        return 'Oops!';
      case AuthError.cancelled:
        return 'Cancelled';
      case AuthError.invalidEmail:
        return 'Invalid Email';
      case AuthError.invalidName:
        return 'Invalid Name';
      case AuthError.passwordTooShort:
        return 'Password Too Short';
      case AuthError.passwordMismatch:
        return 'Passwords Don\'t Match';
    }
  }
}
