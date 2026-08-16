// lib/controllers/reservation_tab_controller.dart
import 'package:get/get.dart';

class ReservationTabController extends GetxController {
  var showCart = true.obs;

  void toggleTab(bool showCartValue) {
    showCart.value = showCartValue;
  }
}