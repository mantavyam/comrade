import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
    @Default(0) int quizzesTaken,
    @Default(0) int minutesPracticed,
    @Default([]) List<bool> weeklyStreak,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String email,
    @Default('') String phoneNumber,
    @Default('') String profileImageUrl,
    @Default(false) bool isEmailVerified,
    @Default(false) bool isPhoneVerified,
    @Default(UserStats()) UserStats stats,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
