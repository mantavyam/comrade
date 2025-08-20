import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/service_locator.dart';
import '../../core/utils/data_state.dart';
import '../domain/i_auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthService _authService;

  AuthCubit({
    IAuthService? authService,
  })  : _authService = authService ?? getdep<IAuthService>(),
        super(AuthState.initial()) {
    _initialize();
  }

  void _initialize() {
    // Listen to auth state changes
    _authService.authStateChanges.listen((user) {
      if (user != null) {
        emit(state.copyWith(
          authDataState: DataState.success(user),
          isGuestMode: false,
        ));
      } else {
        emit(state.copyWith(
          authDataState: const DataState.idle(),
          isGuestMode: false,
        ));
      }
    });

    // Check if user is already authenticated
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      emit(state.copyWith(
        authDataState: DataState.success(currentUser),
      ));
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(
      authDataState: const DataState.loading(),
      lastError: null,
    ));

    final result = await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (result.isSuccess) {
      emit(state.copyWith(
        authDataState: DataState.success(result.success),
        lastError: null,
      ));
    } else {
      emit(state.copyWith(
        authDataState: const DataState.error(),
        lastError: result.failure,
      ));
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(state.copyWith(
      authDataState: const DataState.loading(),
      lastError: null,
    ));

    final result = await _authService.signUpWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );

    if (result.isSuccess) {
      emit(state.copyWith(
        authDataState: DataState.success(result.success),
        lastError: null,
      ));
    } else {
      emit(state.copyWith(
        authDataState: const DataState.error(),
        lastError: result.failure,
      ));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(
      authDataState: const DataState.loading(),
      lastError: null,
    ));

    final result = await _authService.signInWithGoogle();

    if (result.isSuccess) {
      emit(state.copyWith(
        authDataState: DataState.success(result.success),
        lastError: null,
      ));
    } else {
      emit(state.copyWith(
        authDataState: const DataState.error(),
        lastError: result.failure,
      ));
    }
  }

  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    emit(state.copyWith(
      phoneVerificationState: const DataState.loading(),
      phoneNumber: phoneNumber,
      lastError: null,
    ));

    final result = await _authService.signInWithPhoneNumber(
      phoneNumber: phoneNumber,
    );

    if (result.isSuccess) {
      emit(state.copyWith(
        phoneVerificationState: DataState.success(result.success),
        verificationId: result.success,
        lastError: null,
      ));
    } else {
      emit(state.copyWith(
        phoneVerificationState: const DataState.error(),
        lastError: result.failure,
      ));
    }
  }

  Future<void> verifyPhoneNumber({
    required String otpCode,
  }) async {
    emit(state.copyWith(
      authDataState: const DataState.loading(),
      lastError: null,
    ));

    final result = await _authService.verifyPhoneNumber(
      verificationId: state.verificationId,
      otpCode: otpCode,
    );

    if (result.isSuccess) {
      emit(state.copyWith(
        authDataState: DataState.success(result.success),
        phoneVerificationState: const DataState.idle(),
        verificationId: '',
        phoneNumber: '',
        lastError: null,
      ));
    } else {
      emit(state.copyWith(
        authDataState: const DataState.error(),
        lastError: result.failure,
      ));
    }
  }

  Future<void> resendOtp() async {
    if (state.phoneNumber.isEmpty) return;

    emit(state.copyWith(
      phoneVerificationState: const DataState.loading(),
      lastError: null,
    ));

    final result = await _authService.resendOtp(
      phoneNumber: state.phoneNumber,
    );

    if (result.isSuccess) {
      emit(state.copyWith(
        phoneVerificationState: DataState.success(result.success),
        verificationId: result.success,
        lastError: null,
      ));
    } else {
      emit(state.copyWith(
        phoneVerificationState: const DataState.error(),
        lastError: result.failure,
      ));
    }
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    emit(state.copyWith(
      authDataState: const DataState.loading(),
      lastError: null,
    ));

    final result = await _authService.sendPasswordResetEmail(email: email);

    if (result.isSuccess) {
      emit(state.copyWith(
        authDataState: const DataState.idle(),
        lastError: null,
      ));
    } else {
      emit(state.copyWith(
        authDataState: const DataState.error(),
        lastError: result.failure,
      ));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(
      authDataState: const DataState.loading(),
      lastError: null,
    ));

    final result = await _authService.signOut();

    if (result.isSuccess) {
      emit(AuthState.initial());
    } else {
      emit(state.copyWith(
        authDataState: const DataState.error(),
        lastError: result.failure,
      ));
    }
  }

  void enterGuestMode() {
    emit(state.copyWith(
      isGuestMode: true,
      authDataState: const DataState.idle(),
    ));
  }

  void clearError() {
    emit(state.copyWith(lastError: null));
  }

  void resetPhoneVerification() {
    emit(state.copyWith(
      phoneVerificationState: const DataState.idle(),
      verificationId: '',
      phoneNumber: '',
    ));
  }
}
