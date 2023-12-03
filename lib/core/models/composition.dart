import 'package:flutter/foundation.dart';

///Композиция - аудио данные музыки
class Composition {
  ///Наименование аудио
  final String name;
  /// Длительность композиции
  final int seconds;
  /// композиция сохраняется как список 8 битных чисел
  final Uint8List bytes;

  Composition({
    required this.bytes,
    required this.name,
    required this.seconds,
  });
}
