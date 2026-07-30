// import 'dart:async';

// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';


// class SplashController extends GetxController {
//   GetStorage box = GetStorage();
//   Timer get time => Timer(
//         Duration(seconds: 5),
//         () => splashTimer(),
//       );
//   splashTimer() {
//     print("isOnboardinrShow: ${box.read("isOnboardinrShow")}");

//     bool? isShow = box.read("isOnboardinrShow");
//     if (isShow == null || isShow == false) {//false
//     //  Get.offNamed(AppRoutes.onboarding);
//     } else {
//     //  Get.offNamed(AppRoutes.login);
//     }
//     update();
//   }

//   @override
//   void onInit() {
//     time;
//     super.onInit();
//   }
// }
