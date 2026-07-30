import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [

        SizedBox(height: 10),

        Row(
          children: [

            Expanded(
              child: Divider(
                thickness: 2,
                color: Color(0x99000000),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),

              child: Text(
                "or",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0x99000000),
                ),
              ),
            ),

            Expanded(
              child: Divider(
                thickness: 2,
                color: Color(0x99000000),
              ),
            ),
          ],
        ),

        SizedBox(height: 5),
      ],
    );
  }
}