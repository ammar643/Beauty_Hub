import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_user/controllers/Auth/forgotpassword_contoler.dart';
import 'package:project_user/controllers/Auth/newpassword_contrler.dart';

import 'package:project_user/functions/validInput.dart';
import 'package:project_user/widgets/Auth/forgotpassword/bottion.dart';
import 'package:project_user/widgets/Auth/forgotpassword/forgottext.dart';
import 'package:project_user/widgets/Auth/forgotpassword/forgottitle.dart';
import 'package:project_user/widgets/Auth/login/aouthtextfiled.dart';

import 'package:project_user/widgets/sinup/bottion.dart';

import 'package:project_user/widgets/sinup/sinuptitle.dart';

// ignore: must_be_immutable
class NewPassword  extends StatelessWidget {
  NewPassword({super.key});

  NewpasswordContrler controller = Get.put(NewpasswordContrler());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewpasswordContrler>(
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
           tTitle(text: "Create new Password"),

              SizedBox(height: 10),
              tText(text: "Your new password must be different from previous used password"),

              // Email

              /////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 40),

               Authtextfeild(
                        validator: (val) => validInput(val!, 5, 15, 'password'),
                        hintText: "Password",
                        icon: Icons.lock_outline,
                        obscureText: !controller.isShow,
                        mycontroller: controller.password,
                        onPressed: () {
                          controller.showPassword();
                        },
                      ),
              const SizedBox(height: 20),

              // Password
              

 Authtextfeild(
                                              validator: (val) => validInput(val!, 5, 15, 'password'),
                                              hintText: "Confirm Password",
                                              icon: Icons.lock_outline,
                                              obscureText: !controller.isShow,
                                              mycontroller: controller.confirm_password,
                                              onPressed: () {
                                                controller.showPassword();
                                              },
                                            ),


  const SizedBox(height: 20),






              
              ////////////////////////////////////////////
              forgotbottion(text: "Reset Password", onPressed: () {

                //controller.;
              }),

              ////ويدجتbottion
            ],
          ),
        ),
      ),
    );
  }
}
