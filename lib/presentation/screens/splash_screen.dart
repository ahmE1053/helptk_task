import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_helptk/core/consts/context_extensions.dart';
import 'package:task_helptk/core/painters/lines_painter.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_one.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 2500));
    final secondLineScale = Tween<double>(begin: 1, end: 0.6).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.35),
      ),
    );
    final thirdLineScale = Tween<double>(begin: 0.6, end: 0.3).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.45, 0.6),
      ),
    );
    final thirdLineOffset = Tween<double>(begin: 0, end: 0.05).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.45, 0.6),
      ),
    );
    final bottomContainerOpacity = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.5),
      ),
    );
    final logoOpacity = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 0.8),
      ),
    );
    final bottomImageOpacity = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 0.9),
      ),
    );
    final linesOpacity = Tween<double>(begin: 1, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.65, 0.75),
      ),
    );
    useEffect(
      () {
        animationController.forward();
        Future.delayed(
          const Duration(
            milliseconds: 4000,
          ),
        ).then(
          (_) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const FirstBoardingScreen(),
            ),
          ),
        );
        return null;
      },
      const [],
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: Listenable.merge(
                [linesOpacity, secondLineScale, thirdLineScale]),
            builder: (context, child) {
              return Stack(
                children: [
                  SplashLine(
                    linesOpacity: linesOpacity,
                    child: child!,
                  ),
                  Transform.scale(
                    alignment: Alignment.centerRight,
                    scale: secondLineScale.value,
                    child: SplashLine(
                      linesOpacity: linesOpacity,
                      child: child,
                    ),
                  ),
                  if (secondLineScale.value == 0.6)
                    Transform.translate(
                      offset: Offset(0, context.height * thirdLineOffset.value),
                      child: Transform.scale(
                        alignment: Alignment.centerRight,
                        scale: thirdLineScale.value,
                        child: SplashLine(
                          linesOpacity: linesOpacity,
                          child: child,
                        ),
                      ),
                    ),
                ],
              );
            },
            child: Container(),
          ),
          Positioned(
            bottom: 0,
            width: context.width,
            height: context.height * 0.3,
            child: AnimatedBuilder(
              animation: bottomContainerOpacity,
              builder: (context, child) {
                return Opacity(
                  opacity: bottomContainerOpacity.value,
                  child: child!,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.primaryColor.withOpacity(0.4),
                      Colors.transparent,
                    ],
                    stops: const [0.3, 0.8],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: context.width,
            height: context.height * 0.35,
            child: AnimatedBuilder(
              animation: bottomImageOpacity,
              builder: (context, child) {
                return Opacity(
                  opacity: bottomImageOpacity.value,
                  child: child,
                );
              },
              child: SizedBox(
                height: 500.h,
                width: 577.w,
                child: SvgPicture.asset(
                  'assets/pattern2.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: context.height * 0.25,
            left: context.width * 0.22,
            width: context.width * 0.55,
            height: context.height * 0.25,
            child: AnimatedBuilder(
              animation: logoOpacity,
              builder: (context, child) {
                return Opacity(
                  opacity: logoOpacity.value,
                  child: child,
                );
              },
              child: SvgPicture.asset(
                'assets/logo.svg',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashLine extends StatelessWidget {
  const SplashLine({
    super.key,
    required this.linesOpacity,
    required this.child,
  });

  final Animation<double> linesOpacity;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: true,
      child: Opacity(
        opacity: linesOpacity.value,
        child: CustomPaint(
          painter: LinesPainter(1, 1, 1),
          child: child,
        ),
      ),
    );
  }
}
