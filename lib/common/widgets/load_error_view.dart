import 'package:flutter/material.dart';
import 'package:wikiapp_flutter/common/network/load_exception.dart';
import 'package:wikiapp_flutter/l10n/app_localizations.dart';

class LoadErrorView extends StatelessWidget {
  const LoadErrorView({super.key, required this.error, required this.onRetry});

  final LoadException error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final message = switch (error) {
      NoConnectionException() => l10n.errorNoConnection,
      TimeoutLoadException() => l10n.errorTimeout,
      ServerException(:final statusCode) => l10n.errorServer(
        statusCode?.toString() ?? '?',
      ),
      BadResponseException() => l10n.errorBadResponse,
    };
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Text(message, textAlign: TextAlign.center),
          FilledButton.tonal(onPressed: onRetry, child: Text(l10n.actionRetry)),
        ],
      ),
    );
  }
}
