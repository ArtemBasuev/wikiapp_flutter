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
);

Map<String, dynamic> _$QueryDtoToJson(QueryDto instance) => <String, dynamic>{
  'pages': instance.pages,
};
