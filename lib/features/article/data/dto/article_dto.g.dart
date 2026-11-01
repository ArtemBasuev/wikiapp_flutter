// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) => ArticleDto(
  title: json['title'] as String,
  pageId: (json['pageid'] as num?)?.toInt(),
  index: (json['index'] as num?)?.toInt(),
  extract: json['extract'] as String?,
  fullUrl: json['fullurl'] as String?,
  length: (json['length'] as num?)?.toInt(),
  touched: json['touched'] as String?,
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  links: (json['links'] as List<dynamic>?)
      ?.map((e) => LinkDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  missing: json['missing'] as bool?,
);

Map<String, dynamic> _$ArticleDtoToJson(ArticleDto instance) =>
    <String, dynamic>{
      'pageid': instance.pageId,
      'title': instance.title,
      'index': instance.index,
      'extract': instance.extract,
      'fullurl': instance.fullUrl,
      'length': instance.length,
      'touched': instance.touched,
      'categories': instance.categories,
      'links': instance.links,
      'missing': instance.missing,
    };

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) =>
    CategoryDto(title: json['title'] as String);

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{'title': instance.title};

LinkDto _$LinkDtoFromJson(Map<String, dynamic> json) =>
    LinkDto(title: json['title'] as String);

Map<String, dynamic> _$LinkDtoToJson(LinkDto instance) => <String, dynamic>{
  'title': instance.title,
};
