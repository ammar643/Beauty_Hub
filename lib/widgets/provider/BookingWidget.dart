import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/controllers/home/bookingController.dart';
import 'package:project_user/controllers/provider_details_controller.dart';

class BookingWidget extends StatelessWidget {
  final String providerType;
  final int providerId;
  final String name;
  final String typeLabel;
  final double rating;
  final String? imageUrl;

  const BookingWidget({
    super.key,
    required this.providerType,
    required this.providerId,
    required this.name,
    required this.typeLabel,
    required this.rating,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.find<BookingController>();
    final ProviderDetailsController detailsController =
        Get.find<ProviderDetailsController>();

    bookingController.providerType.value = providerType;
    bookingController.providerId.value = providerId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== اختيار التاريخ =====
        Row(
          children: [
            const Text('التاريخ:'),
            const SizedBox(width: 10),
            Expanded(
              child: Obx(() {
                final dateText = bookingController.selectedDate.value;
                return GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (date != null) {
                      final dateStr = date.toIso8601String().split('T').first;
                      bookingController.selectedDate.value = dateStr;
                      if (bookingController.employeeId.value != 0 &&
                          bookingController.serviceIds.isNotEmpty) {
                        bookingController.fetchAvailableTimes();
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            dateText.isNotEmpty ? dateText : 'اختر التاريخ',
                            style: TextStyle(
                              color: dateText.isNotEmpty
                                  ? Colors.black
                                  : Colors.grey.shade500,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Color(0xFF591C27),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ===== اختيار الموظف =====
        Obx(() {
          final employees = detailsController.employees;
          final isLoading = detailsController.isLoadingEmployees.value;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (employees.isEmpty) {
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
            items: employees.map((employee) {
              return DropdownMenuItem<int>(
                value: employee['id'],
                child: Text(employee['full_name'] ?? 'موظف'),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                bookingController.employeeId.value = value;
                if (bookingController.selectedDate.value.isNotEmpty &&
                    bookingController.serviceIds.isNotEmpty) {
                  bookingController.fetchAvailableTimes();
                }
              }
            },
          );
        }),
        const SizedBox(height: 12),

        // ===== اختيار الخدمات =====
        const Text(
          'اختر الخدمات:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final servicesList = detailsController.services;
          if (detailsController.isLoadingServices.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (servicesList.isEmpty) {
            return const Text('لا توجد خدمات متاحة');
          }
          return Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: servicesList.map((service) {
              final serviceId = service['id'];
              final serviceName = service['name'] ?? 'خدمة';
              final isSelected = bookingController.serviceIds.contains(
                serviceId,
              );
              return ChoiceChip(
                label: Text(serviceName),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    bookingController.serviceIds.add(serviceId);
                  } else {
                    bookingController.serviceIds.remove(serviceId);
                  }
                  if (bookingController.selectedDate.value.isNotEmpty &&
                      bookingController.employeeId.value != 0) {
                    bookingController.fetchAvailableTimes();
                  }
                },
                selectedColor: const Color(0xFF591C27),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                backgroundColor: Colors.grey[200],
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 12),

        // ===== الأوقات المتاحة (مع التصحيح) =====
        Expanded(
          child: Obx(() {
            if (bookingController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            final slots = bookingController.slots;
            if (slots.isEmpty) {
              return const Center(
                child: Text('لا توجد مواعيد متاحة لهذا اليوم'),
              );
            }
            // ✅ اقرأ selectedTime هنا ليتم تتبعه
            final selectedTime = bookingController.selectedTime.value;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              itemCount: slots.length,
              itemBuilder: (context, index) {
                final slot = slots[index];
                final isSelected = slot['start_time'] == selectedTime;
                final available = slot['available'] == true;
                return GestureDetector(
                  onTap: available
                      ? () => bookingController.selectSlot(slot)
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff5A1824)
                          : available
                          ? Colors.white
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xffEFD96F)
                            : Colors.transparent,
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
                          const Icon(
                            Icons.block,
                            color: Color(0xff5A1824),
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),

        const SizedBox(height: 12),

        // ===== زر الحجز مع عرض الوقت المختار =====
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              final selected = bookingController.selectedSlot.value;
              if (selected == null) {
                return const Text(
                  'لم يتم اختيار موعد',
                  style: TextStyle(color: Colors.grey),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الموعد المختار:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${selected['start_time']} - ${selected['end_time']}',
                    style: const TextStyle(
                      color: Color(0xFF591C27),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              );
            }),
            Obx(() {
              return ElevatedButton(
                onPressed: bookingController.isSending.value
                    ? null
                    : bookingController.book,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffEFD96F),
                  foregroundColor: const Color(0xff5A1824),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                ),
                child: bookingController.isSending.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Color(0xff5A1824),
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Book Now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
