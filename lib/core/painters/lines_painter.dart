import 'package:flutter/material.dart';

class LinesPainter extends CustomPainter {
  final double firstAnimationValue;
  final double secondAnimationValue;
  final double thirdAnimationValue;
  LinesPainter(
    this.firstAnimationValue,
    this.secondAnimationValue,
    this.thirdAnimationValue,
  );
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff0E2E5C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final linePath = Path();
    final secondLinePath = Path();
    final thirdLinePath = Path();
    linePath.moveTo(0, size.height * 0.1);
    linePath.lineTo(size.width * 0.75 * firstAnimationValue, size.height * 0.1);
    if (secondAnimationValue > 0) {
      linePath.lineTo(
        size.width * 0.75 + (size.width * 0.75 * secondAnimationValue),
        size.height * 0.1 + (size.height * 0.7 * secondAnimationValue),
      );
    }
    if (thirdAnimationValue > 0) {
      linePath.lineTo(
        size.width * 1.5 - (size.width * 0.75 * thirdAnimationValue),
        size.height * 0.8 + (size.height * 0.7 * thirdAnimationValue),
      );
    }
    canvas.drawPath(linePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
