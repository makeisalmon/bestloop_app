import 'dart:math';
import 'package:bestloop_app/sound_services/loop_sound_service.dart';
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

  static num waveFunction(animationValue) {
    return sin(animationValue * 2 * pi + animationValue);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFB500B5); // Set the rectangle color
    const rectCount = 28; // Number of rectangles
    final rectWidth = (size.width - 32) / rectCount - 4; // Width of each rectangle
    const baseXOffset = 16.0; // Fixed padding on each side
    const maxRectHeight = 100.0;
    const minRectHeight = 8.0;
    const heightRange = maxRectHeight - minRectHeight;

    for (int i = 0; i < rectCount; i++) {
      final xOffset = baseXOffset + i * (rectWidth + 4); // Position rectangles
      final phaseOffset = i * pi / rectCount; // Phase offset for each rectangle
      final height = minRectHeight +
          heightRange * LoopSoundService.visualAmplitude.value *
              (0.5 + 0.5 * waveFunction(animationValue + phaseOffset)); // Height calculation
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
