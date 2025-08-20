// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsModelImpl _$$NewsModelImplFromJson(Map<String, dynamic> json) =>
    _$NewsModelImpl(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      content: json['content'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      sourceUrl: json['sourceUrl'] as String? ?? '',
      source: json['source'] as String? ?? '',
      author: json['author'] as String? ?? '',
      category:
          $enumDecodeNullable(_$NewsCategoryEnumMap, json['category']) ??
          NewsCategory.general,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      readTime: (json['readTime'] as num?)?.toInt() ?? 0,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$NewsModelImplToJson(_$NewsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'sourceUrl': instance.sourceUrl,
      'source': instance.source,
      'author': instance.author,
      'category': _$NewsCategoryEnumMap[instance.category]!,
      'tags': instance.tags,
      'isBookmarked': instance.isBookmarked,
      'readTime': instance.readTime,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$NewsCategoryEnumMap = {
  NewsCategory.general: 'general',
  NewsCategory.defense: 'defense',
  NewsCategory.politics: 'politics',
  NewsCategory.international: 'international',
  NewsCategory.economy: 'economy',
  NewsCategory.technology: 'technology',
  NewsCategory.sports: 'sports',
  NewsCategory.editorial: 'editorial',
};
