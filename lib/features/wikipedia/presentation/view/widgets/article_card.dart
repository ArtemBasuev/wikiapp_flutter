import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wikiapp_flutter/common/navigation/app_router.dart';
import 'package:wikiapp_flutter/features/wikipedia/domain/wikipedia_model.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/utils/article_format.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/view/widgets/article_image.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/view/widgets/card_surface.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/view/widgets/category_row.dart';

/// Карточка списка: картинка слева, справа название, начало текста и категории.
class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CardSurface(
      onTap: () => context.push(AppRoutes.detail(article.id)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ArticleImage(size: 56),
          const SizedBox(width: 16),
          // Expanded: текстовой колонке достаётся вся оставшаяся ширина.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Text(article.title, style: theme.textTheme.titleMedium),
                Text(
                  article.extract,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                CategoryRow(categories: article.previewCategories),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
