import 'package:flutter/material.dart';
import 'package:project_user/services/static/static.dart';

class OnboardingButtons extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingButtons({
    super.key,
    required this.currentIndex,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [

        if (currentIndex != onBordinglist.length - 1)
          onboardingButton(
            text: "Skip",
            onTap: onSkip,
            buttonColor: const Color(0xFFF4F4F4),
          )
        else
          const SizedBox(width: 78),

        onboardingButton(
          text: currentIndex ==
                  onBordinglist.length - 1
              ? "Let's Go"
              : "Next",
          onTap: onNext,
          buttonColor: const Color(0xFFFFEA7C),
        ),
      ],
    );
  }

  Widget onboardingButton({
    required String text,
    required VoidCallback onTap,
    required Color buttonColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),

        height: 37,

        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF4B1A23),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}