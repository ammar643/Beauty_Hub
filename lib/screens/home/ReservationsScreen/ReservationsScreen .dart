import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/screens/home/ChatsScreen.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/AcceptedReservationsScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/CanceledReservationsScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationProductsScreen.dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/home/homeScreen.dart';

import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

class ReservationsScreen extends StatelessWidget {
  ReservationsScreen({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // controller.currentIndex.value = 3;
controller.changeIndex(3);
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),

            // TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Reservations",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // TOP TABS
       Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    _productTabButton("Booking", true),

    const SizedBox(width: 20),

    GestureDetector(
      onTap: () {
        Get.off(() => ReservationProductsScreen());
      },
      child: _productTabButton("Products", false),
    ),
  ],
),

            const SizedBox(height: 12),

            const Divider(thickness: 2),

            const SizedBox(height: 15),

            // STATUS BUTTONS
          Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    _statusButton("pending", true),

    const SizedBox(width: 10),

    GestureDetector(
      onTap: () {
        Get.off(() => AcceptedReservationsScreen());
      },
      child: _statusButton("accept", false),
    ),

    const SizedBox(width: 10),

    GestureDetector(
      onTap: () {
        Get.off(() => CanceledReservationsScreen());
      },
      child: _statusButton("cancel", false),
    ),
  ],
),

            const SizedBox(height: 15),

            // RESERVATIONS LIST
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildReservationCard(index);
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
                Get.off(() => ChatsScreen());
              }

              if (index == 3) {
                Get.off(() => ReservationsScreen());
              }if (index == 4) {
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
  }

  Widget _buildStatusButton(
    String text,
    Color color,
    Color textColor,
  ) {
    return Container(
      width: 100,
      height: 43,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 17,
          ),
        ),
      ),
    );
  }



  static Widget _statusButton(String text, bool active) {
    return Container(
      width: 95,
      height: 40,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: active ? const Color(0xFF6A2431) : Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

static Widget _productTabButton(
  String text,
  bool active,
) {
  return Container(
    width: 125,
    height: 42,
    decoration: BoxDecoration(
      color: active ? Colors.white : Colors.grey.shade400,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: active
              ? const Color(0xFF591C27)
              : Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
  

  Widget _buildReservationCard(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffDBDBDB),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.testphoto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bariq",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "salon",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "17/5/2026",
                    style: TextStyle(
                      color: Color(0xFF591C27),
                    ),
                  ),
                  Text(
                    "13:30 PM",
                    style: TextStyle(
                      color: Color(0xFF591C27),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Souq Al-Hamidiyah,Damascus",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF7A2330),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Container(
                width: 100,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Pay now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}