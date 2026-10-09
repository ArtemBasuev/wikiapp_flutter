import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/features/article/domain/i_article_repository.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/detail/article_detail_event.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/detail/article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  ArticleDetailBloc(this._repository) : super(const ArticleDetailLoading()) {
    on<ArticleDetailOpened>(_onOpened);
  }

  final IArticleRepository _repository;

  Future<void> _onOpened(
    ArticleDetailOpened event,
    Emitter<ArticleDetailState> emit,
  ) async {
    final article = await _repository.getArticle(event.id);
    if (article == null) {
      emit(const ArticleDetailNotFound());
      return;
    }
    final related = <ArticleModel>[];
    for (final title in article.links) {
      final linked = await _repository.getArticleByTitle(title);
      if (linked != null) related.add(linked);
    }
    emit(ArticleDetailLoaded(article, related: related));
  }
}
