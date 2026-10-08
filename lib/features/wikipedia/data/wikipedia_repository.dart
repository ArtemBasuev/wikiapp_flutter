import 'package:wikiapp_flutter/features/wikipedia/data/mock_wikipedia.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/i_wikipedia_repository.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/wikipedia_model.dart';

final class WikipediaRepository implements IWikipediaRepository {
  const WikipediaRepository();

  @override
  Future<List<ArticleModel>> getArticles() async => mockArticles;

  @override
  Future<ArticleModel?> getArticle(int id) async {
    for (final article in mockArticles) {
      if (article.id == id) return article;
    }
    return null;
  }

  @override
  Future<ArticleModel?> getArticleByTitle(String title) async {
    final needle = title.trim().toLowerCase();
    for (final article in mockArticles) {
      if (article.title.toLowerCase() == needle) return article;
    }
    return null;
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return mockArticles;
    return [
      for (final article in mockArticles)
        if (article.title.toLowerCase().contains(needle)) article,
    ];
  }
}