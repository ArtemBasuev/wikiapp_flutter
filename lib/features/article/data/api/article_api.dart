import 'package:dio/dio.dart';
import 'package:wikiapp_flutter/features/article/data/dto/query_response_dto.dart';

final class ArticleApi {
  const ArticleApi(this._dio);

  final Dio _dio;

  static const String _endpoint = '/api.php';

  static const int _listLimit = 20;

  static const int _linksLimit = 10;

  static const Map<String, Object> _common = {
    'action': 'query',
    'exintro': 1,
    'explaintext': 1,
    'exlimit': 'max',
    'inprop': 'url',
    'cllimit': 'max',
    'clshow': '!hidden',
  };

  Future<QueryResponseDto> searchArticles(String query) => _get({
    ..._common,
    'generator': 'search',
    'gsrsearch': query,
    'gsrlimit': _listLimit,
    'prop': 'extracts|info|categories',
  });

  Future<QueryResponseDto> getArticle(int id) => _get({
    ..._common,
    'pageids': id,
    'prop': 'extracts|info|categories|links',
    'plnamespace': 0,
    'pllimit': _linksLimit,
  });

  Future<QueryResponseDto> getArticleByTitle(String title) => _get({
    ..._common,
    'titles': title,
    'redirects': 1,
    'prop': 'extracts|info|categories',
  });

  Future<QueryResponseDto> _get(Map<String, Object> queryParameters) async {
    final response = await _dio.get<Map<String, dynamic>>(
      _endpoint,
      queryParameters: queryParameters,
    );
    final json =
        response.data ?? (throw const FormatException('Пустой ответ'));
    return QueryResponseDto.fromJson(json);
  }
}
