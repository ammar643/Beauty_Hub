import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class ChatService {
  Future<Map<String, dynamic>?> openChat({
    required String otherType,
    required int otherId,
  }) async {
    try {
      final response = await Api().dio.post(
        '/api/customer/chats/open',
        data: {'other_type': otherType, 'other_id': otherId},
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
        'message': e.response?.data['message'] ?? 'خطأ في فتح المحادثة',
      };
    }
  }

  Future<Map<String, dynamic>?> fetchMessages({required int chatId}) async {
    try {
      final response = await Api().dio.get(
        '/api/customer/chats/$chatId/messages',
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب الرسائل',
      };
    }
  }

  Future<Map<String, dynamic>?> sendMessage({
    required int chatId,
    required String content,
  }) async {
    try {
      final response = await Api().dio.post(
        '/api/customer/chats/$chatId/messages',
        data: {'content': content},
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
        'message': e.response?.data['message'] ?? 'خطأ في إرسال الرسالة',
      };
    }
  }

  Future<Map<String, dynamic>?> sendImageMessage({
    required int chatId,
    required String imagePath,
  }) async {
    try {
      // تحديد نوع الملف من الامتداد
      String mimeType = 'image/jpeg';
      final ext = imagePath.split('.').last.toLowerCase();
      if (ext == 'png')
        mimeType = 'image/png';
      else if (ext == 'gif')
        mimeType = 'image/gif';
      else if (ext == 'webp')
        mimeType = 'image/webp';
      // أضف أنواعاً أخرى حسب الحاجة

      final formData = FormData.fromMap({
        'message_type': 'image',
        'media': await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
          contentType: DioMediaType.parse(mimeType), // ✅ تحديد النوع هنا
        ),
      });

      final response = await Api().dio.post(
        '/api/customer/chats/$chatId/messages',
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );
      return response.data as Map<String, dynamic>?;
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في إرسال الصورة',
      };
    }
  }

  // ================= إرسال رسالة بصورة =================
  Future<Map<String, dynamic>?> fetchConversations() async {
    try {
      final response = await Api().dio.get(
        '/api/customer/chats',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data as Map<String, dynamic>?;
    } on DioException catch (e) {
      print("❌ Dio Error (chats): ${e.message}");
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'خطأ في جلب المحادثات',
      };
    }
  }
}
