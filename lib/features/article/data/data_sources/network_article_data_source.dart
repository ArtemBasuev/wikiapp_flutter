import 'package:dio/dio.dart';
import 'package:wikiapp_flutter/common/network/load_exception.dart';
import 'package:wikiapp_flutter/features/article/data/api/article_api.dart';
import 'package:wikiapp_flutter/features/article/data/data_sources/i_article_data_source.dart';
import 'package:wikiapp_flutter/features/article/data/dto/article_dto.dart';
import 'package:wikiapp_flutter/features/article/data/dto/query_response_dto.dart';

final class NetworkArticleDataSource implements IArticleDataSource {
  const NetworkArticleDataSource(this._api);

  final ArticleApi _api;

  @override
  Future<List<ArticleDto>> getArticles({String? afterTitle}) =>
      _guard(() async {
        final refs = _refs(await _api.getCatalogPage(from: afterTitle));
        final ids = [
          for (final ref in refs)
            if (ref.title != afterTitle) ref.pageId,
        ].take(ArticleApi.pageSize).toList();
        if (ids.isEmpty) return const <ArticleDto>[];
        final byId = {
          for (final article in _articles(await _api.getArticlesByIds(ids)))
            article.pageId: article,
        };
        return [for (final id in ids) ?byId[id]];
      });

  @override
  Future<List<ArticleDto>> searchArticles(String query) async {
    final articles = await _guard(
          () async => _articles(await _api.searchArticles(query.trim())),
    );
    return [...articles]..sort((a, b) => (a.index ?? 0).compareTo(b.index ?? 0));
  }

  @override
  Future<ArticleDto?> getArticle(int id) async {
    final articles = await _guard(
          () async => _articles(await _api.getArticle(id)),
    );
    return articles.firstOrNull;
  }

  @override
  Future<List<ArticleDto>> getArticlesByTitles(List<String> titles) {
    if (titles.isEmpty) return Future.value(const <ArticleDto>[]);
    return _guard(
          () async => _articles(await _api.getArticlesByTitles(titles)),
    );
  }

  List<ArticleDto> _articles(QueryResponseDto response) {
    if (response.error != null) throw const ServerException(null);
    return [
      for (final article in response.query?.pages ?? const <ArticleDto>[])
        if (article.missing != true) article,
    ];
  }

  List<PageRefDto> _refs(QueryResponseDto response) {
    if (response.error != null) throw const ServerException(null);
    return response.query?.allpages ?? const <PageRefDto>[];
  }

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _fromDio(error);
    } on TypeError {
      throw const BadResponseException();
    } on FormatException {
      throw const BadResponseException();
    }
  }

  LoadException _fromDio(DioException error) => switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const TimeoutLoadException(),
    DioExceptionType.badResponse => ServerException(
      error.response?.statusCode,
    ),
    DioExceptionType.unknown when error.error is FormatException =>
    const BadResponseException(),
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate ||
    DioExceptionType.cancel ||
    DioExceptionType.unknown => const NoConnectionException(),
  };
}
