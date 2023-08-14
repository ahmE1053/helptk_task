import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_helptk/core/providers/active_index_provider.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_two.dart';
import '../../../core/consts/app_typography.dart';
import '../../../core/consts/context_extensions.dart';
import '../../../core/painters/boarding_painters.dart';

class FirstBoardingScreen extends HookWidget {
  const FirstBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final path = Path();
    final firstIcon = useState<Widget?>(null);
    final secondIcon = useState<Widget?>(null);
    final animationController = useAnimationController();
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          while (path.computeMetrics().isEmpty) {
            await Future.delayed(const Duration(milliseconds: 1));
          }
          firstIcon.value = Positioned(
            top: calculate(path, 0.15).dy - context.width * 0.05,
            left: calculate(path, 0.15).dx - context.width * 0.05,
            child: CircleAvatar(
              radius: context.width * 0.1,
              backgroundColor: Color(0xffD3D6DF),
              child: SvgPicture.asset(
                'assets/boarding_one_devices.svg',
              ),
            ),
          );
          secondIcon.value = Positioned(
            top: calculate(path, 0.9).dy - context.width * 0.05,
            left: calculate(path, 0.9).dx - context.width * 0.05,
            child: CircleAvatar(
              radius: context.width * 0.1,
              backgroundColor: Color(0xffD3D6DF),
              child: SvgPicture.asset(
                'assets/boarding_files.svg',
              ),
            ),
          );
        },
      );
    }, [path]);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: FirstBoardingPainter(path),
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
                  child: SvgPicture.asset(
                    'assets/boarding_one.svg',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.width * 0.15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: context.height * 0.02,
                      ),
                      Hero(
                        tag: 'oneToTwo',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Step 1',
                                style: AppTypography.semiHeadlineSize(
                                  context,
                                  const Color(0xff272727),
                                ),
                              ),
                              Text(
                                'Browse Services and\nChoose what you need',
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
                          .update((state) => 0);
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
            width: context.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Skip Tour',
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
                                const SecondBoardingScreen(),
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

  Offset calculate(Path path, double value) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value)!;
    return pos.position;
  }
}
