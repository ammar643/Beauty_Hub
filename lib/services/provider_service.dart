import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class ProviderService {
  // ================= جلب المنشورات =================
  Future<Map<String, dynamic>?> fetchPosts({
    required String providerType,
    required int providerId,
  }) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/providers/$providerType/$providerId/posts',
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب المنشورات',
      };
    }
  }

  // ================= جلب الموظفين =================
  Future<Map<String, dynamic>?> fetchEmployees({
    required String providerType,
    required int providerId,
  }) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/providers/$providerType/$providerId/employees',
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب الموظفين',
      };
    }
  }

  // ================= تبديل المتابعة =================
  Future<Map<String, dynamic>?> toggleFollow({
    required String providerType,
    required int providerId,
  }) async {
    try {
      final response = await Api().dio.post(
        '/api/customer/providers/$providerType/$providerId/follow',
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
        'message': e.response?.data['message'] ?? 'خطأ في تغيير المتابعة',
      };
    }
  }

  // ================= جلب الأوقات المتاحة للحجز =================
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
  // ================= جلب خدمات المزود =================
Future<Map<String, dynamic>?> fetchServices({
  required String providerType,
  required int providerId,
}) async {
  try {
    final response = await Api().dio.get(
      '/api/customer/providers/$providerType/$providerId/services',
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
      'message': e.response?.data['message'] ?? 'خطأ في جلب الخدمات',
    };
  }
}
}