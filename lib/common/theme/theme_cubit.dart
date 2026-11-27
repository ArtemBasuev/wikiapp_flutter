import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/settings/settings_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._settings) : super(_settings.themeMode);

  final SettingsStorage _settings;

  void toggle() {
    final next = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(next);
    _settings.setThemeMode(next);
  }
}
