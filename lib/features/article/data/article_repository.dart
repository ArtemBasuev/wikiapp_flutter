import 'package:wikiapp_flutter/common/network/load_exception.dart';
import 'package:wikiapp_flutter/features/article/data/data_sources/i_article_data_source.dart';
import 'package:wikiapp_flutter/features/article/data/data_sources/i_local_article_data_source.dart';
import 'package:wikiapp_flutter/features/article/data/mappers/article_mapper.dart';
import 'package:wikiapp_flutter/features/article/data/mappers/stored_article_mapper.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/domain/article_page_model.dart';
import 'package:wikiapp_flutter/features/article/domain/i_article_repository.dart';

final class ArticleRepository implements IArticleRepository {
  const ArticleRepository(this._network, this._local);

  final IArticleDataSource _network;
  final ILocalArticleDataSource _local;

  @override
  Future<ArticlePageModel> getArticles({String? afterTitle}) async {
    try {
      final dtos = await _network.getArticles(afterTitle: afterTitle);
      final items = [for (final dto in dtos) dto.toModel()];
      await _local.savePage(
        afterTitle: afterTitle,
        items: [for (final item in items) item.toStored()],
      );
      return ArticlePageModel(items: items, fromCache: false);
    } on LoadException catch (error) {
      if (error is! NoConnectionException && error is! TimeoutLoadException) {
        rethrow;
      }
      final cached = await _local.getPage(afterTitle: afterTitle);
      if (cached == null) rethrow;
      return ArticlePageModel(
        items: [for (final item in cached) item.toModel()],
        fromCache: true,
      );
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    final dtos = await _network.searchArticles(query);
    return [for (final dto in dtos) dto.toModel()];
  }

  @override
  Future<ArticleModel?> getArticle(int id) async {
    try {
      final dto = await _network.getArticle(id);
      return dto?.toModel();
    } on LoadException catch (error) {
      if (error is! NoConnectionException && error is! TimeoutLoadException) {
        rethrow;
      }
      final favorites = await _local.getFavorites();
      for (final fav in favorites) {
        if (fav.id == id) return fav.toModel();
      }
      final page = await _local.getPage();
      if (page != null) {
        for (final item in page) {
          if (item.id == id) return item.toModel();
        }
      }
      rethrow;
    }
  }

  @override
  Future<List<ArticleModel>> getArticlesByTitles(List<String> titles) async {
    final dtos = await _network.getArticlesByTitles(titles);
    return [for (final dto in dtos) dto.toModel()];
  }
}
