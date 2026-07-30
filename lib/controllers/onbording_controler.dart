import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/routes/routes.dart';
import 'package:project_user/services/static/static.dart';

class OnboardingController extends GetxController {

   PageController pageController = PageController();

  int currentIndex = 0;

  void onPageChanged(int index) {
    currentIndex = index;
    update();
  }

  void nextPage() {
    if (currentIndex == onBordinglist.length - 1) {
      Get.toNamed(AppRoutes.login);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipPages() {
  
    Get.toNamed(AppRoutes.login);
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}