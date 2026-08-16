import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/services/booking_service.dart';
import 'package:project_user/services/medical_record_service.dart';
import 'package:project_user/services/provider_service.dart';
import 'package:project_user/widgets/provider/medical_record_booking_dialog.dart';

class BookingController extends GetxController {
  final ProviderService _providerService = ProviderService();
  final MedicalRecordService _medicalService = MedicalRecordService();
  final BookingService _bookingService = BookingService();

  var isLoading = false.obs;
  var isSending = false.obs;
  var slots = <Map<String, dynamic>>[].obs;
  var selectedSlot = Rx<Map<String, dynamic>?>(null);
  var selectedTime = ''.obs;

  var providerType = ''.obs;
  var providerId = 0.obs;
  var employeeId = 0.obs;
  var selectedDate = ''.obs;
  var serviceIds = <int>[].obs;
  var employees = <Map<String, dynamic>>[].obs;

  var medicalRecord = <String, dynamic>{}.obs;
  var isLoadingMedicalRecord = false.obs;
  @override
  void onInit() {
    selectedSlot;
    // TODO: implement onInit
    super.onInit();
  }

  void selectSlot(Map<String, dynamic> slot) {
    print('✅ Selected time: ${slot['start_time']}'); // للتأكد
    selectedTime.value = slot['start_time'] ?? '';
    selectedSlot.value = slot;
  }
  // في BookingController

  // ===== جلب وعرض ملخص الحجز =====

  void _showSummaryDialog(Map<String, dynamic> data) {
    final selection = data['selection'] ?? {};
    final answers = data['answers'] ?? [];

    Get.dialog(
      AlertDialog(
        title: const Text('ملخص الحجز'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('نوع المزود: ${selection['provider_type'] ?? ''}'),
              Text('معرف المزود: ${selection['provider_id'] ?? ''}'),
              Text('الخدمة: ${selection['service_id'] ?? ''}'),
              Text('الموظف: ${selection['employee_id'] ?? ''}'),
              const Divider(),
              const Text('الإجابات:'),
              ...answers.map((answer) {
                return Text(
                  '• السؤال ${answer['question_id']}: ${answer['answer_text']}',
                );
              }).toList(),
              Text('تاريخ الإنشاء: ${selection['created_at'] ?? ''}'),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('إغلاق')),
        ],
      ),
    );
  }

  Future<void> fetchAvailableTimes() async {
    if (selectedDate.value.isEmpty ||
        employeeId.value == 0 ||
        serviceIds.isEmpty) {
      Get.snackbar('تنبيه', 'الرجاء تحديد جميع البيانات المطلوبة');
      return;
    }

    isLoading.value = true;
    final result = await _providerService.fetchAvailableTimes(
      providerType: providerType.value,
      providerId: providerId.value,
      date: selectedDate.value,
      employeeId: employeeId.value,
      serviceIds: serviceIds,
    );

    if (result != null && result['success'] == true) {
      slots.value =
          (result['data']['slots'] as List?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [];
      selectedTime.value = '';
      selectedSlot.value = null;
    } else {
      slots.clear();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل الأوقات المتاحة');
    }
    isLoading.value = false;
  }

  Future<void> fetchMedicalRecord() async {
    isLoadingMedicalRecord.value = true;
    final result = await _medicalService.fetchMedicalRecord();
    if (result != null && result['success'] == true) {
      medicalRecord.value = result['data'] as Map<String, dynamic>;
    } else {
      medicalRecord.value = {};
    }
    isLoadingMedicalRecord.value = false;
  }

  Future<bool> updateMedicalRecord(Map<String, dynamic> data) async {
    final result = await _medicalService.updateMedicalRecord(data: data);
    if (result != null && result['success'] == true) {
      await fetchMedicalRecord();
      return true;
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحديث السجل الطبي');
      return false;
    }
  }

  Future<void> book() async {
    if (selectedSlot.value == null) {
      Get.snackbar('تنبيه', 'الرجاء اختيار موعد');
      return;
    }
    await fetchMedicalRecord();
    _showMedicalRecordDialog();
  }

  void _showMedicalRecordDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: MedicalRecordBookingDialog(
          medicalRecord: medicalRecord.value,
          onConfirm: (updatedRecord) async {
            if (updatedRecord.isNotEmpty) {
              final success = await updateMedicalRecord(updatedRecord);
              if (!success) return;
            }
            await _completeBooking();
          },
          onSkip: () async {
            await _completeBooking();
          },
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _completeBooking() async {
    isSending.value = true;
    final answers = <Map<String, dynamic>>[];

    final result = await _bookingService.createBooking(
      providerType: providerType.value,
      providerId: providerId.value,
      employeeId: employeeId.value,
      bookingDate: selectedDate.value,
      startTime: selectedSlot.value?['start_time'] ?? '',
      serviceIds: serviceIds,
      answers: answers,
      notes: 'حجز من التطبيق',
      payDepositFromWallet: true,
    );

    isSending.value = false;

    if (result != null && result['success'] == true) {
      final data = result['data'];
      Get.back();
      _showSuccessDialog(data);
    } else {
      final errors = result?['errors'] ?? {};
      final errorMessage = result?['message'] ?? 'فشل إنشاء الحجز';
      String errorDetails = errorMessage;
      if (errors.isNotEmpty) {
        errorDetails = errors.values.join('\n');
      }
      Get.snackbar(
        'فشل الحجز',
        errorDetails,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }

  void _showSuccessDialog(Map<String, dynamic> data) {
    Get.dialog(
      AlertDialog(
        title: const Text('تم الحجز بنجاح! 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('رقم الحجز: ${data['booking_id']}'),
            Text('الحالة: ${data['status']}'),
            Text('السعر الإجمالي: ${data['total_price']}'),
            Text('المدفوع: ${data['deposit_amount']}'),
            Text('المتبقي: ${data['remaining_amount']}'),
            Text('وقت الانتهاء: ${data['end_time']}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('حسناً')),
        ],
      ),
    );
  }

  void setEmployees(List<Map<String, dynamic>> list) {
    employees.value = list;
    if (list.isNotEmpty) {
      employeeId.value = list.first['id'];
    }
  }

  void clear() {
    slots.clear();
    selectedSlot.value = null;
    //selectedTime.value = '';
  }
}
