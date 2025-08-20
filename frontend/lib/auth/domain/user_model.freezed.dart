// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;
  bool get isEmailVerified => throw _privateConstructorUsedError;
  bool get isPhoneVerified => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get bestStreak => throw _privateConstructorUsedError;
  int get quizzesTaken => throw _privateConstructorUsedError;
  int get minutesPracticed => throw _privateConstructorUsedError;
  List<bool> get weeklyStreak =>
      throw _privateConstructorUsedError; // 7 booleans for each day of week
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    String phoneNumber,
    String profileImageUrl,
    bool isEmailVerified,
    bool isPhoneVerified,
    int currentStreak,
    int bestStreak,
    int quizzesTaken,
    int minutesPracticed,
    List<bool> weeklyStreak,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? profileImageUrl = null,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? quizzesTaken = null,
    Object? minutesPracticed = null,
    Object? weeklyStreak = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            profileImageUrl: null == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isEmailVerified: null == isEmailVerified
                ? _value.isEmailVerified
                : isEmailVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPhoneVerified: null == isPhoneVerified
                ? _value.isPhoneVerified
                : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            bestStreak: null == bestStreak
                ? _value.bestStreak
                : bestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            quizzesTaken: null == quizzesTaken
                ? _value.quizzesTaken
                : quizzesTaken // ignore: cast_nullable_to_non_nullable
                      as int,
            minutesPracticed: null == minutesPracticed
                ? _value.minutesPracticed
                : minutesPracticed // ignore: cast_nullable_to_non_nullable
                      as int,
            weeklyStreak: null == weeklyStreak
                ? _value.weeklyStreak
                : weeklyStreak // ignore: cast_nullable_to_non_nullable
                      as List<bool>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastLoginAt: freezed == lastLoginAt
                ? _value.lastLoginAt
                : lastLoginAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    String phoneNumber,
    String profileImageUrl,
    bool isEmailVerified,
    bool isPhoneVerified,
    int currentStreak,
    int bestStreak,
    int quizzesTaken,
    int minutesPracticed,
    List<bool> weeklyStreak,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? profileImageUrl = null,
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? quizzesTaken = null,
    Object? minutesPracticed = null,
    Object? weeklyStreak = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        profileImageUrl: null == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isEmailVerified: null == isEmailVerified
            ? _value.isEmailVerified
            : isEmailVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPhoneVerified: null == isPhoneVerified
            ? _value.isPhoneVerified
            : isPhoneVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        bestStreak: null == bestStreak
            ? _value.bestStreak
            : bestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        quizzesTaken: null == quizzesTaken
            ? _value.quizzesTaken
            : quizzesTaken // ignore: cast_nullable_to_non_nullable
                  as int,
        minutesPracticed: null == minutesPracticed
            ? _value.minutesPracticed
            : minutesPracticed // ignore: cast_nullable_to_non_nullable
                  as int,
        weeklyStreak: null == weeklyStreak
            ? _value._weeklyStreak
            : weeklyStreak // ignore: cast_nullable_to_non_nullable
                  as List<bool>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastLoginAt: freezed == lastLoginAt
            ? _value.lastLoginAt
            : lastLoginAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.profileImageUrl = '',
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.quizzesTaken = 0,
    this.minutesPracticed = 0,
    final List<bool> weeklyStreak = const [],
    this.createdAt,
    this.lastLoginAt,
  }) : _weeklyStreak = weeklyStreak;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final String profileImageUrl;
  @override
  @JsonKey()
  final bool isEmailVerified;
  @override
  @JsonKey()
  final bool isPhoneVerified;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int bestStreak;
  @override
  @JsonKey()
  final int quizzesTaken;
  @override
  @JsonKey()
  final int minutesPracticed;
  final List<bool> _weeklyStreak;
  @override
  @JsonKey()
  List<bool> get weeklyStreak {
    if (_weeklyStreak is EqualUnmodifiableListView) return _weeklyStreak;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyStreak);
  }

  // 7 booleans for each day of week
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastLoginAt;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, currentStreak: $currentStreak, bestStreak: $bestStreak, quizzesTaken: $quizzesTaken, minutesPracticed: $minutesPracticed, weeklyStreak: $weeklyStreak, createdAt: $createdAt, lastLoginAt: $lastLoginAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak) &&
            (identical(other.quizzesTaken, quizzesTaken) ||
                other.quizzesTaken == quizzesTaken) &&
            (identical(other.minutesPracticed, minutesPracticed) ||
                other.minutesPracticed == minutesPracticed) &&
            const DeepCollectionEquality().equals(
              other._weeklyStreak,
              _weeklyStreak,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    phoneNumber,
    profileImageUrl,
    isEmailVerified,
    isPhoneVerified,
    currentStreak,
    bestStreak,
    quizzesTaken,
    minutesPracticed,
    const DeepCollectionEquality().hash(_weeklyStreak),
    createdAt,
    lastLoginAt,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    final String id,
    final String name,
    final String email,
    final String phoneNumber,
    final String profileImageUrl,
    final bool isEmailVerified,
    final bool isPhoneVerified,
    final int currentStreak,
    final int bestStreak,
    final int quizzesTaken,
    final int minutesPracticed,
    final List<bool> weeklyStreak,
    final DateTime? createdAt,
    final DateTime? lastLoginAt,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get phoneNumber;
  @override
  String get profileImageUrl;
  @override
  bool get isEmailVerified;
  @override
  bool get isPhoneVerified;
  @override
  int get currentStreak;
  @override
  int get bestStreak;
  @override
  int get quizzesTaken;
  @override
  int get minutesPracticed;
  @override
  List<bool> get weeklyStreak; // 7 booleans for each day of week
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastLoginAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
