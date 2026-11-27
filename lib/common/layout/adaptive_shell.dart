import 'package:flutter/material.dart';
import 'package:wikiapp_flutter/common/layout/breakpoints.dart';
import 'package:wikiapp_flutter/features/article/presentation/view/article_list_screen.dart';

class AdaptiveShell extends StatelessWidget {
  const AdaptiveShell({super.key, required this.child});

  final Widget child;

  static const double _listWidth = 420;

  @override
  Widget build(BuildContext context) {
    if (!Breakpoints.isExpanded(context)) return child;
    return Row(
      children: [
        const SizedBox(width: _listWidth, child: ArticleListScreen()),
        const VerticalDivider(width: 1),
        Expanded(child: child),
      ],
    );
  }
}
