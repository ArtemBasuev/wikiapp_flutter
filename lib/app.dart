import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/locale/locale_cubit.dart';
import 'package:wikiapp_flutter/common/navigation/app_router.dart';
import 'package:wikiapp_flutter/common/theme/app_theme.dart';
import 'package:wikiapp_flutter/common/theme/theme_cubit.dart';
import 'package:wikiapp_flutter/features/article/data/article_repository.dart';
import 'package:wikiapp_flutter/features/article/domain/i_article_repository.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/list/article_list_cubit.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IArticleRepository>(
          create: (_) => const ArticleRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => LocaleCubit()),
          BlocProvider(
            create: (context) =>
            ArticleListCubit(context.read<IArticleRepository>())..load(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => BlocBuilder<LocaleCubit, Locale?>(
            builder: (context, locale) => MaterialApp.router(
              onGenerateTitle: (context) =>
              AppLocalizations.of(context).appTitle,
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
      ),
    );
  }
}