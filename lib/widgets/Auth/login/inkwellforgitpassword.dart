
import 'package:flutter/material.dart';
class inkwellforgitpassword extends StatelessWidget {
  const inkwellforgitpassword({
    super.key,
    required this.FirstText,
    required this.SecondText,
    required this.onTap,
    required this.onGuestTap,
  });

  final String FirstText;
  final String SecondText;
  final VoidCallback onTap;
  final VoidCallback onGuestTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTap,
          child: Text(
            FirstText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        InkWell(
          onTap: onGuestTap,
          child: Text(
            SecondText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}