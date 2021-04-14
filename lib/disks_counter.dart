import 'dart:math';

import 'package:flutter/material.dart';

class DisksCounter {
  DisksCounter(
      {required int initialCounter,
      Color color = Colors.white,
      BlendMode blend = BlendMode.difference}) {
    _counter = initialCounter;
    _color = color;
    _blend = blend;
  }

  final Random _random = Random();
  int? _counter;
  Color? _color;
  BlendMode? _blend;

  void incrementCounter() {
    _counter = _counter! + 1;
  }

  void decrementCounter() {
    if (_counter! > 0) {
      _counter = _counter! - 1;
    }
  }

  int? getCounter() {
    return _counter;
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < _counter!; i++)
          Positioned.fill(
            child: _Disk(
              random: _random,
              color: _color,
              blend: _blend,
            ),
          ),
      ],
    );
  }
}

class _Disk extends StatefulWidget {
  const _Disk({
    Key? key,
    this.color,
    this.blend,
    required this.random,
  }) : super(key: key);

  final Random random;
  final Color? color;
  final BlendMode? blend;

  @override
  __DiskState createState() => __DiskState();
}

class __DiskState extends State<_Disk> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  double? radius;
  CenterTween? centerTween;

  @override
  void initState() {
    super.initState();
    final random = widget.random;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    radius = random.nextDouble() * 50 + 25;

    final candidates = [
      Offset(random.nextDouble(), -0.1),
      Offset(random.nextDouble(), 1.1),
      Offset(-0.1, random.nextDouble()),
      Offset(1.1, random.nextDouble()),
    ];

    final start = candidates.removeAt(random.nextInt(candidates.length));
    final end = candidates.removeAt(random.nextInt(candidates.length));

    centerTween = CenterTween(start, end, random.nextDouble());
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: radius),
      duration: const Duration(seconds: 1),
      curve: Curves.elasticOut,
      builder: (_, double effectiveRadius, __) {
        return CustomPaint(
          painter: _DiskPainter(controller, centerTween, effectiveRadius,
              widget.color, widget.blend),
        );
      },
    );
  }
}

class CenterTween extends Animatable<Offset> {
  const CenterTween(this.begin, this.end, this.shift)
      : translation = begin - end;

  final Offset begin;
  final Offset end;
  final double shift;
  final Offset translation;

  @override
  Offset transform(double t) {
    return begin + (end - begin) * ((t + shift) % 1);
  }
}

class _DiskPainter extends CustomPainter {
  const _DiskPainter(
    this.animation,
    this.centerTween,
    this.radius,
    this.color,
    this.blend,
  ) : super(repaint: animation);

  final Animation<double>? animation;
  final double radius;
  final CenterTween? centerTween;
  final Color? color;
  final BlendMode? blend;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset ratioCenter = centerTween!.evaluate(animation!);
    final center = Offset(
      ratioCenter.dx * size.width,
      ratioCenter.dy * size.height,
    );
    final translation = Offset(
      centerTween!.translation.dx * size.width,
      centerTween!.translation.dy * size.height,
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color!
        ..blendMode = blend!,
    );
    canvas.drawCircle(
      center + translation,
      radius,
      Paint()
        ..color = color!
        ..blendMode = blend!,
    );
  }

  @override
  bool shouldRepaint(_DiskPainter oldDelegate) => oldDelegate.radius != radius;
}
