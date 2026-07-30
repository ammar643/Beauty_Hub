import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';

class VerificationControler extends GetxController {
  TextEditingController otpController = TextEditingController();

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

    // API إعادة إرسال الكود

    seconds = 154;
    startTimer();
    update();
  }

goTosucssfullsignup(){


  Get.offNamed(AppRoutes.SuccessfulSignIn);
}



  goToBack() {
    Get.offNamed(AppRoutes.forgotpassword);
  }

  @override
  void onClose() {
    timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}