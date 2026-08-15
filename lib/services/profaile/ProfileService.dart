import 'package:dio/dio.dart';
import '../../api/api.dart';

class ProfileService {

  Future<Response> getProfile() async {

    return await Api().dio.get(
      "/api/customer/auth/profile",
    );

  }

  Future<Response> updateProfile({

    required String fullName,
    required String phone,
    required String birthDate,
    required String profilePhoto,
    required String governorate,
    required String city,
    required bool notificationsEnabled,
    required String language,

  }) async {

    return await Api().dio.post(

       "/api/customer/auth/update_profile",

      data: {

        "full_name": fullName,
        "phone": phone,
        "birth_date": birthDate,
        "governorate": governorate,
        "city": city,
        "profile_photo": profilePhoto,
        "notifications_enabled": notificationsEnabled,
        "language": language,

      },

    );

  }

}