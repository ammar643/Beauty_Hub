




import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_user/routes/routes.dart';
import 'package:project_user/services/Auth/LoginService.dart';

class LoginController extends GetxController {

  bool isShow = false;
 LoginService service = LoginService();

GetStorage box = GetStorage();

bool isLoading = false;
  TextEditingController? email;
  TextEditingController? password;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
 
  validate() {

    var formdata = formState.currentState;

    if (formdata!.validate()) {

      // Register Logic
      print("Valid");

    } else {

      print("Not Valid");
    }
  }
   
Future<void> guestLogin() async {
  try {
    isLoading = true;
    update();

    var response = await service.guestLogin();

    if (response.data["success"] == true) {
      box.write("isGuest", true);

      Get.snackbar(
        "Success",
        response.data["message"],
      );

      Get.offAllNamed(AppRoutes.homeScreen);
    }
  } on DioException catch (e) {
    Get.snackbar(
      "Error",
      e.response?.data["message"] ?? "Guest Login Error",
    );
  } finally {
    isLoading = false;
    update();
  }
}

















   Future<void> login() async {


  if(!formState.currentState!.validate()){
    return;
  }


  try {


    isLoading = true;
    update();



    var response = await service.login(

      email: email!.text,

      password: password!.text,

    );



    if(response.data["success"] == true){


      String token =
      response.data["data"]["token"];



      box.write(
        "token",
        token,
      );



      Get.snackbar(
        "Success",
        response.data["message"],
      );



      Get.offAllNamed(
        AppRoutes.homeScreen,
      );


    }



  } on DioException catch(e){



    print("TYPE : ${e.type}");
    print("MESSAGE : ${e.message}");
    print("DATA : ${e.response?.data}");



    Get.snackbar(

      "Error",

      e.response?.data["message"] ?? "Login Error",

    );



  }



  finally{

    isLoading=false;

    update();

  }


}





  gotoSignup() {
     Get.offNamed(AppRoutes.sinup);
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
  super.onInit();

  email = TextEditingController();
  password = TextEditingController();
}

  @override
 @override
void onClose() {
  email?.dispose();
  password?.dispose();
  super.onClose();
}

  }

 