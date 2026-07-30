import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  final VoidCallback onAddTap;

  const ProfileImagePicker({
    super.key,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          // 🔵 الدائرة الرئيسية
          Container(
            width: 87,
            height: 87,
            decoration: const BoxDecoration(
              color: Color(0xFFEDEDED),
              shape: BoxShape.circle,
            ),
          ),

          // ➕ زر الإضافة (فوق يمين)
         Positioned(
  top: -10,
  left: 58,

  child: GestureDetector(
    onTap: onAddTap,

    child: SizedBox(
      width: 29,
      height: 37,

      child: const Text(
        "+",

        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0,
          color: Color(0xFF4B1A23),
        ),
      ),
    ),
  ),
),

          // 👤 أيقونة الإنسان في الوسط
          const Positioned.fill(
            child: Icon(
              Icons.person,
              size: 45,
              color: Color(0xFF4B1A23),
            ),
          ),
        ],
      ),
    );
  }
}