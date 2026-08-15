import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/services/profaile/ProfileService.dart';



class ProfileController extends GetxController {
  final ProfileService service = ProfileService();

  bool isLoading = false;

  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController birthDate = TextEditingController();

  String profilePhoto = "";

  String governorate = "";
  String city = "";

  bool notificationsEnabled = true;

  String language = "ar";

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {
    try {
      isLoading = true;
      update();

      final response = await service.getProfile();

      if (response.statusCode == 200) {
        final data = response.data["data"];

        fullName.text = data["full_name"] ?? "";

        phone.text = data["phone"] ?? "";

        birthDate.text =
            (data["birth_date"] ?? "").toString().split("T").first;

        profilePhoto = data["profile_photo"] ?? "";

        governorate = data["governorate"] ?? "";

        city = data["city"] ?? "";

        notificationsEnabled =
            data["notifications_enabled"] ?? true;

        language = data["language"] ?? "ar";
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }

    isLoading = false;
    update();
  }

  Future<void> updateProfile() async {
    try {
      isLoading = true;
      update();

      final response = await service.updateProfile(
        fullName: fullName.text,
        phone: phone.text,
        birthDate: birthDate.text,
        profilePhoto: profilePhoto,
        governorate: governorate,
        city: city,
        notificationsEnabled: notificationsEnabled,
        language: language,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          response.data["message"],
        );

        getProfile();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }

    isLoading = false;
    update();
  }

  void changePhoto(String url) {
    profilePhoto = url;
    update();
  }


@override
void onClose() {
  fullName.dispose();
  phone.dispose();
  birthDate.dispose();
  super.onClose();
}


}