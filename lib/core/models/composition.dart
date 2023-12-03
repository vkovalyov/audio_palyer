import 'package:flutter/foundation.dart';

class Composition {
  final String name;
  final int seconds;
  final Uint8List bytes;

  Composition({
    required this.bytes,
    required this.name,
    required this.seconds,
  });
}
