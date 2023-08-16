import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_helptk/core/painters/boarding_two_painter.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_one.dart';
import 'package:task_helptk/presentation/screens/boarding_screens/boarding_two.dart';
import 'package:task_helptk/presentation/screens/splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            colorSchemeSeed: const Color(0xff0E2E5C),
            useMaterial3: true,
          ),
          home: child,
        ),
      ),
      child: const SplashScreen(),
    );
  }
}
