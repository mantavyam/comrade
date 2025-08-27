import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/data_state.dart';
import '../domain/user_model.dart';
import '../domain/auth_error.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    required DataState<UserModel> authDataState,
    required DataState<String> phoneVerificationState,
    @Default(false) bool isGuestMode,
    @Default('') String verificationId,
    @Default('') String phoneNumber,
    AuthError? lastError,
  }) = _AuthState;

  // Helper getters for auth state
  bool get isAuthenticated => authDataState.isSuccess && user != null && !user!.needsOnboarding;
  bool get isPartiallyAuthenticated => authDataState.isSuccess && user != null && user!.needsOnboarding;
  bool get isLoading => authDataState.isLoading || phoneVerificationState.isLoading;
  bool get hasError => authDataState.hasError || phoneVerificationState.hasError;
  bool get isIdle => authDataState.isIdle && phoneVerificationState.isIdle;

  UserModel? get user => authDataState.data;
  String? get errorMessage => lastError?.message;

  // Helper getters for phone verification
  bool get isPhoneVerificationInProgress => phoneVerificationState.isSuccess;
  bool get isPhoneVerificationLoading => phoneVerificationState.isLoading;
  bool get hasPhoneVerificationError => phoneVerificationState.hasError;

  factory AuthState.initial() => const AuthState(
        authDataState: DataState.idle(),
        phoneVerificationState: DataState.idle(),
        isGuestMode: false,
        verificationId: '',
        phoneNumber: '',
        lastError: null,
      );
}
