import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/controllers/profaile/ProfileController.dart';
import 'package:project_user/screens/ConversationsScreen.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationsScreen%20.dart';
import 'package:project_user/screens/home/homeScreen.dart';

import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final HomeController controller = Get.find();
final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    // controller.currentIndex.value = 4;
controller.changeIndex(4);
    return GetBuilder<ProfileController>(
  builder: (profile) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

     body: SafeArea(
  child: profile.isLoading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : Column(
          children: [
            const SizedBox(height: 35),

            const Text(
              "Setting",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // PROFILE IMAGE
            Stack(
              children: [
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                      )
                    ],
                   image: DecorationImage(
  fit: BoxFit.cover,
  image: profile.profilePhoto.isEmpty
      ?  AssetImage(ImageAssets.testphoto)
      : NetworkImage(profile.profilePhoto),
),
                  ),
                ),

                Positioned(
                  right: 0,
                  top: 5,
                  child: GestureDetector(
  onTap: () {
    // سنضيف تغيير الصورة لاحقًا
  },
  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: Color(0xFF7A2330),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  )
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xffECECEC),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // YOUR INFO
                      _buildInfoSection(profile),

                      const SizedBox(height: 20),

                      // SETTINGS
                      _buildSettingsSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: Obx(
        () => Container(
          height: 90,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xFF591C27),
            unselectedItemColor: const Color(0xFF591C27),

            onTap: (index) {
              controller.changeIndex(index);

              if (index == 0) {
                Get.off(() => HomeScreen());
              }

              if (index == 1) {
                Get.off(() => ExploreScreen());
              }

              if (index == 2) {
                Get.off(() => Conversationsscreen());
              }

              if (index == 3) {
                Get.off(() => ReservationsScreen());
              }

              if (index == 4) {
                Get.off(() => SettingScreen());
              }
            },

            items: [
              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.home,
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: ImageButtonWidget2(
                    imagePath: ImageAssets.BottomNavigationBar6,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar2,
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: ImageButtonWidget2(
                    imagePath: ImageAssets.Frame1,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar3,
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: ImageButtonWidget2(
                    imagePath: ImageAssets.Frame2,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar4,
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: ImageButtonWidget2(
                    imagePath: ImageAssets.Frame3,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar5,
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: ImageButtonWidget2(
                    imagePath: ImageAssets.Frame4,
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
       ),
    );
  },
);
  }

 Widget _buildInfoSection(ProfileController profile) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              "your information",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
          _buildInfo(
  "your name",
  profile.fullName,
),

_buildInfo(
  "your phone",
  profile.phone,
),

_buildInfo(
  "your birthdate",
  profile.birthDate,
),
const SizedBox(height: 20),

SizedBox(
  width: double.infinity,
  height: 45,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF7A2330),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    onPressed: () {
      profileController.updateProfile();
    },
    child: const Text(
      "Save Changes",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
        ],
      ),
    );
  }

 Widget _buildInfo(
  String title,
  TextEditingController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 15),

      Text(
        title,
        style: const TextStyle(color: Colors.grey),
      ),

      const SizedBox(height: 5),

     TextField(
  controller: controller,
  readOnly: title == "your birthdate",
  onTap: () async {
    if (title == "your birthdate") {
      DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
      );

      if (picked != null) {
        controller.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      }
    }
  },
  decoration: const InputDecoration(
    border: InputBorder.none,
    isDense: true,
  ),
  style:  TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
),
        
      

      const Divider(),

      const Align(
        alignment: Alignment.centerRight,
        child: Text(
          "click to change it",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}
  Widget _buildSettingsSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              "your setting",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 20),

          _buildButtonRow("Health record", "Your Favorite"),
          const SizedBox(height: 15),
          _buildButtonRow("the language", "English"),
          const SizedBox(height: 15),
          _buildButtonRow("The mode", "Light"),
          const SizedBox(height: 15),
          _buildButtonRow("Reset Password", "Logout"),
        ],
      ),
    );
  }

  Widget _buildButtonRow(String left, String right) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xffECECEC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xffECECEC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                right,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
     
 
  }
}