import 'package:flutter/material.dart';
import 'package:project_user/constant/imageAssets.dart';

Widget buildHorizontalSection(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left:20 ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      const SizedBox(height: 10),
SizedBox(
  height: 54,
  child: ListView.separated(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.only(left: 20),
    itemCount: 10,
    separatorBuilder: (_, __) => const SizedBox(width: 10),
    itemBuilder: (context, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(54),
        child: Image.asset(
          ImageAssets.onbording1,
          width: 54,
          height: 54,
          fit: BoxFit.cover,
        ),
      );
    },
  ),
),
    ],
  );
}