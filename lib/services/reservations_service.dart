import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class ReservationsService {
  // ================= جلب الحجوزات القادمة =================
  Future<Map<String, dynamic>?> fetchUpcomingBookings() async {
    try {
      final response = await Api().dio.get(
        '/api/customer/bookings/upcoming',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>?;
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في جلب الحجوزات',
      };
    }
  }
  // lib/services/reservations_service.dart

// ================= إلغاء حجز =================
Future<Map<String, dynamic>?> cancelBooking(int bookingId) async {
  try {
    final response = await Api().dio.post(
      '/api/customer/bookings/$bookingId/cancel',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    return response.data as Map<String, dynamic>?;
  } on DioException catch (e) {
    return {
      'success': false,
      'message': e.response?.data['message'] ?? 'فشل إلغاء الحجز',
    };
  }
}
}