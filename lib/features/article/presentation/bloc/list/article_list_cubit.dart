import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/domain/i_article_repository.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/list/article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  ArticleListCubit(this._repository) : super(const ArticleListLoading());

  final IArticleRepository _repository;

  String _latestQuery = '';

  Future<void> load() => search('');

  Future<void> search(String query) async {
    _latestQuery = query;
    final items = await _repository.searchArticles(query);
    if (isClosed || query != _latestQuery) return;
    emit(_stateFor(items, query: query));
  }

  ArticleListState _stateFor(List<ArticleModel> items, {required String query}) =>
      items.isEmpty
          ? ArticleListNotFound(query: query)
          : ArticleListLoaded(items, query: query);
}
