import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/i_wikipedia_repository.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/wikipedia_model.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/bloc/list/article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  ArticleListCubit(this._repository) : super(const ArticleListLoading());

  final IWikipediaRepository _repository;
  String _query = '';

  Future<void> load() async {
    final items = await _repository.getArticles();
    if (isClosed) return;
    emit(_stateFor(items));
  }

  Future<void> search(String query) async {
    _query = query;
    final items = await _repository.searchArticles(query);
    if (isClosed || query != _query) return;
    emit(_stateFor(items));
  }

  ArticleListState _stateFor(List<ArticleModel> items) => items.isEmpty
      ? const ArticleListNotFound()
      : ArticleListLoaded(items);
}
