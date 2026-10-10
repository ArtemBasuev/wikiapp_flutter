import 'package:wikiapp_flutter/features/article/domain/article_model.dart';

sealed class ArticleListState {
  const ArticleListState({this.query = ''});

  final String query;
}

final class ArticleListLoading extends ArticleListState {
  const ArticleListLoading();
}

final class ArticleListLoaded extends ArticleListState {
  const ArticleListLoaded(this.items, {required super.query});

  final List<ArticleModel> items;
}

final class ArticleListNotFound extends ArticleListState {
  const ArticleListNotFound({required super.query});
}
