import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/network/load_exception.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/domain/i_article_repository.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/detail/article_detail_event.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/detail/article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  ArticleDetailBloc(this._repository) : super(const ArticleDetailLoading()) {
    on<ArticleDetailOpened>(_onLoadRequested);
    on<ArticleDetailRetried>(_onLoadRequested);
  }

  final IArticleRepository _repository;

  Future<void> _onLoadRequested(
      ArticleDetailEvent event,
      Emitter<ArticleDetailState> emit,
      ) async {
    emit(const ArticleDetailLoading());
    try {
      final article = await _repository.getArticle(event.id);
      if (article == null) {
        emit(const ArticleDetailNotFound());
        return;
      }
      final related = await _loadRelated(article.links);
      emit(ArticleDetailLoaded(article, related: related));
    } on LoadException catch (error) {
      emit(ArticleDetailFailure(error));
    }
  }


  Future<List<ArticleModel>> _loadRelated(List<String> titles) async {
    final found = await Future.wait([
      for (final title in titles) _repository.getArticleByTitle(title),
    ]);
    return [
      for (final article in found)
        if (article != null) article,
    ];
  }
}
