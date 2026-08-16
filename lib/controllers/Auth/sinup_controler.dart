import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';
import 'package:project_user/services/Auth/sinup_Service.dart';

class SinupController extends GetxController {
SinupService service = SinupService();
  bool isShow = false;
bool isLoading = false;
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



Future<void> register() async {
  if (!formState.currentState!.validate()) {
    return;
  }

  try {
    isLoading = true;
    update();

    var response = await service.register(
      firstName: firstNameController!.text,
      lastName: lastNameController!.text,
      phone: phone_number!.text,
      email: email!.text,
      password: password!.text,
      birthday: Birthday!.text,
      gender: "male",
    );

    if (response.data != null && response.data["success"] == true) {
      Get.snackbar(
        "Success",
        response.data["message"] ?? "تم التسجيل بنجاح",
        snackPosition: SnackPosition.BOTTOM,
      );

      final data = response.data["data"] as Map<String, dynamic>?;
      if (data != null) {
        String emailValue = data["email"] ?? '';
        String otpValue = data["otp"]?.toString() ?? '';

        Get.offNamed(
          AppRoutes.Verification,
          arguments: {
            "email": emailValue,
            "otp": otpValue,
          },
        );
      } else {
        Get.snackbar("خطأ", "لم يتم استلام بيانات من السيرفر");
      }
    } else {
      Get.snackbar(
        "Error",
        response.data["message"] ?? "فشل التسجيل",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } on DioException catch (e) {
    print("TYPE : ${e.type}");
    print("MESSAGE : ${e.message}");
    print("DATA : ${e.response?.data}");

    Get.snackbar(
      "Error",
      e.response?.data["message"] ?? "Server Error",
      snackPosition: SnackPosition.BOTTOM,
    );
  } finally {
    isLoading = false;
    update();
  }
}



















  login() {

    Get.toNamed(AppRoutes.login);
  }

  showPassword() {

    isShow = !isShow;

    update();
  }

  goToForgetPassword() {

    Get.offNamed(AppRoutes.forgotpassword);
  }

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