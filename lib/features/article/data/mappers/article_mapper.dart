import 'package:wikiapp_flutter/common/network/load_exception.dart';
import 'package:wikiapp_flutter/features/article/data/dto/article_dto.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';

extension ArticleDtoMapper on ArticleDto {
  ArticleModel toModel() => ArticleModel(
    id: pageId ?? (throw const BadResponseException()),
    title: title ?? (throw const BadResponseException()),
    extract: extract ?? '',
    url: fullUrl ?? (throw const BadResponseException()),
    length: length ?? (throw const BadResponseException()),
    touched:
        DateTime.tryParse(touched ?? '') ??
        (throw const BadResponseException()),
    categories: [
      for (final category in categories ?? const <CategoryDto>[])
        _withoutPrefix(category.title),
    ],
    links: [for (final link in links ?? const <LinkDto>[]) link.title],
  );
}

String _withoutPrefix(String title) => title.replaceFirst(RegExp('^Category:'), '');
