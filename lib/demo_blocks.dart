import 'dart:math';

import 'package:flutter/material.dart';

class BlocksCounter {
  BlocksCounter({@required int initialCounter}) {
    _counter = initialCounter;
    for (int i = 0; i < _counter; i++) {
      final dx = _random.nextInt(_blockCount);
      final dy = (_lastIndices[dx] - 1) % _blockCount;
      _lastIndices[dx] = dy;
      _indices.add(Offset(dx.toDouble(), dy.toDouble()));
    }
  }
  static const _blockCount = 5;
  final Random _random = Random();
  final List<Offset> _indices = <Offset>[];
  final List<int> _lastIndices = List<int>.filled(_blockCount, _blockCount);
  int _counter;

  void incrementCounter() {
    _counter++;
    final dx = _random.nextInt(_blockCount);
    final dy = (_lastIndices[dx] - 1) % _blockCount;
    _lastIndices[dx] = dy;
    _indices.add(Offset(dx.toDouble(), dy.toDouble()));
  }

  void decrementCounter() {
    if (_counter > 0) {
      _counter--;
      _indices.removeLast();
    }
  }

  int getCounter() {
    return _counter;
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final blockSize = Size(
          constraints.maxWidth / _blockCount,
          constraints.maxHeight / _blockCount,
        );
        return Stack(
          children: [
            for (int i = 0; i < _indices.length; i++)
              Positioned.fill(
                child: _Block(
                  blockSize: blockSize,
                  endOffset: Offset(
                    _indices[i].dx * blockSize.width,
                    _indices[i].dy * blockSize.height,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Block extends StatefulWidget {
  const _Block({
    Key key,
    this.blockSize,
    this.endOffset,
  }) : super(key: key);

  final Size blockSize;
  final Offset endOffset;

  @override
  __BlockState createState() => __BlockState();
}

class __BlockState extends State<_Block> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    final endOffset = widget.endOffset;
    final blockHeight = widget.blockSize.height;
    final distance = blockHeight + endOffset.dy;
    final duration = (distance * 2).toInt();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    )..forward();

    offset = controller.drive(
      Tween<Offset>(
        begin: Offset(endOffset.dx, -blockHeight),
        end: endOffset,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BlockPainter(
        offset,
        widget.blockSize,
      ),
    );
  }
}

class _BlockPainter extends CustomPainter {
  _BlockPainter(
    this.offset,
    this.blockSize,
  ) : super(repaint: offset);

  final Animation<Offset> offset;
  final Size blockSize;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      offset.value & blockSize,
      Paint()
        ..color = Colors.white
        ..blendMode = BlendMode.difference,
    );
  }

  @override
  bool shouldRepaint(_BlockPainter oldDelegate) => false;
}
