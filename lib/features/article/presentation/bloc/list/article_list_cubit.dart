import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/network/load_exception.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/domain/i_article_repository.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/list/article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  ArticleListCubit(this._repository) : super(const ArticleListLoading());

  final IArticleRepository _repository;

  static const Duration _searchDelay = Duration(milliseconds: 400);

  Timer? _searchTimer;

  String _latestQuery = '';

  Future<void> load() => _load('');

  Future<void> retry() => _load(state.query);

  void search(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(_searchDelay, () => _load(query.trim()));
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! ArticleListLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }
    final loading = ArticleListLoaded(
      current.items,
      query: current.query,
      hasMore: true,
      isFromCache: current.isFromCache,
      isLoadingMore: true,
    );
    emit(loading);
    try {
      final page = await _repository.getArticles(
        afterTitle: current.items.last.title,
      );
      if (isClosed || !identical(state, loading)) return;
      emit(
        ArticleListLoaded(
          [...current.items, ...page.items],
          query: current.query,
          hasMore: page.items.isNotEmpty,
          isFromCache: current.isFromCache || page.fromCache,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed || !identical(state, loading)) return;
      emit(
        ArticleListLoaded(
          current.items,
          query: current.query,
          hasMore: true,
          isFromCache: current.isFromCache,
          loadMoreError: error,
        ),
      );
    }
  }

  Future<void> _load(String query) async {
    _latestQuery = query;
    emit(ArticleListLoading(query: query));
    try {
      if (query.isEmpty) {
        final page = await _repository.getArticles();
        if (isClosed || query != _latestQuery) return;
        emit(_stateFor(page.items, query: query, isFromCache: page.fromCache));
      } else {
        final items = await _repository.searchArticles(query);
        if (isClosed || query != _latestQuery) return;
        emit(_stateFor(items, query: query, isFromCache: false));
      }
    } on LoadException catch (error) {
      if (isClosed || query != _latestQuery) return;
      emit(ArticleListFailure(query: query, error: error));
    }
  }

  ArticleListState _stateFor(
    List<ArticleModel> items, {
    required String query,
    required bool isFromCache,
  }) =>
      items.isEmpty
          ? ArticleListNotFound(query: query)
          : ArticleListLoaded(
              items,
              query: query,
              hasMore: query.isEmpty,
              isFromCache: isFromCache,
            );

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
