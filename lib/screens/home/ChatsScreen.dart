import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationsScreen%20.dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/home/homeScreen.dart';

import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});

  final HomeController controller = Get.find();

  final List<String> follows = [
    ImageAssets.testphoto,
    ImageAssets.onbording1,
    ImageAssets.onbording2,
    ImageAssets.Rectangle,
  ];

  @override
  Widget build(BuildContext context) {
    // controller.currentIndex.value = 2;
controller.changeIndex(2);
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            // FOLLOWS TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Follows",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // FOLLOWS LIST
            SizedBox(
              height: 85,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: follows.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 12),
                    width: 75,
                    height: 75,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(follows[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // CHATS TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // CHATS LIST
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildChatCard();
                },
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
            selectedItemColor: const Color(0xFF591C27),
            unselectedItemColor: const Color(0xFF591C27),
            showSelectedLabels: false,
            showUnselectedLabels: false,

            onTap: (index) {
              controller.changeIndex(index);

              if (index == 0) {
                Get.off(() => HomeScreen());
              }

              if (index == 1) {
                Get.off(() => ExploreScreen());
              }

              if (index == 2) {
                Get.off(() => ChatsScreen());
              }
              if (index == 3) {
  Get.to(() => ReservationsScreen());
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
                  padding: const EdgeInsets.only(left: 10),
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
                  padding: const EdgeInsets.only(left: 10),
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
                  padding: const EdgeInsets.only(left: 10),
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
                  padding: const EdgeInsets.only(left: 10),
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
                  padding:
                      const EdgeInsets.only(left: 10, right: 5),
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
  }

  Widget _buildChatCard() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffECECEC),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(ImageAssets.testphoto),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Lojain Aljohari",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xFF591C27),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Hello, how are yo.....",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const Align(
            alignment: Alignment.topRight,
            child: Text(
              "17/5/2026",
              style: TextStyle(
                color: Color(0xFF591C27),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}