// lib/services/order_service.dart
import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class OrderService {
  final Dio _dio = Api().dio;

  // ============================================================
  // جلب قائمة الطلبات
  // ============================================================
  Future<Map<String, dynamic>?> getOrders() async {
    try {
      final response = await _dio.get(
        '/api/customer/orders',
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب الطلبات',
      };
    }
  }

  // ============================================================
  // جلب تفاصيل طلب معين
  // ============================================================
  Future<Map<String, dynamic>?> getOrderDetails(int orderId) async {
    try {
      final response = await _dio.get(
        '/api/customer/orders/$orderId',
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب تفاصيل الطلب',
      };
    }
  }
  Future<Map<String, dynamic>?> cancelOrder(int orderId) async {
    try {
      final response = await _dio.post(
        '/api/customer/orders/$orderId/cancel',
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
        'message': e.response?.data['message'] ?? 'خطأ في إلغاء الطلب',
      };
    }
  }
}