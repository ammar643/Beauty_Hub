import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/SalonController.dart';
import 'package:project_user/screens/details/BookingScreen.dart';
import 'package:project_user/screens/details/ReviewsWidget.dart';
import 'package:project_user/screens/details/SalonDetailsScreen.dart';
import 'package:project_user/screens/details/ShopWidget.dart';

class PostsWidget extends StatelessWidget {
  PostsWidget({super.key});

  final SalonController controller = Get.find();

  final List<String> posts = [
    ImageAssets.onbording1,
    ImageAssets.onbording2,
    ImageAssets.onbording3,
    ImageAssets.onbording3,
    ImageAssets.onbording1,
    ImageAssets.onbording2,
    ImageAssets.onbording3,
    ImageAssets.onbording3,
    ImageAssets.onbording1,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5A1824),
      body: SafeArea(
        child: Stack(
          children: [
            /// 
            Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF591C27),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xffF5F5F5),
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
                                "A beauty salon that offers professional services including hair care, skincare, nails, and spa treatments.",
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

                                        // if (index == 1) {
                                        //   Get.to(() =>
                                        //       BookingScreen());
                                        // }

                                        if (index == 2) {
                                          Get.to(() =>
                                              ReviewsWidget());
                                        }
 

                                        // if (index == 3) {
                                        //   Get.to(() => PostsWidget());
                                        // }


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

                              const SizedBox(height: 20),

                              /// 
                              GridView.builder(
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(),
                                itemCount: posts.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                  childAspectRatio: .75,
                                ),
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                posts[index]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      /// 
                                      const Positioned(
                                        bottom: 8,
                                        left: 8,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
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
}