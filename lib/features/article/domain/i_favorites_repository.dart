import 'package:wikiapp_flutter/common/platform/export_result.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';

abstract interface class IFavoritesRepository {
  Future<List<ArticleModel>> getAll();

  Future<void> saveAll(List<ArticleModel> items);

  Future<ExportResult> export(List<ArticleModel> items);
}
