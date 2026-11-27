import 'package:wikiapp_flutter/features/article/data/dto/stored_article_dto.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';

extension ArticleModelStoredMapper on ArticleModel {
  StoredArticleDto toStored() => StoredArticleDto(
    id: id,
    title: title,
    extract: extract,
    url: url,
    length: length,
    touchedIso: touched.toIso8601String(),
    categories: categories,
    links: links,
  );
}

extension StoredArticleDtoMapper on StoredArticleDto {
  ArticleModel toModel() => ArticleModel(
    id: id,
    title: title,
    extract: extract,
    url: url,
    length: length,
    touched: DateTime.tryParse(touchedIso) ?? DateTime.now(),
    categories: categories,
    links: links,
  );
}
