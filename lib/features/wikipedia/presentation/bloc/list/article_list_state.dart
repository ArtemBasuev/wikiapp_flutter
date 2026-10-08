import 'package:wikiapp_flutter/features/wikipedia/domain/wikipedia_model.dart';


sealed class ArticleListState {
  const ArticleListState();
}


final class ArticleListLoading extends ArticleListState {
  const ArticleListLoading();
}

final class ArticleListLoaded extends ArticleListState {
  const ArticleListLoaded(this.items);

  final List<ArticleModel> items;
}

final class ArticleListNotFound extends ArticleListState {
  const ArticleListNotFound();
}
