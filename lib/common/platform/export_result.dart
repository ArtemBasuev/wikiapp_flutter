sealed class ExportResult {
  const ExportResult();
}

final class SavedTo extends ExportResult {
  const SavedTo(this.path);

  final String path;
}

final class Downloaded extends ExportResult {
  const Downloaded();
}

final class NotSupported extends ExportResult {
  const NotSupported();
}

final class ExportFailed extends ExportResult {
  const ExportFailed(this.reason);

  final String reason;
}
