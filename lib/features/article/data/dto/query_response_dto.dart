import 'package:json_annotation/json_annotation.dart';
import 'package:wikiapp_flutter/features/article/data/dto/article_dto.dart';

part 'query_response_dto.g.dart';


@JsonSerializable()
class QueryResponseDto {
  const QueryResponseDto({this.query, this.error});

  factory QueryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$QueryResponseDtoFromJson(json);

  final QueryDto? query;


  final Object? error;
}

@JsonSerializable()
class QueryDto {
  const QueryDto({this.pages, this.allpages});

  factory QueryDto.fromJson(Map<String, dynamic> json) =>
      _$QueryDtoFromJson(json);

  final List<ArticleDto>? pages;

  final List<PageRefDto>? allpages;
}

@JsonSerializable()
class PageRefDto {
  const PageRefDto({required this.pageId, required this.title});

  factory PageRefDto.fromJson(Map<String, dynamic> json) =>
      _$PageRefDtoFromJson(json);

  @JsonKey(name: 'pageid')
  final int pageId;
  final String title;
}
