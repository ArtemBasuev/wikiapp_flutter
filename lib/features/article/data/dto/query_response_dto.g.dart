// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryResponseDto _$QueryResponseDtoFromJson(Map<String, dynamic> json) =>
    QueryResponseDto(
      query: json['query'] == null
          ? null
          : QueryDto.fromJson(json['query'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$QueryResponseDtoToJson(QueryResponseDto instance) =>
    <String, dynamic>{'query': instance.query, 'error': instance.error};

QueryDto _$QueryDtoFromJson(Map<String, dynamic> json) => QueryDto(
  pages: (json['pages'] as List<dynamic>?)
      ?.map((e) => ArticleDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  allpages: (json['allpages'] as List<dynamic>?)
      ?.map((e) => PageRefDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QueryDtoToJson(QueryDto instance) => <String, dynamic>{
  'pages': instance.pages,
  'allpages': instance.allpages,
};

PageRefDto _$PageRefDtoFromJson(Map<String, dynamic> json) => PageRefDto(
  pageId: (json['pageid'] as num).toInt(),
  title: json['title'] as String,
);

Map<String, dynamic> _$PageRefDtoToJson(PageRefDto instance) =>
    <String, dynamic>{'pageid': instance.pageId, 'title': instance.title};
