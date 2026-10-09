import 'package:flutter/material.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

/// Шапка приложения и место под содержимое экрана. Каждый экран строит свой
/// AppScaffold.
///
/// [title] по умолчанию название приложения. Экран может подставить своё.
///
/// В [actions] кладут кнопки для правого угла шапки. Стрелку «назад» рисовать
/// не нужно: AppBar сам покажет её, когда под экраном в стеке есть другой.
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