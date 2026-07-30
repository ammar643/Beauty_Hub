import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/screens/details/SalonDetailsScreen.dart';
import 'package:project_user/screens/home/CentersScreen.dart';
import 'package:project_user/screens/home/ChatsScreen.dart';
import 'package:project_user/screens/home/Experts.dart';
import 'package:project_user/screens/home/Products.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationsScreen%20.dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/home/homeScreen.dart';

import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // controller.currentIndex.value = 1;
controller.changeIndex(1);
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // SEARCH
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 62,
                      decoration: BoxDecoration(
                        color: const Color(0xffECEAEC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(width: 18),
                          Icon(
                            Icons.search,
                            color: Color(0xFF591C27),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Search",
                            style: TextStyle(
                              color: Color(0xFF591C27),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xffEFD96F),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Color(0xFF591C27),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            _buildTags(),

            const SizedBox(height: 12),

            _buildCities(),

            const SizedBox(height: 10),

            _buildTabs(),

            const Divider(),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GridView.builder(
                  itemCount: 4,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    return _buildCard();
                  },
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
  if (index == 3) {
  Get.to(() => ReservationsScreen());
}
if (index == 4) {
  Get.off(() => SettingScreen());
}
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

  Widget _buildTags() {
    List tags = ["hair", "make up", "women"];

    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color(0xFF591C27),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "× ${tags[index]}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCities() {
    List cities = ["Damascus", "Assweda", "Homs", "Hamah"];

    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: index == 0
                  ? const Color(0xFF702E3A)
                  : Color(0xFF676F73),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                cities[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildTabs() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GestureDetector(
        onTap: () {},
        child: const Text(
          "Salons",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF591C27),
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFF591C27),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      GestureDetector(
        onTap: () {
          Get.to(() => CentersScreen());
        },
        child: const Text(
          "Centers",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF676F73),
          ),
        ),
      ),

      GestureDetector(
        onTap: () {
          Get.off(() => ExpertsScreen());
        },
        child: const Text(
          "Experts",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF676F73),
          ),
        ),
      ),

      GestureDetector(
        onTap: () {
           Get.off(() => ProductsScreen());
        },
        child: const Text(
          "Products",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF676F73),
          ),
        ),
      ),
    ],
  );
}

Widget _buildCard() {
  return GestureDetector(
    onTap: () {
      Get.to(() => SalonDetailsScreen());
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                image: DecorationImage(
                  image: AssetImage(ImageAssets.onbording3),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bariq",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "women salon",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xffEFD96F),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text("5"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
} 
}