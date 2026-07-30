import 'package:flutter/material.dart';

class ImageButtonWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const ImageButtonWidget({
    super.key,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(3),
        onTap: onTap,
        child: Container(
          width: 29.17,
          height: 29.17,
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: Colors.black,
          //     width: 3,
          //   ),
          //   borderRadius: BorderRadius.circular(3),
          // ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}