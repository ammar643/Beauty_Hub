import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/SalonController.dart';
import 'package:project_user/screens/details/PostsWidget.dart';
import 'package:project_user/screens/details/SalonDetailsScreen.dart';
import 'package:project_user/screens/details/BookingScreen.dart';
import 'package:project_user/screens/details/ShopWidget.dart';

class ReviewsWidget extends StatelessWidget {
  ReviewsWidget({super.key});

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
                  //  // image: AssetImage("assets/images/salon_bg.png"),
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

            /// 
            Positioned(
              top: 15,
              left: 10,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            /// 
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              /// 
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
                                "A beauty salon that offers professional services including hair care, skincare, nails, and spa treatments. The salon focuses on providing a comfortable and high‑quality experience through skilled specialists and modern beauty techniques.",
                                style: TextStyle(
                                  color: Color(0xffAEAEB2),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 20),

                              /// Tabs
                             

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

                                        if (index == 1) {
                                          Get.to(() =>
                                              BookingScreen());
                                        }

                                        // if (index == 2) {
                                        //   Get.to(() =>
                                        //       ReviewsWidget());
                                        // }
 

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




                              const SizedBox(height: 30),

                              /// 
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children:  [
                                 Row(
  children: [
    Stack(
      alignment: Alignment.center,
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 55,
        ),
        const Text(
          "5",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
    const SizedBox(width: 10),
  ],
),



                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "5 stars",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "500 reviews",
                                        style: TextStyle(
                                          color: Color(0xffAEAEB2),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              const SizedBox(height: 20),

                              const Text(
                                "Comments:",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),

                              ...List.generate(
                                4,
                                (index) => reviewCard(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// 
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                          bottom: Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 180,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xffEFD96F),
                            borderRadius:
                                BorderRadius.circular(18),
                          ),
                          child: const Center(
                            child: Text(
                              "Add Review",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5A1824),
                              ),
                            ),
                          ),
                        ),
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

  Widget reviewCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        
        children: [
          
          CircleAvatar(
            radius: 28,
            backgroundImage:
                AssetImage(ImageAssets.photocomments)
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Lojain Aljohari",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "very good service and friendly team.prices are fair quality is high",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 35,
          ),
        ],
      ),
    );
  }
}