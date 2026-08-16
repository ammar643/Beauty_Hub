import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class EmployeeService {
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
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException catch (e) {
      print("❌ Dio Error (employees): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في الاتصال',
      };
    } catch (e) {
      print("❌ Error (employees): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع',
      };
    }
  }
}