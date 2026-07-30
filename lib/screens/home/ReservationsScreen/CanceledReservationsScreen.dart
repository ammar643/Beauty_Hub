import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/screens/home/ChatsScreen.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/AcceptedReservationsScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationsScreen .dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/home/homeScreen.dart';
import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

class CanceledReservationsScreen extends StatelessWidget {
  CanceledReservationsScreen({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Reservations",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  "Booking",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF6A2431),
                    decoration: TextDecoration.underline,
                  ),
                ),
                Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(thickness: 1.5),

            const SizedBox(height: 15),

            /// STATUS BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.off(() => ReservationsScreen());
                  },
                  child: _statusButton("pending", false),
                ),

                const SizedBox(width: 10),

                GestureDetector(
                  onTap: () {
                    Get.off(() => AcceptedReservationsScreen());
                  },
                  child: _statusButton("accept", false),
                ),

                const SizedBox(width: 10),

                _statusButton("cancel", true),
              ],
            ),

            const SizedBox(height: 20),

           Expanded(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        _firstReservationCard(),
        const SizedBox(height: 15),
        _secondReservationCard(),
      ],
    ),
  ),
),
          ],
        ),
      ),
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

  static Widget _firstReservationCard() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: const Color(0xFF6A2431),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 23,
          backgroundImage: AssetImage(
            ImageAssets.photoreservations,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Bariq",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "center",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Souq Al-Hamidiyah,Damascus",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "17/5/2026",
              style: TextStyle(
                color: Color(0xFF6A2431),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              "13:30 PM",
              style: TextStyle(
                color: Color(0xFF6A2431),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: 90,
              height: 33,
              decoration: BoxDecoration(
                color: const Color(0xFF6A2431),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Text(
                  "Re-Book",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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



static Widget _secondReservationCard() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xffDBDBDBDB),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 23,
          backgroundImage: AssetImage(
            ImageAssets.photoreservations,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Bariq",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "salon",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Souq Al-Hamidiyah,Damascus",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "17/5/2026",
              style: TextStyle(
                color: Color(0xFF6A2431),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              "13:30 PM",
              style: TextStyle(
                color: Color(0xFF6A2431),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: 90,
              height: 33,
              decoration: BoxDecoration(
                color: const Color(0xFF6A2431),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Text(
                  "Re-Book",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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