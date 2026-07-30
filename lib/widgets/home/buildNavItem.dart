// import 'package:flutter/material.dart';

// Widget _buildNavItem(String imagePath, int index) {
//   final bool isSelected = currentIndex == index;

//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         currentIndex = index;
//       });
//     },
//     child: AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       padding: const EdgeInsets.all(6),
//       child: Image.asset(
//         imagePath,
//         width: 24,
//         height: 24,
//         color: isSelected
//             ? const Color(0xFF4A90E2) // لون التحديد
//             : const Color(0xFFB0B0B0), // غير محدد
//       ),
//     ),
//   );
// }