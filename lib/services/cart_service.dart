import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class CartService {
  final Dio _dio = Api().dio;

  // ============================================================
  Future<Map<String, dynamic>?> getCart() async {
    try {
      final response = await _dio.get(
        '/api/customer/cart',
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب السلة',
      };
    }
  }

  Future<Map<String, dynamic>?> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final response = await _dio.post(
        '/api/customer/cart/items',
        data: {
          'product_id': productId,
          'quantity': quantity,
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
        'message': e.response?.data['message'] ?? 'خطأ في إضافة المنتج إلى السلة',
      };
    }
  }

  Future<Map<String, dynamic>?> updateCartItem({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await _dio.put(
        '/api/customer/cart/items/$cartItemId',
        data: {'quantity': quantity},
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
        'message': e.response?.data['message'] ?? 'خطأ في تحديث الكمية',
      };
    }
  }

  Future<Map<String, dynamic>?> removeCartItem({
    required int cartItemId,
  }) async {
    try {
      final response = await _dio.delete(
        '/api/customer/cart/items/$cartItemId',
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
        'message': e.response?.data['message'] ?? 'خطأ في حذف العنصر',
      };
    }
  }

  Future<Map<String, dynamic>?> clearCart() async {
    try {
      final response = await _dio.delete(
        '/api/customer/cart/clear',
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
        'message': e.response?.data['message'] ?? 'خطأ في تفريغ السلة',
      };
    }
  }

  Future<Map<String, dynamic>?> checkout() async {
    try {
      final response = await _dio.post(
        '/api/customer/cart/checkout',
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
        'message': e.response?.data['message'] ?? 'خطأ في إتمام الطلب',
      };
    }
  }
}