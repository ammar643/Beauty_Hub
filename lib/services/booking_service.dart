import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class BookingService {
  Future<Map<String, dynamic>?> fetchAvailableTimes({
    required String providerType,
    required int providerId,
    required String date,
    required int employeeId,
    required List<int> serviceIds,
  }) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/providers/$providerType/$providerId/available-times',
        queryParameters: {
          'date': date,
          'employee_id': employeeId,
          'service_ids[]': serviceIds,
        },
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب الأوقات المتاحة',
      };
    }
  }

  Future<Map<String, dynamic>?> createBooking({
    required String providerType,
    required int providerId,
    required int employeeId,
    required String bookingDate,
    required String startTime,
    required List<int> serviceIds,
    required List<Map<String, dynamic>> answers,
    String? notes,
    bool payDepositFromWallet = true,
  }) async {
    try {
      final data = {
        'provider_type': providerType,
        'provider_id': providerId,
        'employee_id': employeeId,
        'booking_date': bookingDate,
        'start_time': startTime,
        'service_ids': serviceIds,
        'notes': notes ?? '',
        'pay_deposit_from_wallet': payDepositFromWallet,
        'answers': answers,
      };

      print('📤 Creating booking with data: $data');

      final response = await Api().dio.post(
        '/api/customer/bookings',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>?;
    } on DioException catch (e) {
      print('❌ Booking error: ${e.response?.data}');
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في إنشاء الحجز',
        'errors': e.response?.data['errors'],
      };
    }
  }
  // في lib/services/booking_service.dart


}