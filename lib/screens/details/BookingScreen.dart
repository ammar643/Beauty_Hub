import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/SalonController.dart';
import 'package:project_user/controllers/home/bookingController.dart';
import 'package:project_user/screens/details/PostsWidget.dart';
import 'package:project_user/screens/details/ReviewsWidget.dart';
import 'package:project_user/screens/details/SalonDetailsScreen.dart';
import 'package:project_user/screens/details/ShopWidget.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  final SalonController salonController = Get.find();
  final BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;

    final String name = args?['name'] ?? 'مزود الخدمة';
    final String typeLabel = args?['typeLabel'] ?? 'salon';
    final double rating = args?['rating'] ?? 0.0;
    final String? imageUrl = args?['imageUrl'];
    final int providerId = args?['id'] ?? 0;
    final String providerType = args?['type'] ?? 'salon';
    final List<int> serviceIds = (args?['serviceIds'] as List?)?.cast<int>() ?? [];
    final List<Map<String, dynamic>> employees = (args?['employees'] as List?)
        ?.map((e) => Map<String, dynamic>.from(e))
        .toList() ?? [];

    bookingController.providerType.value = providerType;
    bookingController.providerId.value = providerId;
    bookingController.serviceIds.value = serviceIds;
    if (employees.isNotEmpty) {
      bookingController.setEmployees(employees);
    }

    ImageProvider displayImage;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      displayImage = NetworkImage(
        imageUrl,
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
      ) as ImageProvider;
    } else {
      displayImage = AssetImage(ImageAssets.salonphoto);
    }

    return Scaffold(
      backgroundColor: const Color(0xff5A1824),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF591C27),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Expanded(child: Container(color: const Color(0xffF5F5F5))),
              ],
            ),

            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            Positioned(
              top: 120,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  typeLabel,
                                  style: const TextStyle(
                                    color: Color(0xff4B1A23),
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 45),
                                Text(
                                  rating.toStringAsFixed(1),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: -15,
                          child: Container(
                            width: 109,
                            height: 109,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              image: DecorationImage(
                                image: displayImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(5, (index) {
                          final tabs = ["Info", "Booking", "Reviews", "Posts", "Shop"];
                          return GestureDetector(
                            onTap: () {
                              salonController.changeTab(index);
                              if (index == 0) Get.to(() => SalonDetailsScreen());
                              else if (index == 2) Get.to(() => ReviewsWidget());
                              else if (index == 3) Get.to(() => PostsWidget());
                              else if (index == 4) Get.to(() => ShopWidget());
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: salonController.selectedTab.value == index
                                    ? const Color(0xff5A1824)
                                    : Colors.transparent,
                              ),
                              child: Text(
                                tabs[index],
                                style: TextStyle(
                                  color: salonController.selectedTab.value == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const Text('التاريخ:'),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'اختر التاريخ',
                              suffixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 30)),
                              );
                              if (date != null) {
                                bookingController.selectedDate.value =
                                    date.toIso8601String().split('T').first;
                                if (bookingController.employeeId.value != 0) {
                                  bookingController.fetchAvailableTimes();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Obx(() {
                      if (bookingController.employees.isEmpty) {
                        return const Text('لا يوجد موظفون متاحون');
                      }
                      return DropdownButtonFormField<int>(
                        value: bookingController.employeeId.value != 0
                            ? bookingController.employeeId.value
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'اختر الموظف',
                          border: OutlineInputBorder(),
                        ),
                        items: bookingController.employees.map((employee) {
                          return DropdownMenuItem<int>(
                            value: employee['id'],
                            child: Text(employee['full_name'] ?? 'موظف'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            bookingController.employeeId.value = value;
                            if (bookingController.selectedDate.value.isNotEmpty) {
                              bookingController.fetchAvailableTimes();
                            }
                          }
                        },
                      );
                    }),
                    const SizedBox(height: 12),

                    Obx(() {
                      if (bookingController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final slots = bookingController.slots;
                      if (slots.isEmpty) {
                        return const Text('لا توجد مواعيد متاحة لهذا اليوم');
                      }
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: slots.length,
                          itemBuilder: (context, index) {
                            final slot = slots[index];
                            final isSelected = bookingController.selectedSlot.value == slot;
                            final available = slot['available'] == true;
                            return GestureDetector(
                              onTap: available ? () => bookingController.selectSlot(slot) : null,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF591C27)
                                      : available
                                          ? Colors.white
                                          : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF591C27) : Colors.transparent,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      slot['start_time'] ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? Colors.white : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      slot['end_time'] ?? '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isSelected ? Colors.white70 : Colors.grey,
                                      ),
                                    ),
                                    if (!available)
                                      const Icon(Icons.block, color: Colors.red, size: 16),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          if (bookingController.selectedSlot.value == null) {
                            return const Text('لم يتم اختيار موعد');
                          }
                          return const Text('الموعد المختار:');
                        }),
                        ElevatedButton(
                          onPressed: bookingController.book,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffEFD96F),
                            foregroundColor: const Color(0xff5A1824),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                          ),
                          child: const Text('Book Now', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}