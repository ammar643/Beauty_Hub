// lib/controllers/orders_controller.dart
import 'package:get/get.dart';
import 'package:project_user/services/order_service.dart';

class OrdersController extends GetxController {
  final OrderService _orderService = OrderService();

  var isLoading = false.obs;
  var orders = <Map<String, dynamic>>[].obs;

  var isOrderDetailsLoading = false.obs;
  var orderDetails = <String, dynamic>{}.obs;
  var orderItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // ============================================================
  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      final result = await _orderService.getOrders();
      if (result != null && result['success'] == true) {
        final data = result['data'] as List?;
        orders.assignAll(data?.map((e) => e as Map<String, dynamic>)?.toList() ?? []);
      } else {
        Get.snackbar('خطأ', result?['message'] ?? 'فشل في تحميل الطلبات');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  Future<void> fetchOrderDetails(int orderId) async {
    isOrderDetailsLoading.value = true;
    try {
      final result = await _orderService.getOrderDetails(orderId);
      if (result != null && result['success'] == true) {
        final data = result['data'];
        orderDetails.value = data['order'] ?? {};
        orderItems.assignAll((data['items'] as List?)?.map((e) => e as Map<String, dynamic>)?.toList() ?? []);
      } else {
        Get.snackbar('خطأ', result?['message'] ?? 'فشل في تحميل تفاصيل الطلب');
      }
    } finally {
      isOrderDetailsLoading.value = false;
    }
  }
  Future<void> cancelOrder(int orderId) async {
    try {
      final result = await _orderService.cancelOrder(orderId);
      if (result != null && result['success'] == true) {
        Get.snackbar('تم', 'تم إلغاء الطلب واسترداد المبلغ بنجاح');
        await fetchOrders();
        Get.back();
      } else {
        Get.snackbar('خطأ', result?['message'] ?? 'فشل في إلغاء الطلب');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع');
    }
  }
  // ============================================================
  void refreshOrders() {
    fetchOrders();
  }
} 