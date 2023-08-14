import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../consts/context_extensions.dart';

import 'boarding_offset_calculator.dart';

Widget getBoardingIcon(
    Path path, double value, double radius, double width, double height,
    [String? imagePath]) {
  return Positioned(
    top: calculate(path, value).dy - height,
    left: calculate(path, value).dx - width,
    child: CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xffD3D6DF),
      child: imagePath == null
          ? null
          : SvgPicture.asset(
              imagePath,
            ),
    ),
  );
}
