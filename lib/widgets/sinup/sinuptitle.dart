import 'package:flutter/material.dart';

class Sinuptitle extends StatelessWidget {
  const Sinuptitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 5),

        Text(
          "Register",
          style: TextStyle(
            fontSize: 32,
            color: Color(0xFF4B1A23),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}