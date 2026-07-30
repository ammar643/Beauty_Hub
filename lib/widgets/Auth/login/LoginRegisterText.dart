import 'package:flutter/material.dart';
import 'package:project_user/widgets/Auth/login/inkWellText.dart';

class LoginRegisterText extends StatelessWidget {
  final VoidCallback onTap;

  const LoginRegisterText({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        const SizedBox(width: 5),

        Inkwelltext(
          FirstText: "you don’t have account? ",
          SecondText: "Register",
          onTap: onTap,
        ),
      ],
    );
  }
}