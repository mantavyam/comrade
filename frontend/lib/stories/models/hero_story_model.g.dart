// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HeroStoryModelImpl _$$HeroStoryModelImplFromJson(Map<String, dynamic> json) =>
    _$HeroStoryModelImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      shortDescription: json['shortDescription'] as String? ?? '',
      fullStory: json['fullStory'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      dateOfSacrifice: json['dateOfSacrifice'] == null
          ? null
          : DateTime.parse(json['dateOfSacrifice'] as String),
      regiment: json['regiment'] as String? ?? '',
      awards:
          (json['awards'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$HeroStoryModelImplToJson(
  _$HeroStoryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'title': instance.title,
  'shortDescription': instance.shortDescription,
  'fullStory': instance.fullStory,
  'imageUrl': instance.imageUrl,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'dateOfSacrifice': instance.dateOfSacrifice?.toIso8601String(),
  'regiment': instance.regiment,
  'awards': instance.awards,
};
