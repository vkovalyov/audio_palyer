import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

/// добавляет 0 для времени, чтобы привести к нужному формату
///
/// 34 => 34
/// 0 => 00
///
String padDateTimeWithZero(String time) {
  if (time.isEmpty) return '';
  return time.length == 1 ? '0$time' : time;
}

/// перевод секунд в формат mm:ss
String formattedTime(int timeInSecond) {
  final int sec = timeInSecond % 60;
  final int min = (timeInSecond / 60).floor();
  final String minute = min.toString().length <= 1 ? '0$min' : '$min';
  final String second = sec.toString().length <= 1 ? '0$sec' : '$sec';
  return '$minute : $second';
}

/// ютил для библиотеки audio_player, представляет байты как
/// удаленый url и воспроизводит аудио
UrlSource urlSourceFromBytes(Uint8List bytes,
    {String mimeType = 'audio/mpeg'}) {
  return UrlSource(Uri.dataFromBytes(bytes, mimeType: mimeType).toString());
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
