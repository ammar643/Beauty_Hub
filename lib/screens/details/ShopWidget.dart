import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/SalonController.dart';
import 'package:project_user/screens/details/BookingScreen.dart';
import 'package:project_user/screens/details/PostsWidget.dart';
import 'package:project_user/screens/details/ReviewsWidget.dart';
import 'package:project_user/screens/details/SalonDetailsScreen.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';

class ShopWidget extends StatelessWidget {
  ShopWidget({super.key});

  final SalonController controller = Get.find();

  final List<Map<String, String>> products = [
    {
      "image": ImageAssets.onbording1,
      "name": "Serum",
      "price": "5\$"
    },
    {
      "image": ImageAssets.onbording2,
      "name": "Serum",
      "price": "5\$"
    },
    {
      "image": ImageAssets.onbording3,
      "name": "Lipstick",
      "price": "8\$"
    },
    {
      "image": ImageAssets.onbording4,
      "name": "Hair Tools",
      "price": "10\$"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5A1824),
      body: SafeArea(
        child: Stack(
          children: [
            /// الخلفية
            Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: const Color(0xFF591C27),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xffF5F5F5),
                  ),
                ),
              ],
            ),

            /// زر الرجوع
            Positioned(
              top: 15,
              left: 10,
              child: IconButton(


                onPressed: () 
                
                {Get.back();},
                
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            /// المحتوى
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// الاسم + اللوجو
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
                                          Get.to(() => SalonDetailsScreen());
                                        }

                                        if (index == 1) {
                                          Get.to(() => BookingScreen());
                                        }

                                        if (index == 2) {
                                          Get.to(() => ReviewsWidget());
                                        }

                                        if (index == 3) {
                                          Get.to(() => PostsWidget());
                                        }
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              controller.selectedTab.value ==
                                                      index
                                                  ? const Color(0xff5A1824)
                                                  : Colors.transparent,
                                        ),
                                        child: Text(
                                          tabs[index],
                                          style: TextStyle(
                                            color:
                                                controller.selectedTab.value ==
                                                        index
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),

                              const SizedBox(height: 20),

                              /// المنتجات
                              GridView.builder(
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(),
                                itemCount: products.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: .58,
                                ),
                                itemBuilder: (context, index) {
                                  return productCard(products[index]);
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

  Widget productCard(Map<String, String> product) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
                bottom: Radius.circular(18),
              ),
              child: Image.asset(
                product["image"]!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product["name"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product["price"]!,
                      style: const TextStyle(
                        color: Color(0xffF0D968),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  "Bariq salon",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
               const SizedBox(height:3 ),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.favorite_border, size: 28),
                    Icon(Icons.shopping_cart_outlined, size: 28),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}