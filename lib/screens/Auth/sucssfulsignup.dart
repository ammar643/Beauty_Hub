import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_user/controllers/Auth/SuccessfulController.dart';
import 'package:project_user/widgets/Auth/forgotpassword/bottion.dart';

class SuccessfulSignIn extends StatelessWidget {
  SuccessfulSignIn({super.key});
  SuccessfulController controller = Get.put(SuccessfulController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuccessfulController>(
      builder: (controller) => Form(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: 30),
                Text(
                  "Successfully",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xFF4B1A23),
                    fontWeight: FontWeight.w700,
                  ),

                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 100),
                Icon(
                  Icons.task_alt_rounded,
                  size: 200,
                  color: Color(0xFF8B3344),
                ),

                SizedBox(height: 30),

                Text(
                  "Your code has been success",

                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    color: Color(0xFF4B1A23),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 150),

                forgotbottion(
                  text: "Continue",
                  onPressed: () {
                     controller.gotohome();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
