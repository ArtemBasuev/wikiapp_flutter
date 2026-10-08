import 'package:flutter/material.dart';
import 'package:wikiapp_flutter/features/wikipedia/presentation/view/widgets/category_chip.dart';


class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key, required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final category in categories) CategoryChip(label: category),
      ],
    );
  }
}
