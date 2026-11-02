import 'package:wikiapp_flutter/features/article/data/dto/article_dto.dart';

abstract interface class IArticleDataSource {
  Future<List<ArticleDto>> getArticles({String? afterTitle});

  Future<List<ArticleDto>> searchArticles(String query);

  Future<ArticleDto?> getArticle(int id);

  Future<ArticleDto?> getArticleByTitle(String title);
}
