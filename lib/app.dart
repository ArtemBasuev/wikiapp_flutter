import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/navigation/app_router.dart';
import 'package:wikiapp_flutter/common/theme/app_theme.dart';
import 'package:wikiapp_flutter/common/theme/theme_cubit.dart';
import 'package:wikiapp_flutter/features/wikipedia/data/wikipedia_repository.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/i_wikipedia_repository.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/bloc/list/article_list_cubit.dart';
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
          // Cubit списка создаётся один раз и живёт, пока работает
          // приложение. Экраны находят его через context.
          BlocProvider(
            create: (context) =>
            ArticleListCubit(context.read<IWikipediaRepository>())..load(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp.router(
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRouter.router,
          ),
        ),
      ),
    );
  }
}