// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  DataState<UserModel> get authDataState => throw _privateConstructorUsedError;
  DataState<String> get phoneVerificationState =>
      throw _privateConstructorUsedError;
  bool get isGuestMode => throw _privateConstructorUsedError;
  String get verificationId => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  AuthError? get lastError => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({
    DataState<UserModel> authDataState,
    DataState<String> phoneVerificationState,
    bool isGuestMode,
    String verificationId,
    String phoneNumber,
    AuthError? lastError,
  });

  $DataStateCopyWith<UserModel, $Res> get authDataState;
  $DataStateCopyWith<String, $Res> get phoneVerificationState;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authDataState = null,
    Object? phoneVerificationState = null,
    Object? isGuestMode = null,
    Object? verificationId = null,
    Object? phoneNumber = null,
    Object? lastError = freezed,
  }) {
    return _then(
      _value.copyWith(
            authDataState: null == authDataState
                ? _value.authDataState
                : authDataState // ignore: cast_nullable_to_non_nullable
                      as DataState<UserModel>,
            phoneVerificationState: null == phoneVerificationState
                ? _value.phoneVerificationState
                : phoneVerificationState // ignore: cast_nullable_to_non_nullable
                      as DataState<String>,
            isGuestMode: null == isGuestMode
                ? _value.isGuestMode
                : isGuestMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            verificationId: null == verificationId
                ? _value.verificationId
                : verificationId // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            lastError: freezed == lastError
                ? _value.lastError
                : lastError // ignore: cast_nullable_to_non_nullable
                      as AuthError?,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataStateCopyWith<UserModel, $Res> get authDataState {
    return $DataStateCopyWith<UserModel, $Res>(_value.authDataState, (value) {
      return _then(_value.copyWith(authDataState: value) as $Val);
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataStateCopyWith<String, $Res> get phoneVerificationState {
    return $DataStateCopyWith<String, $Res>(_value.phoneVerificationState, (
      value,
    ) {
      return _then(_value.copyWith(phoneVerificationState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
    _$AuthStateImpl value,
    $Res Function(_$AuthStateImpl) then,
  ) = __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DataState<UserModel> authDataState,
    DataState<String> phoneVerificationState,
    bool isGuestMode,
    String verificationId,
    String phoneNumber,
    AuthError? lastError,
  });

  @override
  $DataStateCopyWith<UserModel, $Res> get authDataState;
  @override
  $DataStateCopyWith<String, $Res> get phoneVerificationState;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
    _$AuthStateImpl _value,
    $Res Function(_$AuthStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authDataState = null,
    Object? phoneVerificationState = null,
    Object? isGuestMode = null,
    Object? verificationId = null,
    Object? phoneNumber = null,
    Object? lastError = freezed,
  }) {
    return _then(
      _$AuthStateImpl(
        authDataState: null == authDataState
            ? _value.authDataState
            : authDataState // ignore: cast_nullable_to_non_nullable
                  as DataState<UserModel>,
        phoneVerificationState: null == phoneVerificationState
            ? _value.phoneVerificationState
            : phoneVerificationState // ignore: cast_nullable_to_non_nullable
                  as DataState<String>,
        isGuestMode: null == isGuestMode
            ? _value.isGuestMode
            : isGuestMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        verificationId: null == verificationId
            ? _value.verificationId
            : verificationId // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        lastError: freezed == lastError
            ? _value.lastError
            : lastError // ignore: cast_nullable_to_non_nullable
                  as AuthError?,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateImpl extends _AuthState {
  const _$AuthStateImpl({
    required this.authDataState,
    required this.phoneVerificationState,
    this.isGuestMode = false,
    this.verificationId = '',
    this.phoneNumber = '',
    this.lastError,
  }) : super._();

  @override
  final DataState<UserModel> authDataState;
  @override
  final DataState<String> phoneVerificationState;
  @override
  @JsonKey()
  final bool isGuestMode;
  @override
  @JsonKey()
  final String verificationId;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  final AuthError? lastError;

  @override
  String toString() {
    return 'AuthState(authDataState: $authDataState, phoneVerificationState: $phoneVerificationState, isGuestMode: $isGuestMode, verificationId: $verificationId, phoneNumber: $phoneNumber, lastError: $lastError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.authDataState, authDataState) ||
                other.authDataState == authDataState) &&
            (identical(other.phoneVerificationState, phoneVerificationState) ||
                other.phoneVerificationState == phoneVerificationState) &&
            (identical(other.isGuestMode, isGuestMode) ||
                other.isGuestMode == isGuestMode) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.lastError, lastError) ||
                other.lastError == lastError));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    authDataState,
    phoneVerificationState,
    isGuestMode,
    verificationId,
    phoneNumber,
    lastError,
  );

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState extends AuthState {
  const factory _AuthState({
    required final DataState<UserModel> authDataState,
    required final DataState<String> phoneVerificationState,
    final bool isGuestMode,
    final String verificationId,
    final String phoneNumber,
    final AuthError? lastError,
  }) = _$AuthStateImpl;
  const _AuthState._() : super._();

  @override
  DataState<UserModel> get authDataState;
  @override
  DataState<String> get phoneVerificationState;
  @override
  bool get isGuestMode;
  @override
  String get verificationId;
  @override
  String get phoneNumber;
  @override
  AuthError? get lastError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
