import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/Auth/checkemail_controler.dart';
import 'package:pinput/pinput.dart';
import 'package:project_user/controllers/Auth/forgotpassword_contoler.dart';

import 'package:project_user/functions/validInput.dart';
import 'package:project_user/widgets/Auth/forgotpassword/bottion.dart';
import 'package:project_user/widgets/Auth/forgotpassword/forgottext.dart';
import 'package:project_user/widgets/Auth/forgotpassword/forgottitle.dart';
import 'package:project_user/widgets/Auth/login/aouthtextfiled.dart';

import 'package:project_user/widgets/sinup/bottion.dart';

import 'package:project_user/widgets/sinup/sinuptitle.dart';

// ignore: must_be_immutable
class Checkemail extends StatelessWidget {
  Checkemail({super.key});

  CheckemailControler controller = Get.put(CheckemailControler());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckemailControler>(
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

                       
     Image.asset(ImageAssets.checkemail,height: 77,width: 70,),

              SizedBox(height: 10),
              tTitle(text: "Check your Email"),
              SizedBox(height: 10),
            tText(text: "We have sent the verification code to your email address"),

              

              /////////////////////////////////////////////////////////////////////////
               SizedBox(height: 20),

///////otp
            Center(
  child: Pinput(
     controller: controller.otpController,
    length: 6,
    defaultPinTheme: PinTheme(
      width: 63,
      height: 63,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Color(0xff4B1A23),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffD9D9D9),
          width: 1.5,
        ),
      ),
    ),

    focusedPinTheme: PinTheme(
      width: 63,
      height: 63,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Color(0xff4B1A23),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xff4B1A23),
          width: 2.5,
        ),
      ),
    ),

    submittedPinTheme: PinTheme(
      width: 63,
      height: 63,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Color(0xff4B1A23),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xff4B1A23),
          width: 2.5,
        ),
      ),
    ),

    onCompleted: (pin) {
      print(pin);
    },
  ),
),  
             
              const SizedBox(height: 20),

GetBuilder<CheckemailControler>(
  builder: (controller) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text(
        "you can order another one after: ",
        style: TextStyle(
          fontSize: 13,
          color: Color(0xff000000),
          fontWeight: FontWeight.w400,
        ),
      ),

      Text(
        controller.formattedTime,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff4B1A23),
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(width: 8),

      InkWell(
        onTap: controller.canResend
            ? controller.resendCode
            : null,
        child: Text(
          "Order",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: controller.canResend
                ? const Color(0xff4B1A23)
                : Colors.grey,
          ),
        ),
      ),
    ],
  ),
),

const SizedBox(height: 20),
              ////////////////////////////////////////////
              forgotbottion(
text: "Continue",
onPressed: () {

controller.verifyOtp();

},
),

            
            ],
          ),
        ),
      ),
    );
  }
}
