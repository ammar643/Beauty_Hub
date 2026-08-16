import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class ExploreService {
  Future<List<dynamic>?> fetchSalons({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/providers/top-rated/salons',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        return data['data'] as List<dynamic>?;
      }
      return null;
    } on DioException catch (e) {
      print("❌ Dio Error (salons): ${e.message}");
      return null;
    } catch (e) {
      print("❌ Error (salons): $e");
      return null;
    }
  }

  Future<List<dynamic>?> fetchBeautyCenters({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/providers/top-rated/beauty-centers',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        return data['data'] as List<dynamic>?;
      }
      return null;
    } on DioException catch (e) {
      print("❌ Dio Error (beauty centers): ${e.message}");
      return null;
    } catch (e) {
      print("❌ Error (beauty centers): $e");
      return null;
    }
  }

  Future<List<dynamic>?> fetchExperts({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/providers/top-rated/experts',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        return data['data'] as List<dynamic>?;
      }
      return null;
    } on DioException catch (e) {
      print("❌ Dio Error (experts): ${e.message}");
      return null;
    } catch (e) {
      print("❌ Error (experts): $e");
      return null;
    }
  }
// lib/services/explore_service.dart

Future<Map<String, dynamic>?> fetchCategories() async {
  try {
    final response = await Api().dio.get(
      '/api/customer/products/categories',
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
      'message': e.response?.data['message'] ?? 'خطأ في جلب التصنيفات',
    };
  }
}
    Future<Map<String, dynamic>?> fetchProducts({int limit = 50}) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/products',
        queryParameters: {'limit': limit},
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب المنتجات',
      };
    }
  }
   Future<Map<String, dynamic>?> toggleFavorite({
    required String providerType,
    required int providerId,
  }) async {
    try {
      final response = await Api().dio.post(
        '/api/customer/providers/$providerType/$providerId/favorite',
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
        'message': e.response?.data['message'] ?? 'خطأ في تبديل المفضلة',
      };
    }
  }





  

  Future<Map<String, dynamic>?> fetchProductDetails(int productId) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/products/$productId',
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب تفاصيل المنتج',
      };
    }
  }
}
