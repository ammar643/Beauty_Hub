import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class ProviderPostsService {
  // ================= جلب منشورات المزود =================
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

  // ================= تبديل الإعجاب =================
  Future<Map<String, dynamic>?> toggleLike(int postId) async {
    try {
      final response = await Api().dio.post(
        '/api/customer/posts/$postId/like',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>?;
    } on DioException catch (e) {
      print("❌ Dio Error (toggle like): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في تبديل الإعجاب',
      };
    } catch (e) {
      print("❌ Error (toggle like): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع',
      };
    }
  }

  // ================= إضافة تعليق =================
  Future<Map<String, dynamic>?> addComment({
    required int postId,
    required String comment,
  }) async {
    try {
      final response = await Api().dio.post(
        '/api/customer/posts/$postId/comments',
        data: {'comment': comment},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>?;
    } on DioException catch (e) {
      print("❌ Dio Error (add comment): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في إضافة التعليق',
      };
    } catch (e) {
      print("❌ Error (add comment): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع',
      };
    }
  }

  // ================= جلب التعليقات =================
  Future<Map<String, dynamic>?> fetchComments(int postId) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/posts/$postId/comments',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>?;
    } on DioException catch (e) {
      print("❌ Dio Error (fetch comments): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في جلب التعليقات',
      };
    } catch (e) {
      print("❌ Error (fetch comments): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع',
      };
    }
  }
}