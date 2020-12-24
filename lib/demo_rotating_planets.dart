// Credits to https://twitter.com/beesandbombs/status/1329468633723101187?s=20

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'common.dart';

class RotatingPlanetsCounter{
  RotatingPlanetsCounter({List<Color> initialColors, int initialCounter}){
    _counter = initialCounter;
    _colors = initialColors;
  }

  List<Color> _colors;
  int _counter;
  final math.Random _random = math.Random();
  final List<double> _radii = <double>[];

  void incrementCounter() {
    _counter++;
      _radii.add(_random.nextInt(20) + 10.0);
  }
  void decrementCounter() {
    if(_counter>0){
      _counter--;
      _radii.removeLast();
    }
  }
  int getCounter(){
    return _counter;
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < _radii.length; i++)
          Positioned.fill(
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: _radii[i]),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              builder: (_, double radius, __) {
                return _RotatingBubble1(
                  random: _random,
                  radius: radius,
                  color: _colors[i % _colors.length],
                );
              },
            ),
          ),
      ],
    );
  }
}

class _RotatingBubble1 extends StatefulWidget {
  const _RotatingBubble1({
    Key key,
    @required this.random,
    @required this.radius,
    @required this.color,
  }) : super(key: key);

  final math.Random random;
  final double radius;
  final Color color;

  @override
  _RotatingBubble1State createState() => _RotatingBubble1State();
}

class _RotatingBubble1State extends State<_RotatingBubble1>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double dy;
  double margin;
  double radiusFactor;

  @override
  void initState() {
    super.initState();
    final random = widget.random;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    dy = map(random.nextDouble(), 0.3, 0.7);
    margin = map(random.nextDouble(), 0.1, 0.3);
    radiusFactor = random.nextDouble() + 1.5;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RotatingBubble1Painter(
        controller,
        dy,
        widget.radius,
        radiusFactor,
        widget.color,
        margin,
      ),
    );
  }
}

class _RotatingBubble1Painter extends CustomPainter {
  _RotatingBubble1Painter(
    this.animation,
    this.dy,
    this.radius,
    this.radiusFactor,
    this.color,
    this.margin,
  ) : super(repaint: animation);

  final Animation<double> animation;
  final double dy;
  final double radius;
  final double radiusFactor;
  final Color color;
  final double margin;

  @override
  void paint(Canvas canvas, Size size) {
    final curve = Curves.easeInOutSine;

    final t = curve.transform(animation.value);
    final y = size.height * dy;
    final x = lerpDouble(margin, 1 - margin, t) * size.width;
    final center = Offset(x, y);
    final factor = animation.status == AnimationStatus.forward
        ? radiusFactor
        : 1 / radiusFactor;
    final effectiveRadus = RadiusCurve(radius, radius * factor).transform(t);
    final opacity = animation.status == AnimationStatus.forward
        ? 1.0
        : const RadiusCurve(1, 0.3).transform(t);
    canvas.drawCircle(
      center,
      effectiveRadus,
      Paint()
        ..blendMode = BlendMode.hardLight
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 10)
        ..color = color.withOpacity(opacity),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

double map(double x, double minOut, double maxOut) {
  return x * (maxOut - minOut) + minOut;
}

class RadiusCurve extends Animatable<double> {
  const RadiusCurve(this.small, this.big);

  final double small;
  final double big;

  @override
  double transform(double t) {
    if (t <= 0.5) {
      return lerpDouble(small, big, t);
    } else {
      return lerpDouble(big, small, t);
    }
  }
}
