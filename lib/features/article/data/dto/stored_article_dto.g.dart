// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoredArticleDto _$StoredArticleDtoFromJson(Map<String, dynamic> json) =>
    StoredArticleDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      extract: json['extract'] as String,
      url: json['url'] as String,
      length: (json['length'] as num).toInt(),
      touchedIso: json['touchedIso'] as String,
      categories:
          (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
      links: (json['links'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$StoredArticleDtoToJson(StoredArticleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'extract': instance.extract,
      'url': instance.url,
      'length': instance.length,
      'touchedIso': instance.touchedIso,
      'categories': instance.categories,
      'links': instance.links,
    };
