import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_helptk/core/consts/context_extensions.dart';

class BottomBoardingRow extends StatelessWidget {
  const BottomBoardingRow({
    super.key,
    this.firstScreen = false,
    this.backFunction,
    this.lastScreen = false,
    required this.nextFunction,
  });
  final bool firstScreen, lastScreen;
  final void Function()? backFunction;
  final void Function() nextFunction;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: context.height * 0.05,
      width: context.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: backFunction,
                child: Text(
                  firstScreen ? 'Skip Tour' : 'Back',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF8696AD),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.33,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: nextFunction,
                child: Text(
                  lastScreen ? 'Get Started' : 'Next',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF485F80),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.33,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
