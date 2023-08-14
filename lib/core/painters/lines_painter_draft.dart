import 'package:flutter/material.dart';

class LinesPainter extends CustomPainter {
  final double firstAnimationValue;
  final double secondAnimationValue;
  final double thirdAnimationValue;
  final double fourthAnimationValue;
  LinesPainter(
    this.firstAnimationValue,
    this.secondAnimationValue,
    this.thirdAnimationValue,
    this.fourthAnimationValue,
  );
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff0E2E5C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    final linePath = Path();

    final halfHeight = size.height * 0.5;
    final firstSectionHeight = halfHeight - (size.height * 0.3);
    final firstSectionWidth = size.width * 0.45;
    final fourthSectionHeight = halfHeight + (size.height * 0.3);

    final halfHeightBetweenFourthAndFirstSection =
        (size.height * 0.5 - size.height * 0.2);

    linePath.moveTo(0, firstSectionHeight);
    linePath.lineTo(
        firstSectionWidth * firstAnimationValue, firstSectionHeight);
    if (secondAnimationValue > 0) {
      linePath.lineTo(
          size.width * 0.45 + (size.width * 0.45 * secondAnimationValue),
          (halfHeightBetweenFourthAndFirstSection * secondAnimationValue) +
              firstSectionHeight);
    }
    if (thirdAnimationValue > 0) {
      linePath.lineTo(
        (size.width * 0.9 - (size.width * 0.45 * thirdAnimationValue)),
        halfHeightBetweenFourthAndFirstSection +
            (size.height * 0.6 - halfHeightBetweenFourthAndFirstSection) *
                thirdAnimationValue +
            size.height * 0.2,
      );
    }
    if (fourthAnimationValue > 0) {
      linePath.lineTo(
          size.width * 0.4 - (size.width * 0.4 * fourthAnimationValue),
          fourthSectionHeight);
    }
    canvas.drawPath(linePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
