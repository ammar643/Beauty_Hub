import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_user/controllers/Auth/forgotpassword_contoler.dart';

import 'package:project_user/functions/validInput.dart';
import 'package:project_user/widgets/Auth/forgotpassword/bottion.dart';
import 'package:project_user/widgets/Auth/forgotpassword/forgottext.dart';
import 'package:project_user/widgets/Auth/forgotpassword/forgottitle.dart';
import 'package:project_user/widgets/Auth/login/aouthtextfiled.dart';

import 'package:project_user/widgets/sinup/bottion.dart';

import 'package:project_user/widgets/sinup/sinuptitle.dart';

// ignore: must_be_immutable
class Forgotpassword extends StatelessWidget {
  Forgotpassword({super.key});

  ForgetPasswordcontroller controller = Get.put(ForgetPasswordcontroller());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordcontroller>(
      builder: (controller) => Form(
        key: controller.formState,
        child: Scaffold(

          appBar: AppBar(
  title: IconButton(
    icon: const Icon(
      Icons.arrow_back,
      size: 35,
      color: Color(0xff969696),
    ),
    onPressed: controller.goToBack,
  ),
),
          
          body: ListView(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            physics: const ClampingScrollPhysics(),

            children: [




             // SizedBox(height: 10),
           tTitle(text: "Forgot Password"),

              SizedBox(height: 10),
              tText(text: "Enter Email Address associated with your \naccount and we’ll send an email with \ninstructions to reset your password"),

              // Email

              /////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 70),

         Authtextfeild(
  mycontroller: controller.email,
  validator: (val) => validInput(val!, 10, 40, "email"),
  hintText: "Email Address",
  icon: Icons.email_outlined,
  obscureText: false,
),
              const SizedBox(height: 40),

              // Password
              

              
              ////////////////////////////////////////////
            forgotbottion(
  text: "Send",
  onPressed: () async {
    await controller.Forget_password();
  },
),

              
            ],
          ),
        ),
      ),
    );
  }
}
