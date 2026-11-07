import 'package:wikiapp_flutter/features/article/data/data_sources/i_article_data_source.dart';
import 'package:wikiapp_flutter/features/article/data/mappers/article_mapper.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/domain/i_article_repository.dart';

final class ArticleRepository implements IArticleRepository {
  const ArticleRepository(this._dataSource);

  final IArticleDataSource _dataSource;

  @override
  Future<List<ArticleModel>> getArticles({String? afterTitle}) async {
    final dtos = await _dataSource.getArticles(afterTitle: afterTitle);
    return [for (final dto in dtos) dto.toModel()];
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    final dtos = await _dataSource.searchArticles(query);
    return [for (final dto in dtos) dto.toModel()];
  }

  @override
  Future<ArticleModel?> getArticle(int id) async =>
      (await _dataSource.getArticle(id))?.toModel();

  @override
  Future<List<ArticleModel>> getArticlesByTitles(List<String> titles) async {
    final dtos = await _dataSource.getArticlesByTitles(titles);
    return [for (final dto in dtos) dto.toModel()];
  }
}


