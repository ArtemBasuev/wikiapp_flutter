import 'package:wikiapp_flutter/common/network/load_exception.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';

sealed class ArticleListState {
  const ArticleListState({this.query = ''});

  final String query;
}

final class ArticleListLoading extends ArticleListState {
  const ArticleListLoading({super.query});
}

final class ArticleListLoaded extends ArticleListState {
  const ArticleListLoaded(
    this.items, {
    required super.query,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<ArticleModel> items;

  final bool hasMore;

  final bool isLoadingMore;

  final LoadException? loadMoreError;
}

final class ArticleListNotFound extends ArticleListState {
  const ArticleListNotFound({required super.query});
}

final class ArticleListFailure extends ArticleListState {
  const ArticleListFailure({required super.query, required this.error});

  final LoadException error;
}
