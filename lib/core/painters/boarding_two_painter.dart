import 'package:flutter/material.dart';

class SecondBoardingPainter extends CustomPainter {
  final Path path;
  SecondBoardingPainter(this.path);
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = const Color(0xff4A92A8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Paint circlePaint = Paint()
      ..color = const Color(0xff4A92A8)
      ..style = PaintingStyle.fill;
    final startHeight = size.height * 0.55;
    path
      ..moveTo(0, startHeight)
      ..cubicTo(
        size.width * 0.14,
        startHeight - 10,
        size.width * 0.3,
        startHeight - 30,
        size.width * 0.55,
        startHeight + size.height * 0.09,
      );
    path.cubicTo(
      size.width * 0.8,
      startHeight + size.height * 0.2,
      size.width * 0.9,
      startHeight + size.height * 0.17,
      size.width,
      startHeight + size.height * 0.1,
    );
    canvas.drawPath(
      path,
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
