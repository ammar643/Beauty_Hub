import 'package:flutter/material.dart';
import 'package:project_user/constant/imageAssets.dart';

class GoogleButton extends StatelessWidget {

  final void Function()? onPressed;

  const GoogleButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 202,
      height: 45,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),

        boxShadow: const [
          BoxShadow(
            color: Color(0x69000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFFE7E7EE),

          padding: const EdgeInsets.fromLTRB(
            14,
            4,
            14,
            4,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),

        onPressed: onPressed,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Image.asset(
              ImageAssets.logingoogle,
              height: 20,
              width: 20,
            ),

            const SizedBox(width: 10),

            const Text(
              "Continue with Google",

              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4B1A23),
              ),
            ),
          ],
        ),
      ),
    );
  }
}