
import 'package:flutter/material.dart';

class Inkwelltext extends StatelessWidget {
  Inkwelltext(
      {super.key,
      required this.FirstText,
      required this.SecondText,
      required this.onTap});
  String? FirstText;
  String? SecondText;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          FirstText!,
          style: TextStyle(



  fontSize: 15,
  color: Color(0xBD000000),
 

  fontWeight:FontWeight.w500
),),
        InkWell(
          onTap: onTap,
          child: Text(
            SecondText!,
            style: TextStyle(



  fontSize: 16,
  color: Color(0xFF4B1A23),
 

  fontWeight:FontWeight.w700
),)
        ),
      ],
    );
  }
}
