import 'package:flutter/material.dart';

class Authtextfeild extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController? mycontroller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function()? onPressed;

  const Authtextfeild({
    super.key,
    required this.hintText,
    required this.icon,
    required this.obscureText,
    this.mycontroller,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,

      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: const Color(0xD44B1A23),
        ),

        // زر إظهار/إخفاء كلمة المرور
        suffixIcon: onPressed != null
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              )
            : null,

        hintText: hintText,

        hintStyle: const TextStyle(
          color: Color(0xD44B1A23),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1,
          letterSpacing: 0,
        ),

        filled: true,
        fillColor: const Color(0xFFF2F2F7),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
      ),
    );
  }
}