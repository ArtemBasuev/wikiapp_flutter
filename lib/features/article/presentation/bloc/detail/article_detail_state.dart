import 'package:wikiapp_flutter/features/article/domain/article_model.dart';


sealed class ArticleDetailState {
  const ArticleDetailState();
}

final class ArticleDetailLoading extends ArticleDetailState {
  const ArticleDetailLoading();
}

final class ArticleDetailLoaded extends ArticleDetailState {
  const ArticleDetailLoaded(this.article, {required this.related});

  final ArticleModel article;


  final List<ArticleModel> related;
}


final class ArticleDetailNotFound extends ArticleDetailState {
  const ArticleDetailNotFound();
}
