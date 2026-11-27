import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/widgets/app_scaffold.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/favorites/favorites_cubit.dart';
import 'package:wikiapp_flutter/features/article/presentation/view/widgets/article_card.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<FavoritesCubit, List<ArticleModel>>(
      builder: (context, items) => AppScaffold(
        body: items.isEmpty
            ? Center(child: Text(l10n.favoritesEmpty))
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    ArticleCard(article: items[index]),
              ),
      ),
    );
  }
}
