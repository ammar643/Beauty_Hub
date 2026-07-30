import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_user/widgets/onbording/onboarding_buttons.dart';
import 'package:project_user/widgets/onbording/onboarding_dots.dart';



class OnboardingGlassCard extends StatelessWidget {
  final String title;
  final String body;
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingGlassCard({
    super.key,
    required this.title,
    required this.body,
    required this.currentIndex,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 300,
      left: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 0.3,
            sigmaY: 0.3,
          ),
          child: Container(
            width: 354,
            height: 575,

            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0x82FFFFFF),

              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),

            child: Column(
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF4B1A23),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  body,
                  style: TextStyle(
                    color: const Color(0xFF62313A)
                        .withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                OnboardingDots(
                  currentIndex: currentIndex,
                ),

                const SizedBox(height: 50),

                OnboardingButtons(
                  currentIndex: currentIndex,
                  onNext: onNext,
                  onSkip: onSkip,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}