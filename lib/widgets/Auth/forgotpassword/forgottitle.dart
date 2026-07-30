import 'package:flutter/material.dart';

class tTitle extends StatelessWidget {
  final String text;

  const tTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            color: Color(0xFF4B1A23),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}