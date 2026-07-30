import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  final String image;

  const OnboardingBackground({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}