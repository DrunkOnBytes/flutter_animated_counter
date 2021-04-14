import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImageBubbleCounter {
  ImageBubbleCounter({required int initialCounter, required String image}) {
    _counter = initialCounter;
    _image = image;
    for (int i = 0; i < _counter!; i++) {
      _bubbles.add(_ImageBubble(
        center: Offset(_random.nextDouble(), _random.nextDouble()),
        radius: (_random.nextInt(50) + 20).toDouble(),
        image: _image,
      ));
    }
  }

  int? _counter;
  String? _image;

  final Random _random = Random();
  final List<_ImageBubble> _bubbles = <_ImageBubble>[];

  void incrementCounter() {
    _counter = _counter! + 1;
    _bubbles.add(_ImageBubble(
      center: Offset(_random.nextDouble(), _random.nextDouble()),
      radius: (_random.nextInt(50) + 20).toDouble(),
      image: _image,
    ));
  }

  void decrementCounter() {
    if (_counter! > 0) {
      _counter = _counter! - 1;
      _bubbles.removeLast();
    }
  }

  int? getCounter() {
    return _counter;
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        ..._bubbles,
      ],
    );
  }
}

class _ImageBubble extends StatefulWidget {
  const _ImageBubble({
    Key? key,
    required this.center,
    required this.radius,
    required this.image,
  }) : super(key: key);

  final Offset center;
  final double radius;
  final String? image;

  @override
  __ImageBubbleState createState() => __ImageBubbleState();
}

class __ImageBubbleState extends State<_ImageBubble>
    with TickerProviderStateMixin {
  late AnimationController centerController;
  late AnimationController radiusController;
  late Animation<Offset> center;
  late Animation<double> radius;

  @override
  void initState() {
    super.initState();
    centerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    center = centerController.drive(RotationTween(widget.center, 0.01));
    radiusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    radius = radiusController
        .drive(CurveTween(curve: Curves.ease))
        .drive(Tween(begin: 0, end: widget.radius));
  }

  @override
  void dispose() {
    centerController.dispose();
    radiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: center,
        builder: (_, child) {
          return CustomPaint(
            painter: _ImageBubbleShadowPainter(center.value, radius.value),
            child: ClipOval(
              clipper: _ImageBubbleClipper(center.value, radius.value),
              clipBehavior: Clip.hardEdge,
              child: CustomPaint(
                  foregroundPainter: _ImageBubblePainter(
                    center.value,
                    radius.value,
                  ),
                  child: child),
            ),
          );
        },
        child: Image.asset(
          widget.image!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class RotationTween extends Animatable<Offset> {
  const RotationTween(this.center, this.distance);

  final Offset center;
  final double distance;

  @override
  Offset transform(double t) {
    final direction = t * pi * 2;
    return Offset.fromDirection(direction, distance) + center;
  }
}

class _ImageBubbleClipper extends CustomClipper<Rect> {
  const _ImageBubbleClipper(this.center, this.radius);

  final Offset center;
  final double radius;

  @override
  Rect getClip(Size size) {
    final effectiveCenter =
        Offset(center.dx * size.width, center.dy * size.height);
    return Rect.fromCircle(center: effectiveCenter, radius: radius);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class _ImageBubbleShadowPainter extends CustomPainter {
  _ImageBubbleShadowPainter(this.center, this.radius);
  final Offset center;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final effectiveCenter =
        Offset(center.dx * size.width, center.dy * size.height);
    final rect = Rect.fromCircle(center: effectiveCenter, radius: radius);

    const boxShadow = BoxShadow(
        blurRadius: 4, offset: Offset(2, 2), color: Color(0x80000000));
    final Paint paint = boxShadow.toPaint();
    final Rect bounds =
        rect.shift(boxShadow.offset).inflate(boxShadow.spreadRadius);

    canvas.drawCircle(
      bounds.center,
      bounds.shortestSide / 2.0,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _ImageBubblePainter extends CustomPainter {
  _ImageBubblePainter(this.center, this.radius);
  final Offset center;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final effectiveCenter =
        Offset(center.dx * size.width, center.dy * size.height);
    final rect = Rect.fromCircle(center: effectiveCenter, radius: radius);

    canvas.drawCircle(
      effectiveCenter,
      radius,
      Paint()
        ..blendMode = BlendMode.overlay
        ..shader = const LinearGradient(colors: [Colors.black, Colors.white])
            .createShader(rect),
    );
    canvas.drawCircle(
      rect.topLeft + (rect.center - rect.topLeft) / 2,
      rect.longestSide / 6,
      Paint()
        ..color = const Color(0xCCFFFFFF)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          rect.longestSide * 0.1,
        ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
