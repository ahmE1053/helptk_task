import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_helptk/core/painters/boarding_two_painter.dart';
import 'package:task_helptk/core/providers/active_index_provider.dart';
import 'package:task_helptk/core/utilities/boarding_icons_generator.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_one.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_three.dart';
import 'package:task_helptk/presentation/widgets/boarding/boarding_text.dart';
import '../../../core/consts/app_typography.dart';
import '../../../core/consts/context_extensions.dart';
import '../../../core/painters/boarding_painters.dart';
import '../../widgets/boarding/bottom_row.dart';
import '../../widgets/boarding/smooth_indicator.dart';

class SecondBoardingScreen extends HookWidget {
  final bool reverse;
  const SecondBoardingScreen({super.key, this.reverse = false});

  @override
  Widget build(BuildContext context) {
    final isReversed = useState(reverse);
    final animationController = useAnimationController(
        duration: const Duration(milliseconds: 400),
        initialValue: reverse ? 1 : 0);
    final path = Path();
    final firstIcon = useState<Widget?>(null);
    final secondIcon = useState<Widget?>(null);

    final firstIconAnimation =
        Tween<double>(begin: 0.0, end: 2.0).animate(animationController);
    final opacity = Tween(begin: 0.0, end: 2.0).animate(animationController);
    useEffect(
      () {
        if (reverse) {
          animationController.animateTo(0.5);
        } else {
          animationController.animateBack(0.5);
        }
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            while (path.computeMetrics().isEmpty) {
              await Future.delayed(const Duration(milliseconds: 1));
            }
            firstIcon.value = getBoardingIcon(
              path,
              firstIconAnimation.value * 0.2,
              context.width * 0.1,
              context.width * 0.1,
              context.width * 0.05,
              'assets/boarding_files.svg',
            );
            secondIcon.value = getBoardingIcon(path, 0.98, context.width * 0.1,
                context.width * 0.05, context.height * 0.1);
          },
        );
        animationController.addListener(
          () {
            firstIcon.value = getBoardingIcon(
              path,
              firstIconAnimation.value * 0.2,
              context.width * 0.1,
              context.width * 0.1,
              context.width * 0.05,
              'assets/boarding_files.svg',
            );
          },
        );
      },
      [],
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: SecondBoardingPainter(path),
            child: Container(),
          ),
          if (firstIcon.value != null) firstIcon.value!,
          if (secondIcon.value != null) secondIcon.value!,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: context.height * 0.1,
                ),
                SizedBox(
                  height: context.height * 0.4,
                  child: AspectRatio(
                    aspectRatio: 311 / 314,
                    child: AnimatedBuilder(
                      animation: opacity,
                      builder: (context, child) {
                        return Opacity(
                          opacity: opacity.value > 1
                              ? (2 - opacity.value)
                              : opacity.value,
                          child: child,
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/boarding_two.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: context.height * 0.15,
                      ),
                      const BoardingText(
                        subtitle: 'Order your Services &\nAdd your Brief',
                        titleStep: 2,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const MySmoothIndicator(currentIndex: 1),
          BottomBoardingRow(
            firstScreen: false,
            backFunction: () async {
              isReversed.value = false;
              animationController.animateBack(0);
              await Future.delayed(const Duration(milliseconds: 200));
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        const FirstBoardingScreen(reverse: true),
                  ),
                );
              }
            },
            nextFunction: () async {
              animationController.animateTo(1);
              await Future.delayed(const Duration(milliseconds: 200));
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ThirdBoardingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
