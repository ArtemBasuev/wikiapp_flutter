import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/theme/app_theme.dart';
import 'package:wikiapp_flutter/common/theme/theme_cubit.dart';
import 'package:wikiapp_flutter/features/wikipedia/data/wikipedia_repository.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/i_wikipedia_repository.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/wikipedia_model.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/view/widgets/article_format.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/view/widgets/article_image.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/view/widgets/card_surface.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/view/widgets/category_chip.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/view/widgets/search_field.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';


class App extends StatelessWidget {
  const App({super.key, this.locale});

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IWikipediaRepository>(
          create: (_) => const WikipediaRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp(
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const _TempHome(),
          ),
        ),
      ),
    );
  }
}

/// ВРЕМЕННО
class _TempHome extends StatefulWidget {
  const _TempHome();

  @override
  State<_TempHome> createState() => _TempHomeState();
}

class _TempHomeState extends State<_TempHome> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: l10n.actionToggleTheme,
            onPressed: () => context.read<ThemeCubit>().toggle(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchField(onChanged: (q) => setState(() => _query = q)),
          ),
          Expanded(
            child: FutureBuilder<List<ArticleModel>>(
              future: context
                  .read<IWikipediaRepository>()
                  .searchArticles(_query),
              builder: (context, snapshot) {
                final articles = snapshot.data;
                if (articles == null) return const SizedBox.shrink();
                if (articles.isEmpty) {
                  return Center(child: Text(l10n.nothingFound));
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: articles.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, i) => _TempCard(articles[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TempCard extends StatelessWidget {
  const _TempCard(this.article);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return CardSurface(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ArticleImage(size: 56),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.title, style: text.titleMedium),
                const SizedBox(height: 4),
                Text(
                  l10n.articleMeta(
                    article.length,
                    article.formatTouched(l10n.localeName),
                  ),
                  style: text.bodySmall,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final c in article.previewCategories)
                      CategoryChip(label: c),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}