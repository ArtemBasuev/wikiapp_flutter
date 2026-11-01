import 'package:flutter/material.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions = const [],
  });

  final Widget body;
  final String? title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? AppLocalizations.of(context).appTitle),
        actions: actions,
      ),
      body: body,
    );
  }
}
