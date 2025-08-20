import 'package:freezed_annotation/freezed_annotation.dart';

part 'editorial_model.freezed.dart';
part 'editorial_model.g.dart';

enum EditorialCategory {
  opinion,
  analysis,
  commentary,
  perspective,
  editorial,
}

@freezed
class EditorialModel with _$EditorialModel {
  const factory EditorialModel({
    required String id,
    required String title,
    required String description,
    required String content,
    required String author,
    required String publication,
    required EditorialCategory category,
    required DateTime publishedAt,
    @Default('') String imageUrl,
    @Default([]) List<String> tags,
    @Default(5) int readTime, // in minutes
    @Default(false) bool isBookmarked,
    @Default(false) bool isFeatured,
  }) = _EditorialModel;

  factory EditorialModel.fromJson(Map<String, dynamic> json) =>
      _$EditorialModelFromJson(json);
}
