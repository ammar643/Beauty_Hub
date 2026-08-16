
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';
import 'package:project_user/services/Auth/ForgotPasswordService.dart';

class ForgetPasswordcontroller extends GetxController {
  


  ForgotPasswordService service = ForgotPasswordService();

bool isLoading = false;
  TextEditingController? email;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
 
 
 
  validate() {

    var formdata = formState.currentState;

    if (formdata!.validate()) {

      print("Valid");

    } else {

      print("Not Valid");
    }
  }
 
  
   
   Future<void> Forget_password() async {
print("Email: '${email!.text}'");
  if (!formState.currentState!.validate()) {
    print("Validation Failed");
    return;
  }
print("Validation Passed");
  try {

    isLoading = true;
    update();

    var response = await service.forgotPassword(
      email: email!.text,
    );

    if (response.data["success"] == true) {

      Get.snackbar(
        "Success",
        response.data["message"],
      );

      Get.offNamed(
        AppRoutes.CheckEmail,
        arguments: {
          "email": email!.text,
          "otp": response.data["data"]["debug_otp"].toString(),
        },
      );

    }

  } on DioException catch (e) {

    print(e.response?.data);

    Get.snackbar(
      "Error",
      e.response?.data["message"] ?? "Server Error",
    );

  } finally {

    isLoading = false;
    update();

  }
}
  
  

 

 goToBack() {

Get.offNamed(AppRoutes.login);

 }





  @override
  void onInit() {
    email = TextEditingController();

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    email!.dispose();

    super.dispose();
  }
}
