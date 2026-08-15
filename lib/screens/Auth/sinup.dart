import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/sinup_controler.dart';
import 'package:project_user/functions/validInput.dart';
import 'package:project_user/widgets/Auth/login/aouthtextfiled.dart';
import 'package:project_user/widgets/sinup/FullNameFields.dart';
import 'package:project_user/widgets/sinup/bottion.dart';
import 'package:project_user/widgets/sinup/ofile%20Image%20Picker%20Widget.dart';
import 'package:project_user/widgets/sinup/sinuptext.dart';
import 'package:project_user/widgets/sinup/sinuptitle.dart';

// ignore: must_be_immutable
class Sinup extends StatelessWidget {
  Sinup({super.key});
  SinupController controller = Get.put(SinupController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SinupController>(
      builder: (controller) => Form(
        key: controller.formState,
        child: Scaffold(
          body: Stack(
            children: [
              // 
              SizedBox.expand(
                child: Image.asset(ImageAssets.loginback, fit: BoxFit.cover),
              ),

              // 
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 334,
                  height: 690,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
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
                      ProfileImagePicker(
                        onAddTap: () {
                          // 
                        },
                      ),

                    //  const SizedBox(height: 5),

                      Sinuptitle(),

                      SizedBox(height: 10),
                      Sinuptext(onTap: controller.login), ///

                      SizedBox(height: 10),
FullNameFields(
  firstNameController: controller.firstNameController,
  lastNameController: controller.lastNameController,
),
//const SizedBox(height: 10),
                      // Email
                      Authtextfeild(
                        validator: (val) => validInput(val!, 10, 40, "phone"),
                        hintText: "Phone Number",
                        icon: Icons.phone_iphone_outlined,
                        obscureText: false,
                        mycontroller: controller.phone_number,
                      ),
                      /////////////////////////////////////////////////////////////////////////
                      const SizedBox(height: 10),

                  //   FullNameFields(),

                       Authtextfeild(
                                             validator: (val) => validInput(val!, 1, 20, "birthday"),
hintText: "Your Birthday",
                                              icon: Icons.calendar_month_outlined,
                                              obscureText: false,
                                              mycontroller: controller.Birthday,
                                            ),
                      const SizedBox(height: 10),

                       Authtextfeild(
                                              validator: (val) => validInput(val!, 10, 40, "email"),
                                              hintText: "Email Address",
                                              icon: Icons.email_outlined,
                                              obscureText: false,
                                              mycontroller: controller.email,
                                            ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),

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
                      //
                      SizedBox(height: 10),
                      ////////////////////////////////////////////
                     Sinupbottion(
text: controller.isLoading 
? "Loading..."
: "Register",

onPressed: () {

controller.register();

},

),

                      ////
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