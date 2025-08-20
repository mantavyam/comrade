import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_model.freezed.dart';
part 'quiz_model.g.dart';

@freezed
class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    @Default('') String id,
    @Default('') String question,
    @Default([]) List<String> options,
    @Default(0) int correctAnswer,
    @Default('') String explanation,
  }) = _QuizQuestion;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
}

@freezed
class QuizResult with _$QuizResult {
  const factory QuizResult({
    @Default('') String id,
    @Default(0) int score,
    @Default(0) int totalQuestions,
    @Default(0) int timeTaken, // in seconds
    @Default([]) List<int?> selectedAnswers,
    @Default([]) List<QuizQuestion> questions,
    DateTime? completedAt,
  }) = _QuizResult;

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);
}
