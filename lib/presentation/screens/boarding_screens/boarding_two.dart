import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_helptk/core/painters/boarding_two_painter.dart';
import 'package:task_helptk/core/providers/active_index_provider.dart';
import 'package:task_helptk/core/utilities/boarding_icons_generator.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_one.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_three.dart';
import '../../../core/consts/app_typography.dart';
import '../../../core/consts/context_extensions.dart';
import '../../../core/painters/boarding_painters.dart';

class SecondBoardingScreen extends HookWidget {
  final bool reverse;
  const SecondBoardingScreen({super.key, this.reverse = false});

  @override
  Widget build(BuildContext context) {
    final isReversed = useState(reverse);
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 200));
    final path = Path();
    final firstIcon = useState<Widget?>(null);
    final secondIcon = useState<Widget?>(null);
    final firstIconAnimation = (isReversed.value
            ? Tween(begin: 2.0, end: 1.0)
            : Tween(begin: 0.0, end: 1.0))
        .animate(animationController);
    final opacity = Tween(begin: 0.0, end: 1.0).animate(animationController);
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
            context.height * 0.05,
            'assets/boarding_files.svg');
        secondIcon.value = getBoardingIcon(path, 0.98, context.width * 0.1,
            context.width * 0.05, context.height * 0.1);
      },
    );
    useEffect(() {
      animationController.addListener(
        () {
          if (animationController.isCompleted) {
            isReversed.value = false;
          }
          if (firstIcon != null) {
            firstIcon.value = getBoardingIcon(
                path,
                firstIconAnimation.value * 0.2,
                context.width * 0.1,
                context.width * 0.05,
                context.height * 0.05,
                'assets/boarding_files.svg');
          }
        },
      );
      if (animationController.isDismissed && firstIcon.value != null) {
        animationController.forward();
      }
    }, [firstIcon.value]);
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
                  height: context.height * 0.35,
                  child: AnimatedBuilder(
                    animation: opacity,
                    builder: (context, child) {
                      return Opacity(
                        opacity: opacity.value,
                        child: child,
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/boarding_two.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: context.height * 0.22,
                      ),
                      Hero(
                        tag: 'oneToTwo',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Step 2',
                                style: AppTypography.semiHeadlineSize(
                                  context,
                                  const Color(0xff272727),
                                ),
                              ),
                              Text(
                                'Order your Services &\nAdd your Brief',
                                style: AppTypography.semiBodySize(
                                  context,
                                  const Color(0xff656565),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: context.height * 0.1,
            width: context.width,
            child: Center(
              child: Consumer(
                builder: (context, ref, child) {
                  final index = ref.watch(activeIndexProvider);
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      ref
                          .read(activeIndexProvider.notifier)
                          .update((state) => 1);
                    },
                  );
                  return AnimatedSmoothIndicator(
                    activeIndex: index,
                    effect: const ExpandingDotsEffect(),
                    count: 3,
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: context.height * 0.05,
            height: context.height * 0.1,
            width: context.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () async {
                        animationController.reverse();
                        await Future.delayed(const Duration(milliseconds: 200));
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const FirstBoardingScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Back',
                        style: AppTypography.bodySize(
                          context,
                          const Color(0xff8696AD),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const ThirdBoardingScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Next',
                        style: AppTypography.bodySize(
                          context,
                          const Color(0xff485F81),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
