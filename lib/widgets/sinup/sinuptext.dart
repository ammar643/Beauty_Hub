import 'package:flutter/material.dart';
import 'package:project_user/widgets/Auth/login/inkWellText.dart';

class Sinuptext extends StatelessWidget {
  final VoidCallback onTap;

  const Sinuptext({
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
          FirstText: "you have account? ",
          SecondText: "Login",
          onTap: onTap,
        ),
      ],
    );
  }
}