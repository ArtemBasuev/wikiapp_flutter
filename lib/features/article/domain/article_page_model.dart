import 'package:wikiapp_flutter/features/article/domain/article_model.dart';

class ArticlePageModel {
  const ArticlePageModel({
    required this.items,
    required this.fromCache,
  });

  final List<ArticleModel> items;
  final bool fromCache;
}
