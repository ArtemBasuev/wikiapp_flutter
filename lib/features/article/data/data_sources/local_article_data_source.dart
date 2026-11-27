import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wikiapp_flutter/features/article/data/data_sources/i_local_article_data_source.dart';
import 'package:wikiapp_flutter/features/article/data/dto/stored_article_dto.dart';

final class LocalArticleDataSource implements ILocalArticleDataSource {
  LocalArticleDataSource(this._prefs);

  final SharedPreferencesAsync _prefs;

  static const String _favoritesKey = 'favorites';

  static String _pageKey(String? afterTitle) =>
      'page_${afterTitle ?? 'initial'}';

  @override
  Future<List<StoredArticleDto>?> getPage({String? afterTitle}) =>
      _readList(_pageKey(afterTitle));

  @override
  Future<void> savePage({
    String? afterTitle,
    required List<StoredArticleDto> items,
  }) => _writeList(_pageKey(afterTitle), items);

  @override
  Future<List<StoredArticleDto>> getFavorites() async =>
      await _readList(_favoritesKey) ?? [];

  @override
  Future<void> saveFavorites(List<StoredArticleDto> items) =>
      _writeList(_favoritesKey, items);

  Future<List<StoredArticleDto>?> _readList(String key) async {
    final json = await _prefs.getString(key);
    if (json == null) return null;
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return [
        for (final item in list)
          StoredArticleDto.fromJson(item as Map<String, dynamic>),
      ];
    } on Object {
      return null;
    }
  }

  Future<void> _writeList(String key, List<StoredArticleDto> items) => _prefs
      .setString(key, jsonEncode([for (final item in items) item.toJson()]));
}
