import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/locale/locale_cubit.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

class LocaleToggleButton extends StatelessWidget {
  const LocaleToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isRussian = Localizations.localeOf(context).languageCode == 'ru';
    return IconButton(
      onPressed: () => context.read<LocaleCubit>().select(
        Locale(isRussian ? 'en' : 'ru'),
      ),
      tooltip: AppLocalizations.of(context).actionToggleLanguage,
      icon: const Icon(Icons.translate),
    );
  }
}
