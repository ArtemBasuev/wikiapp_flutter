import 'package:flutter/material.dart';
import 'package:wikiapp_flutter/common/theme/image_sources.dart';


class ArticleImage extends StatelessWidget {
  const ArticleImage({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        ImageSources.articlePlaceholder,
        size: size / 2,
        color: scheme.onPrimaryContainer,
      ),
    );
  }
}
