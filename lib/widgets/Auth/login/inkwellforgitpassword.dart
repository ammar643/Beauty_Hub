
import 'package:flutter/material.dart';

class inkwellforgitpassword extends StatelessWidget {
  inkwellforgitpassword(
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

 InkWell(
          onTap: onTap,
          child: Text(
            FirstText!,
            style: TextStyle(



  fontSize: 16,
  color: Color(0xFF000000),
  fontWeight:FontWeight.w500
),),
        ), 

        Text(
          SecondText!,
          style:TextStyle(



  fontSize: 16,
  color: Color(0xFF000000),
  fontWeight:FontWeight.w500
),),
      ],
    );
  }
}
