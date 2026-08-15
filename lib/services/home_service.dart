import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class HomeService {
  // ================= جلب بيانات الصفحة الرئيسية =================
  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      final response = await Api().dio.get(
        '/api/customer/home',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        return {
          'success': false,
          'message': 'استجابة غير متوقعة من الخادم',
        };
      }
    } on DioException catch (e) {
      print("❌ Dio Error (home): ${e.message}");
      print("❌ Response Data: ${e.response?.data}");

      if (e.response?.data is Map<String, dynamic>) {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'خطأ في الاتصال بالخادم',
        };
      }
      return {
        'success': false,
        'message': 'خطأ في الاتصال بالخادم',
      };
    } catch (e) {
      print("❌ Error (home): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع: $e',
      };
    }
  }

  // ================= (اختياري) جلب الصالونات الأعلى تقييماً =================
  Future<Map<String, dynamic>?> fetchTopSalons() async {
    try {
      final response = await Api().dio.get(
        '/api/customer/providers/top-rated/salons',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print("❌ Dio Error (top salons): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في الاتصال',
      };
    } catch (e) {
      print("❌ Error (top salons): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع: $e',
      };
    }
  }

  // ================= (اختياري) جلب مراكز التجميل الأعلى تقييماً =================
  Future<Map<String, dynamic>?> fetchTopBeautyCenters() async {
    try {
      final response = await Api().dio.get(
        '/api/customer/providers/top-rated/beauty-centers',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print("❌ Dio Error (top beauty centers): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في الاتصال',
      };
    } catch (e) {
      print("❌ Error (top beauty centers): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع: $e',
      };
    }
  }

  // ================= (اختياري) جلب الخبراء الأعلى تقييماً =================
  Future<Map<String, dynamic>?> fetchTopExperts() async {
    try {
      final response = await Api().dio.get(
        '/api/customer/providers/top-rated/experts',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print("❌ Dio Error (top experts): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في الاتصال',
      };
    } catch (e) {
      print("❌ Error (top experts): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع: $e',
      };
    }
  }

  // ================= (اختياري) جلب المنشورات =================
  Future<Map<String, dynamic>?> fetchPosts() async {
    try {
      final response = await Api().dio.get(
        '/api/customer/feed/posts',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print("❌ Dio Error (posts): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في الاتصال',
      };
    } catch (e) {
      print("❌ Error (posts): $e");
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع: $e',
      };
    }
  }
}