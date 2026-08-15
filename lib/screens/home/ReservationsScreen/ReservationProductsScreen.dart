import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/screens/ConversationsScreen.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationsScreen .dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/home/homeScreen.dart';
import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

class ReservationProductsScreen extends StatelessWidget {
  ReservationProductsScreen({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.changeIndex(3);

    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),

      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 25),

                /// HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Reservations",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 30,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// TOP TAB
               Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    GestureDetector(
      onTap: () {
        Get.off(() => ReservationsScreen());
      },
      child: _productTabButton("Booking", false),
    ),

    const SizedBox(width: 20),

    _productTabButton("Products", true),
  ],
),

                const SizedBox(height: 12),
                const Divider(thickness: 2),

                const SizedBox(height: 15),

                /// BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _tabButton("my cart", true),
                    _tabButton("my orders", false),
                  ],
                ),

                const SizedBox(height: 15),

                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return _productCard(index);
                    },
                  ),
                ),
              ],
            ),

            /// FLOATING TOTAL BOX
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                width: 150,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEDB6A),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total:60\$",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Order Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
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
                Get.off(() => Conversationsscreen());
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

  static Widget _tabButton(String text, bool active) {
    return Container(
      width: 120,
      height: 42,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: active ? const Color(0xFF591C27) : Colors.white,
            fontSize: 18,
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












Widget _productCard(int index) {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 8,
    ),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: const Color(0xFF591C27),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.08),
          blurRadius: 8,
        ),
      ],
    ),
    child: Row(
      children: [
        /// PRODUCT IMAGE
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(ImageAssets.testphoto),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(width: 12),

        /// CENTER PART
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Serum",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 2),

              const Text(
                "center B...",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              /// COUNTER
              StatefulBuilder(
                builder: (context, setState) {
                  int count = 3;

                  return Container(
                    width: 95,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7A2330),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (count > 1) {
                              setState(() {
                                count--;
                              });
                            }
                          },
                          child: const Text(
                            "-",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "$count",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              count++;
                            });
                          },
                          child: const Text(
                            "+",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        /// RIGHT SIDE
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              "17/5/2026",
              style: TextStyle(
                color: Color(0xFF591C27),
                fontSize: 16,
              ),
            ),

            Text(
              "13:30 PM",
              style: TextStyle(
                color: Color(0xFF591C27),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 18),

            Text(
              "15\$",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}