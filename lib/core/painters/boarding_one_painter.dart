import 'package:flutter/material.dart';

class FirstBoardingPainter extends CustomPainter {
  final Path path;
  FirstBoardingPainter(this.path);
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = const Color(0xff4A92A8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Paint circlePaint = Paint()
      ..color = const Color(0xff4A92A8)
      ..style = PaintingStyle.fill;
    final startHeight = size.height * 0.65;
    canvas.drawCircle(
      Offset(
        size.width * 0.1,
        startHeight,
      ),
      10,
      circlePaint,
    );
    path
      ..moveTo(size.width * 0.1, startHeight)
      ..cubicTo(
        size.width * 0.14,
        startHeight + 10,
        size.width * 0.27,
        startHeight + 20,
        size.width * 0.32,
        startHeight + size.height * 0.07,
      );
    path.cubicTo(
      size.width * 0.45,
      startHeight + size.height * 0.2,
      size.width * 0.85,
      startHeight + size.height * 0.15,
      size.width * 0.75,
      startHeight - size.height * 0.05,
    );
    path.cubicTo(
      size.width * 0.75,
      startHeight - size.height * 0.05,
      size.width * 0.7,
      startHeight - size.height * 0.15,
      size.width,
      startHeight - size.height * 0.12,
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
