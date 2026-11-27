import 'package:wikiapp_flutter/common/platform/file_export.dart';
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

  @override
  Future<ExportResult> export(List<ArticleModel> items) {
    final lines = [
      'id,title,url',
      for (final item in items) '${item.id},"${item.title}",${item.url}',
    ];
    return exportTextFile(_fileName, '${lines.join('\n')}\n');
  }

  static const String _fileName = 'wiki_favorites.csv';
}
