import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class RotatingBubblesCounter {
  RotatingBubblesCounter(
      {@required List<Color> initialColors,
      @required int initialCounter,
      BlendMode blend = BlendMode.hardLight}) {
    _counter = initialCounter;
    _colors = initialColors;
    _blend = blend;

    for (int i = 0; i < _counter; i++) {
      _radii.add(_random.nextInt(25) + 12.5);
    }
  }

  List<Color> _colors;
  int _counter;
  BlendMode _blend;
  final math.Random _random = math.Random();
  final List<double> _radii = <double>[];

  void incrementCounter() {
    _counter++;
    _radii.add(_random.nextInt(25) + 12.5);
  }

  void decrementCounter() {
    if (_counter > 0) {
      _counter--;
      _radii.removeLast();
    }
  }

  int getCounter() {
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
                return _RotatingBubble(
                  random: _random,
                  radius: radius,
                  color: _colors[i % _colors.length],
                  blend: _blend,
                );
              },
            ),
          ),
      ],
    );
  }
}

class _RotatingBubble extends StatefulWidget {
  const _RotatingBubble({
    Key key,
    @required this.random,
    @required this.radius,
    @required this.color,
    @required this.blend,
  }) : super(key: key);

  final math.Random random;
  final double radius;
  final Color color;
  final BlendMode blend;

  @override
  __RotatingBubbleState createState() => __RotatingBubbleState();
}

class __RotatingBubbleState extends State<_RotatingBubble>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> angle;
  double shift;

  static const double twoPi = math.pi * 2;

  @override
  void initState() {
    super.initState();
    final random = widget.random;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: random.nextInt(1200) + 800),
    )..repeat();
    final startAngle = random.nextDouble() * twoPi;
    final endAngle = startAngle + (twoPi * (random.nextBool() ? 1 : -1));
    angle = controller.drive(Tween(begin: startAngle, end: endAngle));

    shift = random.nextDouble() / 10 + 1;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RotatingBubblePainter(
          angle, shift, widget.radius, widget.color, widget.blend),
    );
  }
}

class _RotatingBubblePainter extends CustomPainter {
  _RotatingBubblePainter(
    this.angle,
    this.shift,
    this.radius,
    this.color,
    this.blend,
  ) : super(repaint: angle);

  final Animation<double> angle;
  final double shift;
  final double radius;
  final Color color;
  final BlendMode blend;

  @override
  void paint(Canvas canvas, Size size) {
    final appCenter = size.center(Offset.zero);
    final bigRadius = size.width / 2.7;
    final center =
        (Offset.fromDirection(angle.value, bigRadius * shift)) + appCenter;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..blendMode = blend
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
