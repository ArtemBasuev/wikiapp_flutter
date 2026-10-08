import 'package:intl/intl.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/wikipedia_model.dart';

extension ArticleFormat on ArticleModel {

  String formatTouched(String localeName) =>
      DateFormat.yMd(localeName).add_Hm().format(touched);

  List<String> get previewCategories => categories.take(2).toList();
}
