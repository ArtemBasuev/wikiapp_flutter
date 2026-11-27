import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wikiapp_flutter/common/platform/export_result.dart';

Future<ExportResult> exportTextFile(String fileName, String content) async {
  final Directory directory;
  try {
    directory =
        await getDownloadsDirectory() ??
        await getApplicationDocumentsDirectory();
  } on MissingPluginException {
    return const NotSupported();
  } on UnsupportedError {
    return const NotSupported();
  }
  try {
    final file = File('${directory.path}${Platform.pathSeparator}$fileName');
    await file.writeAsString(content);
    return SavedTo(file.path);
  } on FileSystemException catch (error) {
    return ExportFailed(error.message);
  }
}
