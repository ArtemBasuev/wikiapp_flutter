import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/favorites/favorites_cubit.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

/// Звезда в шапке детали: добавить запись в избранное или убрать.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final selected = context.watch<FavoritesCubit>().contains(article.id);
    return IconButton(
      onPressed: () => context.read<FavoritesCubit>().toggle(article),
      tooltip: selected ? l10n.actionRemoveFavorite : l10n.actionAddFavorite,
      icon: Icon(selected ? Icons.star : Icons.star_border),
    );
  }
}
