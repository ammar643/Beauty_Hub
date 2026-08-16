import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class AuthService {
  final Dio _dio = Api().dio;

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/customer/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      print("✅ Login response: ${response.data}");

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        return {
          'success': false,
          'message': 'استجابة غير متوقعة من الخادم',
        };
      }
    } on DioException catch (e) {
      print("❌ Login error: ${e.message}");
      print("❌ Response: ${e.response?.data}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'فشل تسجيل الدخول',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع',
      };
    }
  }
}