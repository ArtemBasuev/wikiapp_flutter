import 'package:wikiapp_flutter/features/article/domain/article_model.dart';

abstract interface class IArticleRepository {
  Future<List<ArticleModel>> getArticles();

  Future<ArticleModel?> getArticle(int id);

  Future<ArticleModel?> getArticleByTitle(String title);

  Future<List<ArticleModel>> searchArticles(String query);
}