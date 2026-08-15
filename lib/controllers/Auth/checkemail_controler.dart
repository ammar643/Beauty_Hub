import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';
import 'package:project_user/services/Auth/otp-Service.dart';

class CheckemailControler extends GetxController {
  TextEditingController otpController = TextEditingController();
VerificationService service = VerificationService();
String? email;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  int seconds = 154; // 02:34

  Timer? timer;

  bool get canResend => seconds == 0;

  String get formattedTime {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

   @override
void onInit() {

  startTimer();


  var data = Get.arguments;

  if(data != null){

    email = data["email"];

  }


  super.onInit();
}

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          seconds--;
          update();
        } else {
          timer.cancel();
          update();
        }
      },
    );
  }

  void resendCode() {
    if (!canResend) return;

    

    seconds = 154;
    startTimer();
    update();
  }

Future<void> verifyOtp() async {


try{


var response = await service.verifyOtp(

email: email!,
otp: otpController.text,

);



if(response.data["success"] == true){


Get.snackbar(
"Success",
response.data["message"],
);

Get.offNamed(
  AppRoutes.NewPassword,
  arguments: {
    "email": email,
    "otp": otpController.text,
  },
);


}else{


Get.snackbar(
"Error",
response.data["message"],
);


}



}

on DioException catch(e){


print(e.response?.data);


Get.snackbar(
"Error",
e.response?.data["message"] ?? "Error",
);


}



}



















  goToBack() {
    Get.offNamed(AppRoutes.forgotpassword);
  }

  @override
  @override
  void onClose() {
    timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}