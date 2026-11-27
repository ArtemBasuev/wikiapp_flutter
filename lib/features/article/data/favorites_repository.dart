import 'package:wikiapp_flutter/features/article/data/data_sources/i_local_article_data_source.dart';
import 'package:wikiapp_flutter/features/article/data/mappers/stored_article_mapper.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/domain/i_favorites_repository.dart';

final class FavoritesRepository implements IFavoritesRepository {
  const FavoritesRepository(this._local);

  final ILocalArticleDataSource _local;

  @override
  Future<List<ArticleModel>> getAll() async => [
        for (final item in await _local.getFavorites()) item.toModel(),
      ];

  @override
  Future<void> saveAll(List<ArticleModel> items) =>
      _local.saveFavorites([for (final item in items) item.toStored()]);
}
