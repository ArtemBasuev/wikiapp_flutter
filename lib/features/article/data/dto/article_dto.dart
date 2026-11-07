import 'package:json_annotation/json_annotation.dart';

part 'article_dto.g.dart';

@JsonSerializable()
class ArticleDto {
  const ArticleDto({
    required this.title,
    this.pageId,
    this.index,
    this.extract,
    this.fullUrl,
    this.length,
    this.touched,
    this.categories,
    this.links,
    this.missing,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);

  @JsonKey(name: 'pageid')
  final int? pageId;
  final String? title;


  final int? index;

  final String? extract;

  @JsonKey(name: 'fullurl')
  final String? fullUrl;

  final int? length;

  final String? touched;

  final List<CategoryDto>? categories;

  final List<LinkDto>? links;

  final bool? missing;
}

@JsonSerializable()
class CategoryDto {
  const CategoryDto({required this.title});

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  final String title;
}

@JsonSerializable()
class LinkDto {
  const LinkDto({required this.title});

  factory LinkDto.fromJson(Map<String, dynamic> json) =>
      _$LinkDtoFromJson(json);

  final String title;
}
