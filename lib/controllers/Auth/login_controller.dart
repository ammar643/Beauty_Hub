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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_user/routes/routes.dart';
import 'package:project_user/services/auth_service.dart';

class LoginController extends GetxController {
  var isShow = false
      .obs; 
  var isLoading = false.obs;

  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  final GetStorage _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  void validate() {
    if (formState.currentState!.validate()) {
      login();
    }
  }

  Future<void> login() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final response = await _authService.login(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (response != null && response['success'] == true) {
        String? token;
        if (response['data'] is Map<String, dynamic>) {
          token = response['data']['token'];
        }
        final userData = response['data']['user'];
        final box = GetStorage();
        box.write('user_id', userData['id']);
        box.write('token', response['data']['token']);
        if (token != null) {
          _box.write('token', token);
          print("✅ تم حفظ التوكن بنجاح: $token");
await Future.delayed(const Duration(milliseconds: 300));

  Get.offAllNamed(AppRoutes.homeScreen);
        } else {
          Get.snackbar(
            'خطأ',
            'لم يتم استلام توكن من السيرفر',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        final errorMessage = response?['message'] ?? 'فشل تسجيل الدخول';
        Get.snackbar(
          'فشل تسجيل الدخول',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ غير متوقع: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void showPassword() {
    isShow.value = !isShow.value;
  }

  void gotoSignup() {
    Get.toNamed(AppRoutes.sinup);
  }

  void goToForgetPassword() {
    Get.offAllNamed(AppRoutes.forgotpassword);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
