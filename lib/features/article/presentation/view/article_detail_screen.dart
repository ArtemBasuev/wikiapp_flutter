import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wikiapp_flutter/common/navigation/app_router.dart';
import 'package:wikiapp_flutter/common/widgets/app_scaffold.dart';
import 'package:wikiapp_flutter/common/widgets/theme_toggle_button.dart';
import 'package:wikiapp_flutter/features/article/domain/i_article_repository.dart';
import 'package:wikiapp_flutter/features/article/domain/article_model.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/detail/article_detail_bloc.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/detail/article_detail_event.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/detail/article_detail_state.dart';
import 'package:wikiapp_flutter/features/article/presentation/utils/article_format.dart';
import 'package:wikiapp_flutter/features/article/presentation/view/widgets/category_row.dart';
import 'package:wikiapp_flutter/features/article/presentation/view/widgets/section.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ArticleDetailBloc(context.read<IArticleRepository>())
            ..add(ArticleDetailOpened(id)),
      child: AppScaffold(
        title: AppLocalizations.of(context).detailsTitle,
        actions: const [ThemeToggleButton()],
        body: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
          builder: (context, state) => switch (state) {
            ArticleDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ArticleDetailNotFound() => Center(
              child: Text(AppLocalizations.of(context).articleNotFound),
            ),
            ArticleDetailLoaded(:final article, :final related) =>
              _DetailContent(article: article, related: related),
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.article, required this.related});

  final ArticleModel article;
  final List<ArticleModel> related;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 2000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              Text(article.title, style: theme.textTheme.headlineMedium),
              Text(
                l10n.articleMeta(
                  article.length,
                  article.formatTouched(l10n.localeName),
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              CategoryRow(categories: article.categories),
              Text(article.extract, style: theme.textTheme.bodyLarge),
              if (related.isNotEmpty) Section(title: l10n.linksTitle),
              for (final linked in related)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    linked.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(AppRoutes.detail(linked.id)),
                ),
              Text(
                l10n.articleSource(article.url),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
