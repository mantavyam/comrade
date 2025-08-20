// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editorial_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditorialModelImpl _$$EditorialModelImplFromJson(Map<String, dynamic> json) =>
    _$EditorialModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      publication: json['publication'] as String,
      category: $enumDecode(_$EditorialCategoryEnumMap, json['category']),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      imageUrl: json['imageUrl'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      readTime: (json['readTime'] as num?)?.toInt() ?? 5,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );

Map<String, dynamic> _$$EditorialModelImplToJson(
  _$EditorialModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'content': instance.content,
  'author': instance.author,
  'publication': instance.publication,
  'category': _$EditorialCategoryEnumMap[instance.category]!,
  'publishedAt': instance.publishedAt.toIso8601String(),
  'imageUrl': instance.imageUrl,
  'tags': instance.tags,
  'readTime': instance.readTime,
  'isBookmarked': instance.isBookmarked,
  'isFeatured': instance.isFeatured,
};

const _$EditorialCategoryEnumMap = {
  EditorialCategory.opinion: 'opinion',
  EditorialCategory.analysis: 'analysis',
  EditorialCategory.commentary: 'commentary',
  EditorialCategory.perspective: 'perspective',
  EditorialCategory.editorial: 'editorial',
};
