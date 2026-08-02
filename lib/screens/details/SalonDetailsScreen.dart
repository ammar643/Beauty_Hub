import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/SalonController.dart';
import 'package:project_user/screens/details/BookingScreen.dart';
import 'package:project_user/screens/details/PostsWidget.dart';
import 'package:project_user/screens/details/ReviewsWidget.dart';
import 'package:project_user/screens/details/ShopWidget.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';

class SalonDetailsScreen extends StatelessWidget {
  SalonDetailsScreen({super.key});
  final SalonController controller = Get.put(SalonController());
  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Stack(
        children: [
          Column(
            children: [
              // HEADER
              //IMAGE
              Container(
                height: 260,
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
            ],
          ),

          // CONTENT CARD
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // TITLE + LOGO
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
                    const SizedBox(height: 20),

                    // DESCRIPTION
                    const Text(
                      "A beauty salon that offers professional services including hair care, skincare, nails, and spa treatments.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // TABS
//                     Obx(
//                       () => Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: List.generate(5, (index) {
//                           final tabs = [
//                             "Info",
//                             "Booking",
//                             "Reviews",
//                             "Posts",
//                             "Shop",
//                           ];

//                           return GestureDetector(
//                             onTap: () {
//   controller.changeTab(index);

//   if (index == 1) {
//     Get.to(() => BookingScreen());

//   }
//       if (index == 2) {
//   //  Get.to(() => ReviewsWidget());


//   }


// },
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 200),
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 border: controller.selectedTab.value == index
//                                     ? const Border(
//                                         bottom: BorderSide(
//                                           color: Color(0xFF591C27),
//                                           width: 2,
//                                         ),
//                                       )
//                                     : null,
//                               ),
//                               child: Text(
//                                 tabs[index],
//                                 style: TextStyle(
//                                   color: controller.selectedTab.value == index
//                                       ? const Color(0xFF591C27)
//                                       : Colors.grey,
//                                   fontWeight:
//                                       controller.selectedTab.value == index
//                                       ? FontWeight.bold
//                                       : FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     ),








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

                                        // if (index == 0) {
                                        //   Get.to(() =>
                                        //       SalonDetailsScreen());
                                        // }

                                        if (index == 1) {
                                          Get.to(() =>
                                              BookingScreen());
                                        }

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






















                    const Divider(height: 30),

                    // CALL INFO
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "call info:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("+963 999 888 777"),
                    ),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("+963 999 888 777"),
                    ),

                    const SizedBox(height: 20),

                    // LOCATION
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "position info:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Souq Al-Hamidiyah, Damascus"),
                    ),

                    const SizedBox(height: 20),

                    // SERVICES
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "services:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        serviceItem(Icons.school, "Course"),
                        serviceItem(Icons.face, "hair"),
                        serviceItem(Icons.brush, "makeup"),
                        serviceItem(Icons.color_lens, "dye"),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // EMPLOYEES
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "the employees:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 15),

                  SizedBox(
  height: 180,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4,
    itemBuilder: (context, index) {
      return Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 
            Container(
              height: 150,
              width: double.infinity,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                  bottom: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage(ImageAssets.onbording1),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Sara",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Hair",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  ),
),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),

          // BACK BUTTON
          Positioned(
            top: 50,
            left: 15,
            child: IconButton(
              onPressed: () {
                Get.offAll(() => ExploreScreen());
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            ),
          ),

          // BOTTOM BUTTONS
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xffEFD96F),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Text(
                        "Follow",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF591C27),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFF591C27),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget serviceItem(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: const Color(0xFF591C27)),
        ),
        const SizedBox(height: 8),
        Text(title),
      ],
    );
  }
}
