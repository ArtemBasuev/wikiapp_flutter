import 'package:wikiapp_flutter/features/article/domain/article_model.dart';

abstract interface class IArticleRepository {
  Future<List<ArticleModel>> getArticles({String? afterTitle});

  Future<List<ArticleModel>> searchArticles(String query);

  Future<ArticleModel?> getArticle(int id);

  Future<ArticleModel?> getArticleByTitle(String title);
}
