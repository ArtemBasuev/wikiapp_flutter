import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/domain/article_page_model.dart';

abstract interface class IArticleRepository {
  Future<ArticlePageModel> getArticles({String? afterTitle});

  Future<List<ArticleModel>> searchArticles(String query);

  Future<ArticleModel?> getArticle(int id);

  Future<List<ArticleModel>> getArticlesByTitles(List<String> titles);
}
