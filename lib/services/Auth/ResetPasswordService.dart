import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class ResetPasswordService {
  Api api = Api();

  Future<Response> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    Response response = await api.dio.post(
      "/api/customer/auth/reset_password", // 
     data: {
  "email": email,
  "otp": otp,
  "new_password": password,
  "new_password_confirmation": confirmPassword,
}
    );

    return response;
  }
}