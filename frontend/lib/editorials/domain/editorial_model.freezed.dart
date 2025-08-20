// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editorial_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EditorialModel _$EditorialModelFromJson(Map<String, dynamic> json) {
  return _EditorialModel.fromJson(json);
}

/// @nodoc
mixin _$EditorialModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get publication => throw _privateConstructorUsedError;
  EditorialCategory get category => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  int get readTime => throw _privateConstructorUsedError; // in minutes
  bool get isBookmarked => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;

  /// Serializes this EditorialModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EditorialModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditorialModelCopyWith<EditorialModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditorialModelCopyWith<$Res> {
  factory $EditorialModelCopyWith(
    EditorialModel value,
    $Res Function(EditorialModel) then,
  ) = _$EditorialModelCopyWithImpl<$Res, EditorialModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String content,
    String author,
    String publication,
    EditorialCategory category,
    DateTime publishedAt,
    String imageUrl,
    List<String> tags,
    int readTime,
    bool isBookmarked,
    bool isFeatured,
  });
}

/// @nodoc
class _$EditorialModelCopyWithImpl<$Res, $Val extends EditorialModel>
    implements $EditorialModelCopyWith<$Res> {
  _$EditorialModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditorialModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? content = null,
    Object? author = null,
    Object? publication = null,
    Object? category = null,
    Object? publishedAt = null,
    Object? imageUrl = null,
    Object? tags = null,
    Object? readTime = null,
    Object? isBookmarked = null,
    Object? isFeatured = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as String,
            publication: null == publication
                ? _value.publication
                : publication // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as EditorialCategory,
            publishedAt: null == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            readTime: null == readTime
                ? _value.readTime
                : readTime // ignore: cast_nullable_to_non_nullable
                      as int,
            isBookmarked: null == isBookmarked
                ? _value.isBookmarked
                : isBookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EditorialModelImplCopyWith<$Res>
    implements $EditorialModelCopyWith<$Res> {
  factory _$$EditorialModelImplCopyWith(
    _$EditorialModelImpl value,
    $Res Function(_$EditorialModelImpl) then,
  ) = __$$EditorialModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String content,
    String author,
    String publication,
    EditorialCategory category,
    DateTime publishedAt,
    String imageUrl,
    List<String> tags,
    int readTime,
    bool isBookmarked,
    bool isFeatured,
  });
}

/// @nodoc
class __$$EditorialModelImplCopyWithImpl<$Res>
    extends _$EditorialModelCopyWithImpl<$Res, _$EditorialModelImpl>
    implements _$$EditorialModelImplCopyWith<$Res> {
  __$$EditorialModelImplCopyWithImpl(
    _$EditorialModelImpl _value,
    $Res Function(_$EditorialModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditorialModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? content = null,
    Object? author = null,
    Object? publication = null,
    Object? category = null,
    Object? publishedAt = null,
    Object? imageUrl = null,
    Object? tags = null,
    Object? readTime = null,
    Object? isBookmarked = null,
    Object? isFeatured = null,
  }) {
    return _then(
      _$EditorialModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as String,
        publication: null == publication
            ? _value.publication
            : publication // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as EditorialCategory,
        publishedAt: null == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        readTime: null == readTime
            ? _value.readTime
            : readTime // ignore: cast_nullable_to_non_nullable
                  as int,
        isBookmarked: null == isBookmarked
            ? _value.isBookmarked
            : isBookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EditorialModelImpl implements _EditorialModel {
  const _$EditorialModelImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    required this.publication,
    required this.category,
    required this.publishedAt,
    this.imageUrl = '',
    final List<String> tags = const [],
    this.readTime = 5,
    this.isBookmarked = false,
    this.isFeatured = false,
  }) : _tags = tags;

  factory _$EditorialModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EditorialModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String content;
  @override
  final String author;
  @override
  final String publication;
  @override
  final EditorialCategory category;
  @override
  final DateTime publishedAt;
  @override
  @JsonKey()
  final String imageUrl;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final int readTime;
  // in minutes
  @override
  @JsonKey()
  final bool isBookmarked;
  @override
  @JsonKey()
  final bool isFeatured;

  @override
  String toString() {
    return 'EditorialModel(id: $id, title: $title, description: $description, content: $content, author: $author, publication: $publication, category: $category, publishedAt: $publishedAt, imageUrl: $imageUrl, tags: $tags, readTime: $readTime, isBookmarked: $isBookmarked, isFeatured: $isFeatured)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditorialModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.publication, publication) ||
                other.publication == publication) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.readTime, readTime) ||
                other.readTime == readTime) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    content,
    author,
    publication,
    category,
    publishedAt,
    imageUrl,
    const DeepCollectionEquality().hash(_tags),
    readTime,
    isBookmarked,
    isFeatured,
  );

  /// Create a copy of EditorialModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditorialModelImplCopyWith<_$EditorialModelImpl> get copyWith =>
      __$$EditorialModelImplCopyWithImpl<_$EditorialModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EditorialModelImplToJson(this);
  }
}

abstract class _EditorialModel implements EditorialModel {
  const factory _EditorialModel({
    required final String id,
    required final String title,
    required final String description,
    required final String content,
    required final String author,
    required final String publication,
    required final EditorialCategory category,
    required final DateTime publishedAt,
    final String imageUrl,
    final List<String> tags,
    final int readTime,
    final bool isBookmarked,
    final bool isFeatured,
  }) = _$EditorialModelImpl;

  factory _EditorialModel.fromJson(Map<String, dynamic> json) =
      _$EditorialModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get content;
  @override
  String get author;
  @override
  String get publication;
  @override
  EditorialCategory get category;
  @override
  DateTime get publishedAt;
  @override
  String get imageUrl;
  @override
  List<String> get tags;
  @override
  int get readTime; // in minutes
  @override
  bool get isBookmarked;
  @override
  bool get isFeatured;

  /// Create a copy of EditorialModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditorialModelImplCopyWith<_$EditorialModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
