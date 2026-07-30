import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    if (currentIndex.value == index) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentIndex.value = index;
    });
  }
}