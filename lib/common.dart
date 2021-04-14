import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double map(double x, double minIn, double maxIn, double minOut, double maxOut) {
  return (x - minIn) * (maxOut - minOut) / (maxIn - minIn) + minOut;
}

final Random _random = Random();

double randNextD(double max) => _random.nextDouble() * max;
int randNextI(int max) => _random.nextInt(max);
double randD(double min, double max) => _random.d(min, max);
int randI(int min, int max) => _random.i(min, max);

extension RandomExtension on Random {
  double d(double min, double max) {
    return nextDouble() * (max - min) + min;
  }

  int i(int min, int max) {
    return nextInt(max - min) + min;
  }
}

class Pixels {
  const Pixels({
    required this.byteData,
    required this.width,
    required this.height,
  });

  final ByteData? byteData;
  final int width;
  final int height;

  Color getColorAt(int x, int y) {
    final offset = 4 * (x + y * width);
    final rgba = byteData!.getUint32(offset);
    final a = rgba & 0xFF;
    final rgb = rgba >> 8;
    final argb = (a << 24) + rgb;
    return Color(argb);
  }
}
