import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_helptk/core/consts/context_extensions.dart';

import '../../../core/consts/app_typography.dart';

class BoardingText extends StatelessWidget {
  const BoardingText({
    super.key,
    required this.subtitle,
    required this.titleStep,
  });
  final int titleStep;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'oneToTwo',
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Step $titleStep',
              style: GoogleFonts.poppins(
                color: const Color(0xFF272727),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 1.50,
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: const Color(0xFF646464),
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                height: 1.71,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
