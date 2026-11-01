import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const Divider(height: 12),
        ],
      ),
    );
  }
}
