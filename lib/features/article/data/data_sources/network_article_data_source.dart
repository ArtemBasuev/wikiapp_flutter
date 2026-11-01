import 'package:dio/dio.dart';
import 'package:wikiapp_flutter/common/network/load_exception.dart';
import 'package:wikiapp_flutter/features/article/data/api/article_api.dart';
import 'package:wikiapp_flutter/features/article/data/data_sources/i_article_data_source.dart';
import 'package:wikiapp_flutter/features/article/data/dto/article_dto.dart';
import 'package:wikiapp_flutter/features/article/data/dto/query_response_dto.dart';

final class NetworkArticleDataSource implements IArticleDataSource {
  const NetworkArticleDataSource(this._api);

  final ArticleApi _api;

  static const String _defaultQuery = 'programming language';

  @override
  Future<List<ArticleDto>> searchArticles(String query) async {
    final text = query.trim();
    final articles = await _guard(
      () async => _articles(
        await _api.searchArticles(text.isEmpty ? _defaultQuery : text),
      ),
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
  Future<ArticleDto?> getArticleByTitle(String title) async {
    final articles = await _guard(
      () async => _articles(await _api.getArticleByTitle(title)),
    );
    return articles.firstOrNull;
  }

  List<ArticleDto> _articles(QueryResponseDto response) {
    if (response.error != null) throw const ServerException(null);
    return [
      for (final article in response.query?.pages ?? const <ArticleDto>[])
        if (article.missing != true) article,
    ];
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
