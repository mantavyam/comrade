import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
class NewsModel with _$NewsModel {
  const factory NewsModel({
    @Default('') String id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String content,
    @Default('') String imageUrl,
    @Default('') String sourceUrl,
    @Default('') String source,
    @Default('') String author,
    @Default(NewsCategory.general) NewsCategory category,
    @Default([]) List<String> tags,
    @Default(false) bool isBookmarked,
    @Default(0) int readTime, // in minutes
    DateTime? publishedAt,
    DateTime? createdAt,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
}

enum NewsCategory {
  general,
  defense,
  politics,
  international,
  economy,
  technology,
  sports,
  editorial,
}

extension NewsCategoryExtension on NewsCategory {
  String get displayName {
    switch (this) {
      case NewsCategory.general:
        return 'General';
      case NewsCategory.defense:
        return 'Defense';
      case NewsCategory.politics:
        return 'Politics';
      case NewsCategory.international:
        return 'International';
      case NewsCategory.economy:
        return 'Economy';
      case NewsCategory.technology:
        return 'Technology';
      case NewsCategory.sports:
        return 'Sports';
      case NewsCategory.editorial:
        return 'Editorial';
    }
  }

  String get icon {
    switch (this) {
      case NewsCategory.general:
        return '📰';
      case NewsCategory.defense:
        return '🛡️';
      case NewsCategory.politics:
        return '🏛️';
      case NewsCategory.international:
        return '🌍';
      case NewsCategory.economy:
        return '💰';
      case NewsCategory.technology:
        return '💻';
      case NewsCategory.sports:
        return '⚽';
      case NewsCategory.editorial:
        return '✍️';
    }
  }
}
