import 'package:freezed_annotation/freezed_annotation.dart';

part 'hero_story_model.freezed.dart';
part 'hero_story_model.g.dart';

@freezed
class HeroStoryModel with _$HeroStoryModel {
  const factory HeroStoryModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String title,
    @Default('') String shortDescription,
    @Default('') String fullStory,
    @Default('') String imageUrl,
    DateTime? dateOfBirth,
    DateTime? dateOfSacrifice,
    @Default('') String regiment,
    @Default([]) List<String> awards,
  }) = _HeroStoryModel;

  factory HeroStoryModel.fromJson(Map<String, dynamic> json) =>
      _$HeroStoryModelFromJson(json);
}
