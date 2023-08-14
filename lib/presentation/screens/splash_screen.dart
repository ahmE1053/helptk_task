import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_helptk/core/consts/context_extensions.dart';
import 'package:task_helptk/core/painters/lines_painter.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_one.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 2000));
    final linesAnimations = List.generate(
      3,
      (index) {
        const interval = 0.6 / 3;
        return Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(index * interval, index * interval + interval),
          ),
        );
      },
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
        curve: const Interval(0.5, 0.8),
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
        curve: const Interval(0.45, 0.55),
      ),
    );
    useEffect(
      () {
        animationController.forward();
        Future.delayed(
          const Duration(
            milliseconds: 3500,
          ),
        ).then(
          (_) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => FirstBoardingScreen(),
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
            animation: linesOpacity,
            builder: (context, child) {
              return Transform.flip(
                flipX: true,
                child: Opacity(
                  opacity: linesOpacity.value,
                  child: CustomPaint(
                    painter: LinesPainter(
                      linesAnimations[0].value ?? 0,
                      linesAnimations[1].value ?? 0,
                      linesAnimations[2].value ?? 0,
                    ),
                    child: child,
                  ),
                ),
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
            height: context.height * 0.4,
            child: AnimatedBuilder(
              animation: bottomImageOpacity,
              builder: (context, child) {
                return Opacity(
                  opacity: bottomImageOpacity.value,
                  child: child,
                );
              },
              child: SvgPicture.asset(
                'assets/splash_asset.svg',
                fit: BoxFit.fill,
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
