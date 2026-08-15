import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class VerificationService {

  final Dio dio = Api().dio;


  Future<Response> verifyOtp({
    required String email,
    required String otp,
  }) async {


    return await dio.post(
      "/api/customer/auth/verify_otp",

      data: {

        "email": email,
        "otp": otp,

      },

    );

  }

}