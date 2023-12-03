import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

String formattedTime(int timeInSecond) {
  final int sec = timeInSecond % 60;
  final int min = (timeInSecond / 60).floor();
  final String minute = min.toString().length <= 1 ? '0$min' : '$min';
  final String second = sec.toString().length <= 1 ? '0$sec' : '$sec';
  return '$minute : $second';
}

UrlSource urlSourceFromBytes(Uint8List bytes,
    {String mimeType = 'audio/mpeg'}) {
  return UrlSource(Uri.dataFromBytes(bytes, mimeType: mimeType).toString());
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
