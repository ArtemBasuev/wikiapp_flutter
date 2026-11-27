import 'package:flutter/material.dart';
import 'package:wikiapp_flutter/common/layout/breakpoints.dart';
import 'package:wikiapp_flutter/features/article/presentation/view/article_list_screen.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

class ArticleHomeScreen extends StatelessWidget {
  const ArticleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Breakpoints.isExpanded(context)) return const ArticleListScreen();
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          AppLocalizations.of(context).selectRecordHint,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
