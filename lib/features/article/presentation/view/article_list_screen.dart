import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/widgets/app_scaffold.dart';
import 'package:wikiapp_flutter/common/widgets/load_error_view.dart';
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
    final cubit = context.read<ArticleListCubit>();
    return AppScaffold(
      actions: const [LocaleToggleButton(), ThemeToggleButton()],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SearchField(
              initialQuery: cubit.state.query,
              onChanged: cubit.search,
            ),
          ),
          Expanded(
            child: BlocBuilder<ArticleListCubit, ArticleListState>(
              builder: (context, state) => switch (state) {
                ArticleListLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                ArticleListFailure(:final error) => Center(
                  child: LoadErrorView(error: error, onRetry: cubit.retry),
                ),
                ArticleListNotFound() => Center(
                  child: Text(AppLocalizations.of(context).nothingFound),
                ),
                ArticleListLoaded() => _ArticleList(state: state),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleList extends StatefulWidget {
  const _ArticleList({required this.state});

  final ArticleListLoaded state;

  @override
  State<_ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<_ArticleList> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.extentAfter < 300) {
      context.read<ArticleListCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final showFooter = state.isLoadingMore || state.loadMoreError != null;
    return ListView.separated(
      controller: _controller,
      padding: const EdgeInsets.all(16),
      itemCount: state.items.length + (showFooter ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => index < state.items.length
          ? ArticleCard(article: state.items[index])
          : _Footer(state: state),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.state});

  final ArticleListLoaded state;

  @override
  Widget build(BuildContext context) {
    final error = state.loadMoreError;
    return Center(
      child: error == null
          ? const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      )
          : LoadErrorView(
        error: error,
        onRetry: context.read<ArticleListCubit>().loadMore,
      ),
    );
  }
}
