import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_helptk/presentation/widgets/boarding/boarding_text.dart';
import '../../widgets/boarding/smooth_indicator.dart';
import 'boarding_two.dart';
import '../../../core/consts/context_extensions.dart';
import '../../../core/painters/boarding_one_painter.dart';
import '../../../core/utilities/boarding_icons_generator.dart';
import '../../widgets/boarding/bottom_row.dart';

class FirstBoardingScreen extends HookWidget {
  final bool reverse;
  const FirstBoardingScreen({super.key, this.reverse = false});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
        duration: const Duration(milliseconds: 200),
        initialValue: reverse ? 1.0 : 0.0);
    final firstIconAnimation =
        Tween<double>(begin: 1.0, end: 2.0).animate(animationController);
    final iconHeightAnimation =
        Tween(begin: 1, end: 1.5).animate(firstIconAnimation);
    final opacity = Tween(begin: 1.0, end: 0.0).animate(animationController);
    final path = Path();
    final firstIcon = useState<Widget?>(null);

    final secondIcon = useState<Widget?>(null);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            while (path.computeMetrics().isEmpty) {
              await Future.delayed(const Duration(milliseconds: 1));
            }
            firstIcon.value = getBoardingIcon(
              path,
              0.15 * firstIconAnimation.value,
              context.width * 0.1,
              context.width * 0.05,
              context.width * 0.05 * iconHeightAnimation.value,
              'assets/boarding_one_devices.svg',
            );
            secondIcon.value = getBoardingIcon(
              path,
              0.9,
              context.width * 0.1,
              context.width * 0.05,
              context.width * 0.1,
              'assets/boarding_files.svg',
            );
          },
        );
        reverse ? animationController.reverse() : null;
        animationController.addListener(
          () {
            if (firstIcon.value != null) {
              firstIcon.value = getBoardingIcon(
                path,
                0.15 * firstIconAnimation.value,
                context.width * 0.1,
                context.width * 0.05,
                context.width * 0.05 * iconHeightAnimation.value,
                'assets/boarding_one_devices.svg',
              );
            }
          },
        );
        return null;
      },
      [],
    );
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
                Align(
                  child: SizedBox(
                    height: 314.h,
                    width: 311.w,
                    child: AnimatedBuilder(
                      animation: opacity,
                      builder: (context, child) {
                        return Opacity(
                          opacity: opacity.value,
                          child: child!,
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/boarding_one.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 66),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: context.height * 0.02,
                      ),
                      const BoardingText(
                        subtitle: 'Browse Services and\nChoose what you need',
                        titleStep: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const MySmoothIndicator(currentIndex: 0),
          BottomBoardingRow(
            firstScreen: true,
            nextFunction: () async {
              animationController.forward();
              await Future.delayed(const Duration(milliseconds: 150));
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const SecondBoardingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
