import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';

class NewpasswordContrler extends GetxController {

  bool isShow = false;

  // Controllers
  
  TextEditingController? password;
  TextEditingController? confirm_password;
  

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

   // Get.offNamed(AppRoutes.);
  }

  // Show / Hide Password
  showPassword() {

    isShow = !isShow;

    update();
  }

  // Forgot Password
  goToBack() {

    Get.offNamed(AppRoutes.CheckEmail);
  }

  // Init Controllers
  @override
  void onInit() {

    
    password = TextEditingController();
    
    confirm_password = TextEditingController();
    
   

    super.onInit();
  }

  // Dispose Controllers
  @override
  void dispose() {

  
    password!.dispose();
     
     confirm_password!.dispose();
     


   

    super.dispose();
  }
}