import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class ProviderPostsService {
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
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException catch (e) {
      print("❌ Dio Error (provider posts): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في الاتصال',
      };
    } catch (e) {
      print("❌ Error (provider posts): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع',
      };
    }
  }
}