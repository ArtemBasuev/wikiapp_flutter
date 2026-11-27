import 'package:flutter/material.dart';
import 'package:wikiapp_flutter/app.dart';
import 'package:wikiapp_flutter/common/settings/settings_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = await SettingsStorage.create();
  runApp(App(settings: settings));
}
