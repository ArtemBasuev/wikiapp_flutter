import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp_flutter/common/settings/settings_storage.dart';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit(this._settings) : super(_settings.locale);

  final SettingsStorage _settings;

  void select(Locale locale) {
    emit(locale);
    _settings.setLocale(locale);
  }
}
