// Сверка ключей между ARB-файлами разных языков.
//
// Если ключ забыт в одном языке, gen_l10n не выдаст ошибку: он подставит
// текст из шаблонного языка и напишет одно предупреждение. Скрипт находит
// такие ключи явно.
//
// Запуск:  dart run tool/check_arb.dart            (папка по умолчанию lib/l10n)
//          dart run tool/check_arb.dart путь/к/arb
// Код возврата 1, если языки разошлись. Сверяются ключи и имена
// плейсхолдеров: «{count}» в одном языке и «{n}» в другом тоже расхождение.

import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  final dir = Directory(args.isEmpty ? 'lib/l10n' : args.first);
  exitCode = checkArb(dir, stdout.writeln) ? 0 : 1;
}

/// Сверяет все `*.arb` в [dir] с шаблонной локалью. Возвращает `true`, если
/// расхождений нет.
bool checkArb(Directory dir, void Function(String line) log) {
  if (!dir.existsSync()) {
    log('нет папки с ARB: ${dir.path}');
    return false;
  }
  final templateName = _templateName(dir);
  final template = File('${dir.path}/$templateName');
  if (!template.existsSync()) {
    log('нет шаблонной локали: ${template.path}');
    return false;
  }
  final base = _messages(template);
  final baseLocale = _locale(templateName);

  final others =
      dir
          .listSync()
          .whereType<File>()
          .where(
            (f) => f.path.endsWith('.arb') && !f.path.endsWith(templateName),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  if (others.isEmpty) {
    log('нет ни одной второй локали — нечего сверять');
    return false;
  }

  var ok = true;
  for (final file in others) {
    final locale = _locale(file.uri.pathSegments.last);
    final other = _messages(file);
    final problems = <String>[
      for (final key in base.keys.where((k) => !other.containsKey(k)))
        '  нет в $locale: $key',
      for (final key in other.keys.where((k) => !base.containsKey(k)))
        '  нет в $baseLocale: $key',
      for (final key in base.keys.where(other.containsKey))
        if (!_sameSet(base[key]!, other[key]!))
          '  $key: плейсхолдеры {${base[key]!.join(', ')}} в $baseLocale, '
              '{${other[key]!.join(', ')}} в $locale',
    ];
    if (problems.isEmpty) {
      log('$locale: 0 расхождений, ключей ${other.length}');
    } else {
      ok = false;
      log('$locale: расхождений ${problems.length}');
      problems.forEach(log);
    }
  }
  return ok;
}

/// Имя шаблона берётся из l10n.yaml, чтобы скрипт и gen_l10n не разошлись.
String _templateName(Directory dir) {
  final yaml = File('${dir.parent.parent.path}/l10n.yaml');
  if (yaml.existsSync()) {
    final match = RegExp(
      r'^template-arb-file:\s*(\S+)',
      multiLine: true,
    ).firstMatch(yaml.readAsStringSync());
    if (match != null) return match.group(1)!;
  }
  return 'app_ru.arb';
}

String _locale(String fileName) =>
    fileName.replaceFirst(RegExp(r'^app_'), '').replaceFirst('.arb', '');

/// Ключ сообщения → имена его плейсхолдеров. Служебные ключи (`@…`) не в счёт.
Map<String, Set<String>> _messages(File file) {
  final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
  return {
    for (final entry in json.entries)
      if (!entry.key.startsWith('@'))
        entry.key: _placeholders(entry.value.toString()),
  };
}

/// Плейсхолдеры верхнего уровня ICU-сообщения: `{count, plural, …}` → count,
/// `#{number}` → number. Текст внутри вариантов plural не разбирается.
Set<String> _placeholders(String message) {
  final names = <String>{};
  var depth = 0;
  for (var i = 0; i < message.length; i++) {
    final char = message[i];
    if (char == '{') {
      if (depth == 0) {
        final match = RegExp(r'\s*(\w+)\s*[,}]').matchAsPrefix(message, i + 1);
        if (match != null) names.add(match.group(1)!);
      }
      depth++;
    } else if (char == '}') {
      depth--;
    }
  }
  return names;
}

bool _sameSet(Set<String> a, Set<String> b) =>
    a.length == b.length && a.containsAll(b);
