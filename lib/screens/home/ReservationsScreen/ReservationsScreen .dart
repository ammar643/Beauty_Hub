import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/controllers/reservations_controller.dart';
import 'package:project_user/screens/ConversationsScreen.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/AcceptedReservationsScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/CanceledReservationsScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationProductsScreen.dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/home/homeScreen.dart';
import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

class ReservationsScreen extends StatelessWidget {
  ReservationsScreen({super.key});

  final HomeController homeController = Get.find();
  final ReservationsController reservationsController = Get.put(
    ReservationsController(),
  );

  @override
  Widget build(BuildContext context) {
    homeController.changeIndex(3);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),

            // TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Reservations",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // TOP TABS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _productTabButton("Booking", true),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Get.off(() => ReservationProductsScreen());
                  },
                  child: _productTabButton("Products", false),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(thickness: 2),
            const SizedBox(height: 15),

            // STATUS BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _statusButton("pending", true),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Get.off(() => AcceptedReservationsScreen());
                  },
                  child: _statusButton("accept", false),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Get.off(() => CanceledReservationsScreen());
                  },
                  child: _statusButton("cancel", false),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // RESERVATIONS LIST
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => reservationsController.refreshBookings(),
                child: Obx(() {
                  if (reservationsController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final bookings = reservationsController.bookings;
                  if (bookings.isEmpty) {
                    return const Center(
                      child: Text(
                        'لا توجد حجوزات قادمة',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return _buildReservationCard(booking);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: Obx(
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
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xFF591C27),
            unselectedItemColor: const Color(0xFF591C27),
            onTap: (index) {
              homeController.changeIndex(index);
              if (index == 0)
                Get.off(() => HomeScreen());
              else if (index == 1)
                Get.off(() => ExploreScreen());
              else if (index == 2)
                Get.off(() => Conversationsscreen());
              else if (index == 3)
                Get.off(() => ReservationsScreen());
              else if (index == 4)
                Get.off(() => SettingScreen());
            },
            items: [
              BottomNavigationBarItem(
                icon: ImageButtonWidget(imagePath: ImageAssets.home),
                activeIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ImageButtonWidget2(
                    imagePath: ImageAssets.BottomNavigationBar6,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar2,
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ImageButtonWidget2(imagePath: ImageAssets.Frame1),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar3,
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ImageButtonWidget2(imagePath: ImageAssets.Frame2),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar4,
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ImageButtonWidget2(imagePath: ImageAssets.Frame3),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar5,
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 5),
                  child: ImageButtonWidget2(imagePath: ImageAssets.Frame4),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== Status Button =====
  static Widget _statusButton(String text, bool active) {
    return Container(
      width: 95,
      height: 40,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: active ? const Color(0xFF6A2431) : Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ===== Product Tab Button =====
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

  // ===== Booking Card =====
  Widget _buildReservationCard(Map<String, dynamic> booking) {
    // استخراج البيانات
    final String providerType = booking['provider_type'] ?? 'salon';
    final String bookingDate = booking['booking_date'] ?? '';
    final String startTime = booking['start_time'] ?? '';
    final String endTime = booking['end_time'] ?? '';
    final String status = booking['status'] ?? 'pending';
    final String totalPrice = booking['total_price'] ?? '0';
    final String remainingAmount = booking['remaining_amount'] ?? '0';
    final String notes = booking['notes'] ?? '';
    final int bookingId = booking['id'] ?? 0;

    // تنسيق التاريخ
    String formattedDate = bookingDate;
    if (bookingDate.isNotEmpty) {
      try {
        final date = DateTime.parse(bookingDate);
        formattedDate = '${date.day}/${date.month}/${date.year}';
      } catch (e) {
        formattedDate = bookingDate;
      }
    }

    // تنسيق الوقت (إزالة الثواني)
    String formattedStart = startTime;
    if (startTime.isNotEmpty && startTime.length >= 5) {
      formattedStart = startTime.substring(0, 5);
    }
    String formattedEnd = endTime;
    if (endTime.isNotEmpty && endTime.length >= 5) {
      formattedEnd = endTime.substring(0, 5);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffDBDBDB),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.testphoto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      providerType == 'salon'
                          ? 'صالون'
                          : providerType == 'beauty_center'
                          ? 'مركز'
                          : 'خبير',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'رقم الحجز: ${booking['id']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(color: Color(0xFF591C27)),
                  ),
                  Text(
                    '$formattedStart - $formattedEnd',
                    style: const TextStyle(
                      color: Color(0xFF591C27),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'السعر الإجمالي: $totalPrice JOD | المتبقي: $remainingAmount JOD',
              style: const TextStyle(fontSize: 14),
            ),
          ),
          if (notes.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ملاحظات: $notes',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (status != 'cancelled')
                Obx(() {
                  final isCancelling =
                      reservationsController.isCancelling.value;
                  return GestureDetector(
                    onTap: isCancelling
                        ? null
                        : () => _confirmCancel(bookingId),
                    child: Container(
                      width: 100,
                      height: 38,
                      decoration: BoxDecoration(
                        color: isCancelling
                            ? Colors.grey
                            : const Color(0xFF7A2330),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: isCancelling
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'إلغاء',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  );
                }),
              const SizedBox(width: 12),
              Container(
                width: 100,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "تفاصيل",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmCancel(int bookingId) {
    Get.dialog(
      AlertDialog(
        title: const Text('تأكيد الإلغاء'),
        content: const Text('هل أنت متأكد من إلغاء هذا الحجز؟'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('تراجع')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              reservationsController.cancelBooking(bookingId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF591C27),
              foregroundColor: Colors.white,
            ),
            child: const Text('تأكيد الإلغاء'),
          ),
        ],
      ),
    );
  }
}
