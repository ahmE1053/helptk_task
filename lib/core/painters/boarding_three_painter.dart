import 'package:flutter/material.dart';

class ThirdBoardingPainter extends CustomPainter {
  final Path path;
  ThirdBoardingPainter(this.path);
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
        size.width * 0.5,
        startHeight + size.height * 0.15,
      );

    path.cubicTo(
      size.width * 0.65,
      startHeight + size.height * 0.3,
      size.width * 0.75,
      startHeight + size.height * 0.17,
      size.width * 0.9,
      startHeight + size.height * 0.1,
    );
    canvas.drawPath(
      path,
      linePaint,
    );
    canvas.drawCircle(
      Offset(
        size.width * 0.9,
        startHeight + size.height * 0.1,
      ),
      15,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
