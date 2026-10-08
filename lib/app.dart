import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/theme/app_theme.dart';
import 'package:wikiapp_flutter/common/theme/image_sources.dart';
import 'package:wikiapp_flutter/common/theme/theme_cubit.dart';
import 'package:wikiapp_flutter/features/wikipedia/data/wikipedia_repository.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/i_wikipedia_repository.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/wikipedia_model.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key, this.locale});

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Тип указан явно: репозиторий ищут по интерфейсу, а не по классу.
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
class _TempHome extends StatelessWidget {
  const _TempHome();

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
      body: FutureBuilder<List<ArticleModel>>(
        future: context.read<IWikipediaRepository>().getArticles(),
        builder: (context, snapshot) {
          final articles = snapshot.data ?? const <ArticleModel>[];
          return ListView(
            children: [
              for (final a in articles)
                ListTile(
                  leading: const Icon(ImageSources.articlePlaceholder),
                  title: Text(a.title),
                  subtitle: Text(
                    l10n.articleMeta(a.length, a.touched.toIso8601String()),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}