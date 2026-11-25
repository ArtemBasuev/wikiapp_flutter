import 'package:json_annotation/json_annotation.dart';

part 'stored_article_dto.g.dart';

@JsonSerializable(createToJson: true, explicitToJson: true)
class StoredArticleDto {
  const StoredArticleDto({
    required this.id,
    required this.title,
    required this.extract,
    required this.url,
    required this.length,
    required this.touchedIso,
    required this.categories,
    required this.links,
  });

  factory StoredArticleDto.fromJson(Map<String, dynamic> json) =>
      _$StoredArticleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StoredArticleDtoToJson(this);

  final int id;
  final String title;
  final String extract;
  final String url;
  final int length;
  final String touchedIso;
  final List<String> categories;
  final List<String> links;
}
