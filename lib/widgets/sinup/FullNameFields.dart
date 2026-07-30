import 'package:flutter/material.dart';
import 'package:project_user/functions/validInput.dart';

class FullNameFields extends StatelessWidget {
  final TextEditingController? firstNameController;
  final TextEditingController? lastNameController;

  const FullNameFields({
    super.key,
    this.firstNameController,
    this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // First Name
        Container(
          width: 148,
          height: 62,
          child: TextFormField(
            controller: firstNameController,
            validator: (val) =>
                validInput(val!, 3, 20, "username"),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                color: Color(0xD44B1A23),
              ),
              hintText: "First Name",
              hintStyle: const TextStyle(
                color: Color(0xD44B1A23),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: const Color(0xFFF2F2F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Last Name
        Container(
          width: 148,
          height: 62,
          child: TextFormField(
            controller: lastNameController,
            validator: (val) =>
                validInput(val!, 3, 20, "username"),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                color: Color(0xD44B1A23),
              ),
              hintText: "Last Name",
              hintStyle: const TextStyle(
                color: Color(0xD44B1A23),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: const Color(0xFFF2F2F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}