import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_helptk/core/consts/context_extensions.dart';

import '../../../core/providers/active_index_provider.dart';

class MySmoothIndicator extends StatelessWidget {
  const MySmoothIndicator({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                    .update((state) => currentIndex);
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
    );
  }
}
