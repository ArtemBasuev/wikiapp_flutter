import 'package:wikiapp_flutter/features/wikipedia/domain/wikipedia_model.dart';

abstract interface class IWikipediaRepository {
  Future<List<ArticleModel>> getArticles();

  Future<ArticleModel?> getArticle(int id);

  Future<ArticleModel?> getArticleByTitle(String title);

  Future<List<ArticleModel>> searchArticles(String query);
}