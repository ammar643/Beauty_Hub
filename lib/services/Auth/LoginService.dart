import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class LoginService {

  final Dio dio = Api().dio;



Future<Response> guestLogin() async {
 return await dio.post(
  "/api/customer/auth/guest_login",
  data: {
    "device_token": "device-token",
  },
);
}



  Future<Response> login({

    required String email,
    required String password,

  }) async {


    return await dio.post(

      "/api/customer/auth/login",

      data: {

        "email": email,
        "password": password,

      },

    );

  }

}