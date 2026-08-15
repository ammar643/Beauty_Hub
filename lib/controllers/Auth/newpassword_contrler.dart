import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';
import 'package:project_user/services/Auth/ResetPasswordService.dart';

class NewpasswordContrler extends GetxController {

  ResetPasswordService service = ResetPasswordService();

  bool isShow = false;
  bool isLoading = false;

  TextEditingController? password;
  TextEditingController? confirm_password;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late String email;
  late String otp;

  @override
  void onInit() {

    password = TextEditingController();
    confirm_password = TextEditingController();

    email = Get.arguments["email"];
    otp = Get.arguments["otp"];

    super.onInit();
  }

  Future<void> resetPassword() async {

    if (!formState.currentState!.validate()) {
      return;
    }

    if (password!.text != confirm_password!.text) {

      Get.snackbar(
        "Error",
        "Passwords do not match",
      );

      return;
    }

    try {

      isLoading = true;
      update();

      var response = await service.resetPassword(

        email: email,
        otp: otp,
        password: password!.text,
        confirmPassword: confirm_password!.text,

      );

      if(response.data["success"]){

        Get.snackbar(
          "Success",
          response.data["message"],
        );

        Get.offAllNamed(AppRoutes.login);

      }

    } on DioException catch(e){

      Get.snackbar(
        "Error",
        e.response?.data["message"] ?? "Server Error",
      );

    } finally {

      isLoading = false;
      update();

    }

  }

  void showPassword() {
    isShow = !isShow;
    update();
  }

  void goToBack() {
    Get.back();
  }

  @override
  void onClose() {

    password!.dispose();
    confirm_password!.dispose();

    super.onClose();
  }

}