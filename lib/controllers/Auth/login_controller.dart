// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:project_user/routes/routes.dart';

// class LoginController extends GetxController {

//   bool isShow = false;

//   TextEditingController? email;
//   TextEditingController? password;
//   GlobalKey<FormState> formState = GlobalKey<FormState>();

//   validate() {
//     var formdata = formState.currentState;
//     if (formdata!.validate()) {

//       login();
//     } else {
//       return "not valid";
//     }}

//   login()  {
//    Get.toNamed(AppRoutes.test);
//   }

//   gotoSignup() {
//      Get.toNamed(AppRoutes.sinup);
//   }

//   showPassword() {
//   isShow = !isShow;
//   update();
// }

//   goToForgetPassword() {

//  Get.offAllNamed(AppRoutes.forgotpassword);

//   }

//   @override
//   void onInit() {

//     isShow;
//     // TODO: implement onInit
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     email!.dispose();
//     password!.dispose();
//     super.dispose();
//   }

//   }


//batoul

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:project_user/routes/routes.dart';
// import 'package:project_user/services/auth_service.dart';

// class LoginController extends GetxController {
//   var isShow = false
//       .obs; 
//   var isLoading = false.obs;

//   late TextEditingController email;
//   late TextEditingController password;
//   GlobalKey<FormState> formState = GlobalKey<FormState>();

//   final AuthService _authService = AuthService();

//   final GetStorage _box = GetStorage();

//   @override
//   void onInit() {
//     super.onInit();
//     email = TextEditingController();
//     password = TextEditingController();
//   }

//   void validate() {
//     if (formState.currentState!.validate()) {
//       login();
//     }
//   }

//   Future<void> login() async {
//     if (isLoading.value) return;
//     isLoading.value = true;

//     try {
//       final response = await _authService.login(
//         email: email.text.trim(),
//         password: password.text.trim(),
//       );

//       if (response != null && response['success'] == true) {
//         String? token;
//         if (response['data'] is Map<String, dynamic>) {
//           token = response['data']['token'];
//         }
//         final userData = response['data']['user'];
//         final box = GetStorage();
//         box.write('user_id', userData['id']);
//         box.write('token', response['data']['token']);
//         if (token != null) {
//           _box.write('token', token);
//           print("✅ تم حفظ التوكن بنجاح: $token");
// await Future.delayed(const Duration(milliseconds: 300));

//   Get.offAllNamed(AppRoutes.homeScreen);
//         } else {
//           Get.snackbar(
//             'خطأ',
//             'لم يتم استلام توكن من السيرفر',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         }
//       } else {
//         final errorMessage = response?['message'] ?? 'فشل تسجيل الدخول';
//         Get.snackbar(
//           'فشل تسجيل الدخول',
//           errorMessage,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'خطأ',
//         'حدث خطأ غير متوقع: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void showPassword() {
//     isShow.value = !isShow.value;
//   }

//   void gotoSignup() {
//     Get.toNamed(AppRoutes.sinup);
//   }

//   void goToForgetPassword() {
//     Get.offAllNamed(AppRoutes.forgotpassword);
//   }

//   @override
//   void dispose() {
//     email.dispose();
//     password.dispose();
//     super.dispose();
//   }
// }







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

 