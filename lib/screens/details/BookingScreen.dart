import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/SalonController.dart';
import 'package:project_user/screens/details/PostsWidget.dart';
import 'package:project_user/screens/details/ReviewsWidget.dart';
import 'package:project_user/screens/details/SalonDetailsScreen.dart';
import 'package:project_user/screens/details/ShopWidget.dart';

class BookingScreen extends StatelessWidget {
   BookingScreen({super.key});
 final SalonController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5A1824),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF591C27),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/salon_bg.png"),
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffF5F5F5),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Back button
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            // Main booking card
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + logo
                    Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Row(
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Bariq",
                                            style: TextStyle(
                                              fontSize: 34,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "women salon",
                                            style: TextStyle(
                                              color: Color(0xff4B1A23),
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 30),

                                      /// 
                                      Stack(
                                        alignment: Alignment.center,
                                        children: const [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 45,
                                          ),
                                          Text(
                                            "5",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Positioned(
                                    right: 0,
                                    top: -15,
                                    child: Container(
                                      width: 109,
                                      height: 109,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              ImageAssets.salonphoto),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                    const SizedBox(height: 30),

                    const Text(
                      "A beauty salon that offers professional services including hair care, skincare, nails, and spa treatments.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Tabs
                  

  Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: List.generate(5, (index) {
                                    final tabs = [
                                      "Info",
                                      "Booking",
                                      "Reviews",
                                      "Posts",
                                      "Shop",
                                    ];

                                    return GestureDetector(
                                      onTap: () {
                                        controller.changeTab(index);

                                        if (index == 0) {
                                          Get.to(() =>
                                              SalonDetailsScreen());
                                        }

                                        // if (index == 1) {
                                        //   Get.to(() =>
                                        //       BookingScreen());
                                        // }

                                        if (index == 2) {
                                          Get.to(() =>
                                              ReviewsWidget());
                                        }
 

                                        if (index == 3) {
                                          Get.to(() => PostsWidget());
                                        }


 if (index == 4) {
                                          Get.to(() => ShopWidget());
                                        }


                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                            milliseconds: 200),
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: controller.selectedTab.value ==
                                                  index
                                              ? const Color(0xff5A1824)
                                              : Colors.transparent,
                                        ),
                                        child: Text(
                                          tabs[index],
                                          style: TextStyle(
                                            color: controller.selectedTab.value ==
                                                    index
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),





                    const Spacer(),

                    // Bottom booking section
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              bookingButton(),
                              const SizedBox(height: 10),
                              bookingButton(),
                            ],
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff5A1824),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Text(
                              "Total Price: 45\$",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget bookingButton() {
    return Container(
      width: 120,
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xffEFD96F),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Center(
        child: Text(
          "Book Now",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff5A1824),
          ),
        ),
      ),
    );
  }
}