import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'common.dart';

class WaveCounter {
  WaveCounter({@required int initialCounter}) {
    _counter = initialCounter;
  }

  int _counter;

  void incrementCounter() {
    _counter++;
  }

  void decrementCounter() {
    if (_counter > 0) {
      _counter--;
    }
  }

  int getCounter() {
    return _counter;
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: _counter.toDouble()),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.bounceOut,
            builder: (_, double ratio, __) {
              return FractionallySizedBox(
                heightFactor: (ratio / 100).clamp(0, 100).toDouble(),
                alignment: Alignment.bottomCenter,
                child: const _Wave(
                  child: DifferenceMask(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Wave extends StatefulWidget {
  const _Wave({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  __WaveState createState() => __WaveState();
}

class __WaveState extends State<_Wave> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<List<Offset>> waves;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: false);
    waves = controller.drive(_WaveTween(100, 20));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _WaveClipper(waves),
      child: widget.child,
    );
  }
}

class _WaveTween extends Animatable<List<Offset>> {
  _WaveTween(this.count, this.height);

  final int count;
  final double height;
  static const twoPi = math.pi * 2;
  static const waveCount = 3;

  @override
  List<Offset> transform(double t) {
    return List<Offset>.generate(
      count,
      (i) {
        final ratio = i / (count - 1);
        final amplitude = 1 - (0.5 - ratio).abs() * 2;
        return Offset(
          ratio,
          amplitude * height * math.sin(waveCount * (ratio + t) * twoPi) +
              height * amplitude,
        );
      },
      growable: false,
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  _WaveClipper(this.waves) : super(reclip: waves);

  Animation<List<Offset>> waves;

  @override
  Path getClip(Size size) {
    final width = size.width;
    final points = waves.value.map((o) => Offset(o.dx * width, o.dy)).toList();
    return Path()
      ..addPolygon(points, false)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) => false;
}

class DifferenceMask extends StatelessWidget {
  const DifferenceMask({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: DifferencePainter(),
    );
  }
}

class DifferencePainter extends CustomPainter {
  const DifferencePainter() : super();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(DifferencePainter oldDelegate) => false;
}
