import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_helptk/core/painters/boarding_two_painter.dart';
import 'package:task_helptk/core/providers/active_index_provider.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_one.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_two.dart';
import 'package:task_helptk/presentation/widgets/boarding/smooth_indicator.dart';
import '../../../core/consts/app_typography.dart';
import '../../../core/consts/context_extensions.dart';
import '../../../core/painters/boarding_painters.dart';
import '../../../core/painters/boarding_three_painter.dart';
import '../../../core/utilities/boarding_icons_generator.dart';
import '../../../core/utilities/boarding_offset_calculator.dart';
import '../../widgets/boarding/boarding_text.dart';
import '../../widgets/boarding/bottom_row.dart';

class ThirdBoardingScreen extends HookWidget {
  const ThirdBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 200));
    final path = Path();
    final firstIcon = useState<Widget?>(null);
    final firstIconAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    final opacity = Tween(begin: 0.0, end: 1.0).animate(animationController);
    useEffect(
      () {
        animationController.forward();
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            while (path.computeMetrics().isEmpty) {
              await Future.delayed(const Duration(milliseconds: 1));
            }
            firstIcon.value = getBoardingIcon(
                path,
                firstIconAnimation.value * 0.2,
                context.width * 0.1,
                context.width * 0.05,
                context.width * 0.05,
                'assets/boarding_call.svg');
          },
        );
        animationController.addListener(
          () {
            if (firstIcon.value != null) {
              firstIcon.value = getBoardingIcon(
                  path,
                  firstIconAnimation.value * 0.2,
                  context.width * 0.1,
                  context.width * 0.05,
                  context.width * 0.05,
                  'assets/boarding_call.svg');
            }
          },
        );
      },
      const [],
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: ThirdBoardingPainter(path),
            child: Container(),
          ),
          if (firstIcon.value != null) firstIcon.value!,
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
                          opacity: opacity.value,
                          child: child,
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/boarding_three.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.width * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: context.height * 0.07,
                      ),
                      const BoardingText(
                        subtitle: 'Contact Us & Follow \nUp Our Process',
                        titleStep: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const MySmoothIndicator(currentIndex: 2),
          BottomBoardingRow(
            firstScreen: false,
            lastScreen: true,
            backFunction: () async {
              animationController.reverse();
              await Future.delayed(const Duration(milliseconds: 200));
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SecondBoardingScreen(
                      reverse: true,
                    ),
                  ),
                );
              }
            },
            nextFunction: () {},
          ),
        ],
      ),
    );
  }
}
