import 'dart:math';
import 'package:flutter/material.dart';

class SineWaveRectangles extends StatefulWidget {
  @override
  _SineWaveRectanglesState createState() => _SineWaveRectanglesState();
}

class _SineWaveRectanglesState extends State<SineWaveRectangles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 16), // Adjust duration for speed of the wave
    )..repeat(); // Loop the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Fixed padding around the edges
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 128),
            painter: SineWavePainter(_controller.value),
          );
        },
      ),
    );
  }
}

class SineWavePainter extends CustomPainter {
  final double animationValue;

  SineWavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue; // Set the rectangle color
    final rectCount = 28; // Number of rectangles
    final rectWidth = (size.width - 32) / rectCount - 4; // Width of each rectangle
    final baseXOffset = 16.0; // Fixed padding on each side
    final maxRectHeight = 128.0;
    final minRectHeight = 16.0;
    final heightRange = maxRectHeight - minRectHeight;

    for (int i = 0; i < rectCount; i++) {
      final xOffset = baseXOffset + i * (rectWidth + 4); // Position rectangles
      final sineOffset = i * pi / rectCount; // Phase offset for each rectangle
      final height = minRectHeight +
          heightRange *
              (0.5 + 0.5 * sin(animationValue * 2 * pi + sineOffset)); // Height calculation
      final rect = Rect.fromCenter(
        center: Offset(xOffset + rectWidth / 2, size.height / 2),
        width: rectWidth,
        height: height,
      );
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
