// lib/controllers/cart_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/services/cart_service.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();

  var isLoading = false.obs;
  var cartItems = <Map<String, dynamic>>[].obs;
  var totalAmount = 0.0.obs;
  var cartId = 0.obs;
  var itemsCount = 0.obs;
 var isLoadingCart = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    isLoading.value = true;
    try {
      final result = await _cartService.getCart();
      if (result != null && result['success'] == true) {
        final data = result['data'];
        cartId.value = data['cart_id'] ?? 0;
        itemsCount.value = data['items_count'] ?? 0;
        totalAmount.value = (data['total_amount'] ?? 0.0).toDouble();
        cartItems.assignAll((data['items'] as List?)?.map((e) => e as Map<String, dynamic>)?.toList() ?? []);
      } else {
        Get.snackbar('خطأ', result?['message'] ?? 'فشل في تحميل السلة');
      }
    } finally {
      isLoading.value = false;
    }
  }
 Future<void> checkout() async {
    try {
      final result = await _cartService.checkout();
      if (result != null && result['success'] == true) {
        cartItems.clear();
        totalAmount.value = 0.0;
        itemsCount.value = 0;
        Get.snackbar('تم', 'تم إتمام الطلب بنجاح');
        // fetchCart();
      } else {
        Get.snackbar('خطأ', result?['message'] ?? 'فشل في إتمام الطلب');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع أثناء إتمام الطلب');
    }
  }
  Future<void> updateQuantity(int index, int newQuantity) async {
    if (index < 0 || index >= cartItems.length) return;
    final item = cartItems[index];
    final cartItemId = item['cart_item_id'] ?? 0;
    if (cartItemId == 0) return;

    final stock = item['stock_available'] ?? 0;
    if (newQuantity < 1) return;
    if (newQuantity > stock) {
      Get.snackbar('تنبيه', 'الكمية المتاحة هي $stock');
      return;
    }

    try {
      final result = await _cartService.updateCartItem(
        cartItemId: cartItemId,
        quantity: newQuantity,
      );
      if (result != null && result['success'] == true) {
        item['quantity'] = newQuantity;
        item['line_total'] = (item['unit_price'] ?? 0.0) * newQuantity;
        cartItems[index] = item;
        _recalculateTotal();
      } else {
        Get.snackbar('خطأ', result?['message'] ?? 'فشل في تحديث الكمية');
        fetchCart();
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع');
      fetchCart();
    }
  }

  Future<void> removeItem(int index) async {
    if (index < 0 || index >= cartItems.length) return;
    final item = cartItems[index];
    final cartItemId = item['cart_item_id'] ?? 0;
    if (cartItemId == 0) return;

    try {
      final result = await _cartService.removeCartItem(cartItemId: cartItemId);
      if (result != null && result['success'] == true) {
        cartItems.removeAt(index);
        _recalculateTotal();
        Get.snackbar('تم', 'تم حذف العنصر من السلة');
      } else {
        Get.snackbar('خطأ', result?['message'] ?? 'فشل في حذف العنصر');
        fetchCart();
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع');
      fetchCart();
    }
  }

  Future<void> clearCart() async {
    try {
      final result = await _cartService.clearCart();
      if (result != null && result['success'] == true) {
        cartItems.clear();
        totalAmount.value = 0.0;
        itemsCount.value = 0;
        Get.snackbar('تم', 'تم تفريغ السلة بنجاح');
      } else {
        Get.snackbar('خطأ', result?['message'] ?? 'فشل في تفريغ السلة');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع');
    }
  }
 Future<void> addToCart(int productId, int quantity) async {
    if (isLoadingCart.value) return;

    isLoadingCart.value = true;
    try {
      final result = await CartService().addToCart(
        productId: productId,
        quantity: quantity,
      );

      if (result != null && result['success'] == true) {
        Get.snackbar(
          'تم الإضافة',
          'تمت إضافة المنتج إلى السلة بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'خطأ',
          result?['message'] ?? 'حدث خطأ ما',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoadingCart.value = false;
    }
  }
  void _recalculateTotal() {
    double sum = 0.0;
    for (var item in cartItems) {
      sum += (item['line_total'] ?? 0.0);
    }
    totalAmount.value = sum;
    itemsCount.value = cartItems.length;
  }
}