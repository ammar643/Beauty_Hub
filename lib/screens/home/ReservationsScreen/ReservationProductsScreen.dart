import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/api/app_config.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/controllers/cart_controller.dart';
import 'package:project_user/controllers/orders_controller.dart';
import 'package:project_user/controllers/reservation_tab_controller.dart'; 
import 'package:project_user/screens/ConversationsScreen.dart';
import 'package:project_user/screens/OrderDetailsScreen.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationsScreen .dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/home/homeScreen.dart';
import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

final String baseUrl = appConfig;

class ReservationProductsScreen extends StatelessWidget {
  ReservationProductsScreen({super.key});

  final HomeController homeController = Get.find();
  final CartController cartController = Get.put(CartController());
  final OrdersController ordersController = Get.put(OrdersController());
  final ReservationTabController tabController = Get.put(ReservationTabController()); 
    // ============================================================
  String _getFullImageUrl(String path) {
    if (path.trim().isEmpty) return '';
    final cleanPath = path.trim();
    if (cleanPath.startsWith('$baseUrl/storage/')) return cleanPath;
    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return '';
    }
    final cleanPathWithoutSlash =
        cleanPath.startsWith('/') ? cleanPath.substring(1) : cleanPath;
    return '$baseUrl/storage/$cleanPathWithoutSlash';
  }

  bool _hasValidBackendImage(String? path) {
    if (path == null || path.trim().isEmpty) return false;
    final value = path.trim();
    if (value.startsWith('$baseUrl/storage/')) return true;
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return false;
    }
    return true;
  }

  // ============================================================
  // Order Now
  // ============================================================
  void _orderNow() {
    if (cartController.cartItems.isEmpty) {
      Get.snackbar('تنبيه', 'السلة فارغة');
      return;
    }
    Get.defaultDialog(
      title: 'تأكيد الطلب',
      middleText: 'هل أنت متأكد من طلب هذه المنتجات؟',
      textConfirm: 'نعم',
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        await cartController.checkout();
        tabController.toggleTab(false);
        ordersController.refreshOrders();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    homeController.changeIndex(3);

    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 25),

                /// HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Reservations",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 30,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// TOP TAB
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.off(() => ReservationsScreen());
                      },
                      child: _productTabButton("Booking", false),
                    ),
                    const SizedBox(width: 20),
                    _productTabButton("Products", true),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(thickness: 2),
                const SizedBox(height: 15),

                /// BUTTONS (my cart / my orders)
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _tabButton("my cart", tabController.showCart.value),
                      _tabButton("my orders", !tabController.showCart.value),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                Expanded(
                  child: Obx(() {
                    if (tabController.showCart.value) {
                      return _buildCartContent();
                    } else {
                      return _buildOrdersContent();
                    }
                  }),
                ),
              ],
            ),

            Obx(
              () => tabController.showCart.value
                  ? Positioned(
                      left: 10,
                      bottom: 10,
                      child: GestureDetector(
                        onTap: _orderNow,
                        child: Container(
                          width: 150,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEDB6A),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total: ${cartController.totalAmount.value.toStringAsFixed(2)}\$",
                                style: const TextStyle(fontSize: 18),
                              ),
                              const Text(
                                "Order Now",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCartContent() {
    if (cartController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (cartController.cartItems.isEmpty) {
      return const Center(child: Text('السلة فارغة'));
    }
    return ListView.builder(
      itemCount: cartController.cartItems.length,
      itemBuilder: (context, index) {
        final item = cartController.cartItems[index];
        return _productCard(item, index);
      },
    );
  }

  // ============================================================
  // محتوى الطلبات
  // ============================================================
  Widget _buildOrdersContent() {
    if (ordersController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (ordersController.orders.isEmpty) {
      return const Center(child: Text('لا توجد طلبات'));
    }
    return ListView.builder(
      itemCount: ordersController.orders.length,
      itemBuilder: (context, index) {
        final order = ordersController.orders[index];
        return _orderCard(order);
      },
    );
  }

  // ============================================================
  // بطاقة الطلب
  // ============================================================
  Widget _orderCard(Map<String, dynamic> order) {
    final int orderId = order['id'] ?? 0;
    final String status = order['status'] ?? '';
    final String date = order['created_at'] ?? '';
    final String total = order['final_amount'] ?? '0';

    Color statusColor;
    switch (status) {
      case 'confirmed':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        if (orderId > 0) {
          Get.to(() => OrderDetailsScreen(orderId: orderId));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF591C27), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'طلب #$orderId',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('التاريخ: $date'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'الحالة: $status',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$total JOD',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF591C27),
                  ),
                ),
                const SizedBox(height: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // بطاقة المنتج (مثل السابق)
  // ============================================================
  Widget _productCard(Map<String, dynamic> item, int index) {
    final String name = item['name'] ?? '';
    final String rawImageUrl = item['main_image'] ?? '';
    final double unitPrice = (item['unit_price'] ?? 0.0).toDouble();
    final int quantity = item['quantity'] ?? 1;
    final double lineTotal = (item['line_total'] ?? 0.0).toDouble();
    final int stock = item['stock_available'] ?? 0;

    final bool hasImage = _hasValidBackendImage(rawImageUrl);
    final String fullImageUrl = hasImage ? _getFullImageUrl(rawImageUrl) : '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF591C27), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              width: 82,
              height: 82,
              color: Colors.grey[200],
              child: hasImage && fullImageUrl.isNotEmpty
                  ? Image.network(
                      fullImageUrl,
                      width: 82,
                      height: 82,
                      fit: BoxFit.cover,
                      headers: const {
                        'User-Agent':
                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 82,
                          height: 82,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Unit: ${unitPrice.toStringAsFixed(2)}\$",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (quantity > 1) {
                          cartController.updateQuantity(index, quantity - 1);
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7A2330),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "-",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "$quantity",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        if (quantity < stock) {
                          cartController.updateQuantity(index, quantity + 1);
                        } else {
                          Get.snackbar('تنبيه', 'الكمية المتاحة هي $stock');
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7A2330),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "+",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                onPressed: () => cartController.removeItem(index),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const Text(
                "تاريخ: --",
                style: TextStyle(
                  color: Color(0xFF591C27),
                  fontSize: 16,
                ),
              ),
              const Text(
                "وقت: --",
                style: TextStyle(
                  color: Color(0xFF591C27),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "${lineTotal.toStringAsFixed(2)}\$",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),]
        ),
      );
    
  }

  // ============================================================
  // دوال مساعدة للـ Tabs
  // ============================================================

  // ملاحظة: تم تغيير static إلى غير static حتى نتمكن من استخدام tabController
  Widget _tabButton(String text, bool active) {
    return GestureDetector(
      onTap: () {
        if (text == "my cart") {
          tabController.toggleTab(true);
        } else {
          tabController.toggleTab(false);
          // تحديث الطلبات عند التبديل إلى الطلبات
          if (!tabController.showCart.value) {
            ordersController.refreshOrders();
          }
        }
      },
      child: Container(
        width: 120,
        height: 42,
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: active ? const Color(0xFF591C27) : Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  // _productTabButton تبقى static لأنها لا تعتمد على حالة الشاشة
  static Widget _productTabButton(String text, bool active) {
    return Container(
      width: 125,
      height: 42,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: active ? const Color(0xFF591C27) : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Bottom Navigation
  // ============================================================
  Widget _buildBottomNav() {
    return Obx(
      () => Container(
        height: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: homeController.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF591C27),
          unselectedItemColor: const Color(0xFF591C27),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            homeController.changeIndex(index);
            if (index == 0) Get.off(() => HomeScreen());
            if (index == 1) Get.off(() => ExploreScreen());
            if (index == 2) Get.off(() => Conversationsscreen());
            if (index == 3) Get.off(() => ReservationsScreen());
            if (index == 4) Get.off(() => SettingScreen());
          },
          items: [
            BottomNavigationBarItem(
              icon: ImageButtonWidget(imagePath: ImageAssets.home),
              activeIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ImageButtonWidget2(
                    imagePath: ImageAssets.BottomNavigationBar6),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageButtonWidget(imagePath: ImageAssets.BottomNavigationBar2),
              activeIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ImageButtonWidget2(imagePath: ImageAssets.Frame1),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageButtonWidget(imagePath: ImageAssets.BottomNavigationBar3),
              activeIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ImageButtonWidget2(imagePath: ImageAssets.Frame2),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageButtonWidget(imagePath: ImageAssets.BottomNavigationBar4),
              activeIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ImageButtonWidget2(imagePath: ImageAssets.Frame3),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageButtonWidget(imagePath: ImageAssets.BottomNavigationBar5),
              activeIcon: Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: ImageButtonWidget2(imagePath: ImageAssets.Frame4),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}