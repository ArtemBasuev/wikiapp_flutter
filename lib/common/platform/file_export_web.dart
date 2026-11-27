import 'dart:js_interop';

import 'package:web/web.dart' as web;
import 'package:wikiapp_flutter/common/platform/export_result.dart';

Future<ExportResult> exportTextFile(String fileName, String content) async {
  final blob = web.Blob(
    [content.toJS].toJS,
    web.BlobPropertyBag(type: 'text/csv;charset=utf-8'),
  );
  final url = web.URL.createObjectURL(blob);
  web.HTMLAnchorElement()
    ..href = url
    ..download = fileName
    ..click();
  Future<void>.delayed(
    const Duration(seconds: 1),
    () => web.URL.revokeObjectURL(url),
  );
  return const Downloaded();
}
