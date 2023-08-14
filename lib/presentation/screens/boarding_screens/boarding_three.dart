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
import '../../../core/consts/app_typography.dart';
import '../../../core/consts/context_extensions.dart';
import '../../../core/painters/boarding_painters.dart';
import '../../../core/painters/boarding_three_painter.dart';

class ThirdBoardingScreen extends HookWidget {
  final bool reverse;
  const ThirdBoardingScreen({super.key, this.reverse = false});

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 200));
    final path = Path();
    final firstIcon = useState<Widget?>(null);
    final firstIconAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    final opacity = Tween(begin: 0.0, end: 1.0).animate(animationController);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        while (path.computeMetrics().isEmpty) {
          await Future.delayed(const Duration(milliseconds: 1));
        }
        firstIcon.value = Positioned(
          top: calculate(path, 0.2 * firstIconAnimation.value).dy -
              context.width * 0.05,
          left: calculate(path, 0.2 * firstIconAnimation.value).dx -
              context.width * 0.05,
          child: CircleAvatar(
            radius: context.width * 0.1,
            backgroundColor: const Color(0xffD3D6DF),
            child: SvgPicture.asset(
              'assets/boarding_call.svg',
            ),
          ),
        );
      },
    );
    useEffect(() {
      animationController.addListener(
        () {
          if (firstIcon != null) {
            firstIcon.value = Positioned(
              top: calculate(path, 0.2 * firstIconAnimation.value).dy -
                  context.width * 0.05,
              left: calculate(path, 0.2 * firstIconAnimation.value).dx -
                  context.width * 0.05,
              child: CircleAvatar(
                radius: context.width * 0.1,
                backgroundColor: const Color(0xffD3D6DF),
                child: SvgPicture.asset(
                  'assets/boarding_call.svg',
                ),
              ),
            );
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
                      'assets/boarding_three.svg',
                      fit: BoxFit.fill,
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
                      Hero(
                        tag: 'oneToTwo',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Step 3',
                                style: AppTypography.semiHeadlineSize(
                                  context,
                                  const Color(0xff272727),
                                ),
                              ),
                              Text(
                                'Contact Us & Follow \nUp Our Process',
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
                          .update((state) => 2);
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
                                const SecondBoardingScreen(reverse: true),
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
                      onPressed: () {},
                      child: Text(
                        'Get Started',
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

  Offset calculate(Path path, double value) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value)!;
    return pos.position;
  }
}
