import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/domain/i_favorites_repository.dart';

class FavoritesCubit extends Cubit<List<ArticleModel>> {
  FavoritesCubit(this._repository) : super(const []);

  final IFavoritesRepository _repository;

  Future<void> load() async {
    final items = await _repository.getAll();
    if (!isClosed) emit(items);
  }

  bool contains(int id) => state.any((item) => item.id == id);

  Future<void> toggle(ArticleModel article) async {
    final next = contains(article.id)
        ? [
            for (final item in state)
              if (item.id != article.id) item,
          ]
        : [...state, article];
    emit(next);
    await _repository.saveAll(next);
  }
}
