import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/Auth/login_controller.dart';
import 'package:project_user/functions/validInput.dart';
import 'package:project_user/widgets/Auth/login/GoogleButton.dart';
import 'package:project_user/widgets/Auth/login/LoginButton.dart';
import 'package:project_user/widgets/Auth/login/LoginRegisterText.dart';
import 'package:project_user/widgets/Auth/login/LoginTitle.dart';
import 'package:project_user/widgets/Auth/login/OrDivider.dart';

import 'package:project_user/widgets/Auth/login/aouthtextfiled.dart';

import 'package:project_user/widgets/Auth/login/inkwellforgitpassword.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});
  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Form(
        key: controller.formState,
        child: Scaffold(
          body: Stack(
            children: [
      
              SizedBox.expand(
                child: Image.asset(ImageAssets.loginback, fit: BoxFit.cover),
              ),

              
              Center(
                child: Container(
                  width: 334,
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                  decoration: BoxDecoration(
                    color: const Color(0x9EFFFFFF), // #FFFFFF9E
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),

                  child: ListView(
                    padding: EdgeInsets.only(top: 0),
                    physics: const ClampingScrollPhysics(),

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsetsGeometry.only(left: 5)),
                          Image.asset(ImageAssets.logintext),
                        ],
                      ),

                      const SizedBox(height: 5),

                      LoginTitle(),

                      SizedBox(height: 20),
                      LoginRegisterText(onTap: controller.gotoSignup),////,

                      SizedBox(height: 30),

                      // Email
                      Authtextfeild(
                        validator: (val) => validInput(val!, 10, 40, "email"),
                        hintText: "Email Address",
                        icon: Icons.email_outlined,
                        obscureText: false,
                        mycontroller: controller.email,
                      ),
                      /////////////////////////////////////////////////////////////////////////
                      const SizedBox(height: 20),

                      // Password
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

                      // 
                     inkwellforgitpassword(
  FirstText: "Forgot password?",
  SecondText: "Login as guest",
  onTap: () {
    controller.goToForgetPassword();
  },
  onGuestTap: () {
    controller.guestLogin();
  },
),
                      const SizedBox(height: 20),
                      ////////////////////////////////////////////
                   LoginButton(
  onPressed: () {
    controller.login();
  },
),
                      const OrDivider(), /////

                      GoogleButton(
                        onPressed: () {}, /////
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
