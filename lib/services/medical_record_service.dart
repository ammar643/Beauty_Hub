import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class MedicalRecordService {
  // ================= جلب السجل الطبي =================
  Future<Map<String, dynamic>?> fetchMedicalRecord() async {
    try {
      final response = await Api().dio.get(
        '/api/customer/auth/medical_record',
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
        'message': e.response?.data['message'] ?? 'خطأ في جلب السجل الطبي',
      };
    }
  }

  // ================= تحديث السجل الطبي =================
  Future<Map<String, dynamic>?> updateMedicalRecord({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await Api().dio.post(
        '/api/customer/auth/medical_record',
        data: data,
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
        'message': e.response?.data['message'] ?? 'خطأ في تحديث السجل الطبي',
      };
    }
  }
}