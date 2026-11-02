import 'package:wikiapp_flutter/features/article/domain/article_model.dart';

abstract interface class IArticleRepository {
  Future<ArticleModel?> getArticle(int id);

  Future<ArticleModel?> getArticleByTitle(String title);

  Future<List<ArticleModel>> searchArticles(String query);

  Future<List<ArticleModel>> getArticles({required int offset});
}
