import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';

class SinupController extends GetxController {

  bool isShow = false;

  // Controllers
  TextEditingController? email;
  TextEditingController? password;
  TextEditingController? phone_number;
  TextEditingController? confirm_password;
  TextEditingController? Birthday;

  TextEditingController? firstNameController;
  TextEditingController? lastNameController;

  // Form Key
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  // Validation
  validate() {

    var formdata = formState.currentState;

    if (formdata!.validate()) {

      // Register Logic
      print("Valid");

    } else {

      print("Not Valid");
    }
  }

  // Go To Login
  login() {

    Get.toNamed(AppRoutes.login);
  }

  // Show / Hide Password
  showPassword() {

    isShow = !isShow;

    update();
  }

  // Forgot Password
  goToForgetPassword() {

    Get.offNamed(AppRoutes.forgotpassword);
  }

  // Init Controllers
  @override
  void onInit() {

    email = TextEditingController();
    password = TextEditingController();
    Birthday = TextEditingController();
    confirm_password = TextEditingController();
    phone_number = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

    super.onInit();
  }

  // Dispose Controllers
  @override
  void dispose() {

    email!.dispose();
    password!.dispose();
     phone_number!.dispose();
     confirm_password!.dispose();
     Birthday!.dispose();


    firstNameController!.dispose();
    lastNameController!.dispose();

    super.dispose();
  }
}