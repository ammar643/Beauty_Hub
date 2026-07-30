
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';

class ForgetPasswordcontroller extends GetxController {
  
  TextEditingController? email;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
 
 
 
 
   validate_forgetpassword() {



  validate_forgotpassword() {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      Forget_password();
    }
  }
   }

   
   Forget_password(){



  }
  
  
  //  async {
  //   try {
  //     var response =
  //         await ForgotpasswordService().postForgotpasswordData(email!.text);

  //      if (response != null) {
  //     if ((response["token"] != null)) {
    
  //        Get.offNamed(
  //           AppRoutes.otpVerification,
  //           arguments: {"email": email!.text},
  //         );
  //       } else {
  //         Get.snackbar("Error", response["message"] ?? "Unknown error");
  //       }
  //     } else {
  //       Get.snackbar("Error", "Server error");
  //     }
  //   } catch (e) {}
  // }

 

 goToCheckEmail() {

Get.offAllNamed(AppRoutes.CheckEmail);

 }

 goToBack() {

Get.toNamed(AppRoutes.login);

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
