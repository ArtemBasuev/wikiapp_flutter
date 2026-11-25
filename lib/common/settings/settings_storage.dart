import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  SettingsStorage(this._prefs);

  final SharedPreferencesWithCache _prefs;

  static const String _themeModeKey = 'theme_mode';
  static const String _localeKey = 'locale';

  static const Set<String> keys = {_themeModeKey, _localeKey};

  static Future<SettingsStorage> create() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(allowList: keys),
    );
    return SettingsStorage(prefs);
  }

  ThemeMode get themeMode => switch (_prefs.getString(_themeModeKey)) {
        'dark' => ThemeMode.dark,
        'system' => ThemeMode.system,
        _ => ThemeMode.light,
      };

  Future<void> setThemeMode(ThemeMode mode) =>
      _prefs.setString(_themeModeKey, mode.name);

  Locale? get locale {
    final code = _prefs.getString(_localeKey);
    return code == null || code.isEmpty ? null : Locale(code);
  }

  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      await _prefs.remove(_localeKey);
    } else {
      await _prefs.setString(_localeKey, locale.languageCode);
    }
  }
}
