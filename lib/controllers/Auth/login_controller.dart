
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_user/routes/routes.dart';

class LoginController extends GetxController {

  bool isShow = false;
 
  TextEditingController? email;
  TextEditingController? password;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
 
  validate() {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
     
      login();
    } else {
      return "not valid";
    }}
   


   
  login()  {
   Get.toNamed(AppRoutes.test);
  }






  gotoSignup() {
     Get.toNamed(AppRoutes.sinup);
  }

  showPassword() {
  isShow = !isShow;
  update();
}

  goToForgetPassword() {

 Get.offAllNamed(AppRoutes.forgotpassword);

  }






  @override
  void onInit() {

    isShow;
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    email!.dispose();
    password!.dispose();
    super.dispose();
  }

  }

 

