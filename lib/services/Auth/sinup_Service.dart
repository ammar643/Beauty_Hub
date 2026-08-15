import 'package:dio/dio.dart';
import 'package:project_user/api/api.dart';

class SinupService {

  final Dio dio = Api().dio;


  Future<Response> register({

    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required String birthday,
    required String gender,

  }) async {


    final response = await dio.post(
      "/api/customer/auth/register",

     data: {

"full_name": "$firstName $lastName",
"phone": phone,
"email": email,
"password": password,
"password_confirmation": password,
"birth_date": birthday,
"gender": gender,

},

    );


    return response;

  }

}