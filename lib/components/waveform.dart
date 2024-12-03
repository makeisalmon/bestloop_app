import 'dart:math';
import 'package:bestloop_app/sound_services/loop_sound_service.dart';
import 'package:flutter/material.dart';

class SineWaveRectangles extends StatefulWidget {
  final bool isSmall;  // Add this line

  // Modify the constructor to accept isSmall parameter
  const SineWaveRectangles({super.key, this.isSmall = false});

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
            painter: SineWavePainter(_controller.value, isSmall: widget.isSmall),
          );
        },
      ),
    );
  }
}

class SineWavePainter extends CustomPainter {
  final double animationValue;
  final bool isSmall;
  SineWavePainter(this.animationValue, {this.isSmall = false});

  static num waveFunction(animationValue) {
    return sin(animationValue * 2 * pi + animationValue);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFB500B5); // Set the rectangle color
    final rectCount = isSmall ? 14 : 28; // Number of rectangles
    final rectWidth = (size.width - 32) / rectCount - 4; // Width of each rectangle
    final baseXOffset = isSmall? 44 : 16.0; // Fixed padding on each side
    final maxRectHeight = isSmall ? 16 : 100.0;
    final rectPadding = isSmall ? 0 : 4;
    final minRectHeight = isSmall? 2 : 8.0;
    final heightRange = maxRectHeight - minRectHeight;

    for (int i = 0; i < rectCount; i++) {
      final xOffset = baseXOffset + i * (rectWidth + rectPadding); // Position rectangles
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
