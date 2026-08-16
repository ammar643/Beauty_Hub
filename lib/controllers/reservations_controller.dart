import 'package:get/get.dart';
import 'package:project_user/services/reservations_service.dart';

class ReservationsController extends GetxController {
  final ReservationsService _service = ReservationsService();

  var isLoading = true.obs;
  var bookings = <Map<String, dynamic>>[].obs;
var isCancelling = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    isLoading.value = true;
    final result = await _service.fetchUpcomingBookings();
    if (result != null && result['success'] == true) {
      bookings.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      bookings.clear();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل الحجوزات');
    }
    isLoading.value = false;
  }

  Future<void> refreshBookings() async {
    await fetchBookings();
  }
  // lib/controllers/reservations_controller.dart


Future<void> cancelBooking(int bookingId) async {
  isCancelling.value = true;
  final result = await _service.cancelBooking(bookingId);
  isCancelling.value = false;

  if (result != null && result['success'] == true) {
    Get.snackbar('نجاح', 'تم إلغاء الحجز بنجاح');
    await fetchBookings();
  } else {
    Get.snackbar('خطأ', result?['message'] ?? 'فشل إلغاء الحجز');
  }
}
}