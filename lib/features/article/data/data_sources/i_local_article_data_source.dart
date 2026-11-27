import 'package:wikiapp_flutter/features/article/data/dto/stored_article_dto.dart';

abstract interface class ILocalArticleDataSource {
  Future<List<StoredArticleDto>?> getPage({String? afterTitle});

  Future<void> savePage({
    String? afterTitle,
    required List<StoredArticleDto> items,
  });

  Future<List<StoredArticleDto>> getFavorites();

  Future<void> saveFavorites(List<StoredArticleDto> items);
}
