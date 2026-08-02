import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class ForgotPasswordService {
  final Dio dio = Api().dio;

  Future<Response> forgotPassword({
    required String email,
  }) async {
    return await dio.post(
      "/api/customer/auth/forgot_password", // 
      data: {
        "email": email,
      },
    );
  }
}