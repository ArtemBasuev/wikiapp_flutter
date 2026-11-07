import 'package:dio/dio.dart';
import 'package:wikiapp_flutter/features/article/data/dto/query_response_dto.dart';

final class ArticleApi {
  const ArticleApi(this._dio);

  final Dio _dio;

  static const String _endpoint = '/api.php';

  static const int pageSize = 20;

  static const int _scanLimit = 200;


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


  Future<QueryResponseDto> getCatalogPage({String? from}) => _get({
    'action': 'query',
    'list': 'allpages',
    'apnamespace': 0,
    'apfilterredir': 'nonredirects',
    'aplimit': _scanLimit,
    if (from != null) 'apfrom': from,
  });


  Future<QueryResponseDto> getArticlesByIds(List<int> ids) => _get({
    ..._common,
    'pageids': ids.join('|'),
    'prop': 'extracts|info|categories',
  });

  Future<QueryResponseDto> searchArticles(String query) => _get({
    ..._common,
    'generator': 'search',
    'gsrsearch': query,
    'gsrlimit': pageSize,
    'prop': 'extracts|info|categories',
  });

  Future<QueryResponseDto> getArticle(int id) => _get({
    ..._common,
    'pageids': id,
    'prop': 'extracts|info|categories|links',
    'plnamespace': 0,
    'pllimit': _linksLimit,
  });

  Future<QueryResponseDto> getArticlesByTitles(List<String> titles) => _get({
    ..._common,
    'titles': titles.join('|'),
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
