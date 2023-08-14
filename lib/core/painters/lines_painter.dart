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
    secondLinePath.moveTo(0, size.height * 0.2);
    thirdLinePath.moveTo(0, size.height * 0.5);
    linePath.lineTo(size.width * 0.75 * firstAnimationValue, size.height * 0.1);
    secondLinePath.lineTo(
        size.width * 0.4 * firstAnimationValue, size.height * 0.2);
    if (secondAnimationValue > 0) {
      linePath.lineTo(
        size.width * 0.75 + (size.width * 0.75 * secondAnimationValue),
        size.height * 0.1 + (size.height * 0.7 * secondAnimationValue),
      );
      secondLinePath.lineTo(
        size.width * 0.4 + (size.width * 0.5 * secondAnimationValue),
        size.height * 0.2 + (size.height * 0.6 * secondAnimationValue),
      );
      thirdLinePath.lineTo(
        size.width * 0.3 * secondAnimationValue,
        size.height * 0.5 + (size.height * 0.3 * secondAnimationValue),
      );
    }
    if (thirdAnimationValue > 0) {
      linePath.lineTo(
        size.width * 1.5 - (size.width * 0.75 * thirdAnimationValue),
        size.height * 0.8 + (size.height * 0.7 * thirdAnimationValue),
      );
      secondLinePath.lineTo(
        size.width * 0.9 - (size.width * 0.5 * thirdAnimationValue),
        size.height * 0.8 + (size.height * 0.6 * thirdAnimationValue),
      );
      thirdLinePath.lineTo(
        size.width * 0.3 - (size.width * 0.3 * thirdAnimationValue),
        size.height * 0.8 + (size.height * 0.3 * thirdAnimationValue),
      );
    }
    canvas.drawPath(linePath, paint);
    canvas.drawPath(secondLinePath, paint);
    canvas.drawPath(thirdLinePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
