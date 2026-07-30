import 'package:flutter/material.dart';
import 'package:project_user/services/static/static.dart';

class OnboardingDots extends StatelessWidget {
  final int currentIndex;

  const OnboardingDots({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onBordinglist.length,
        (dotIndex) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),

          height: currentIndex == dotIndex ? 17 : 12,
          width: currentIndex == dotIndex ? 17 : 12,

          decoration: BoxDecoration(
            color: currentIndex == dotIndex
                ? const Color(0xFF4B1A23)
                : const Color(0xFF7C3442),

            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}