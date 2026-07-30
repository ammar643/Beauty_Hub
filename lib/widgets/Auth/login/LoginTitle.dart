import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 5),

        Text(
          "Login",
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