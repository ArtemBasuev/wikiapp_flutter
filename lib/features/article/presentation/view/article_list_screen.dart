import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/widgets/app_scaffold.dart';
import 'package:wikiapp_flutter/common/widgets/locale_toggle_button.dart';
import 'package:wikiapp_flutter/common/widgets/theme_toggle_button.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/list/article_list_cubit.dart';
import 'package:wikiapp_flutter/features/article/presentation/bloc/list/article_list_state.dart';
import 'package:wikiapp_flutter/features/article/presentation/view/widgets/article_card.dart';
import 'package:wikiapp_flutter/features/article/presentation/view/widgets/search_field.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';


class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      actions: const [LocaleToggleButton(), ThemeToggleButton()],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SearchField(
              initialQuery: context.read<ArticleListCubit>().state.query,
              onChanged: context.read<ArticleListCubit>().search,
            ),
          ),
          Expanded(
            child: BlocBuilder<ArticleListCubit, ArticleListState>(
              builder: (context, state) => switch (state) {
                ArticleListLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                ArticleListNotFound() => Center(
                  child: Text(AppLocalizations.of(context).nothingFound),
                ),
                ArticleListLoaded(:final items) => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      ArticleCard(article: items[index]),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
