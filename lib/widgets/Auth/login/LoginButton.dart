import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function()? onPressed;

  const LoginButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 45,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        boxShadow: const [
          BoxShadow(
            color: Color(0x8C000000),
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE7E7EE),
          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        onPressed: onPressed,

        child: const Text(
          "Login",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF4B1A23),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}