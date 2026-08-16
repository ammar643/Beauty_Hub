import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/SalonController.dart';
import 'package:project_user/controllers/provider_posts_controller.dart';
import 'package:project_user/screens/details/BookingScreen.dart';
import 'package:project_user/screens/details/ReviewsWidget.dart';
import 'package:project_user/screens/details/SalonDetailsScreen.dart';
import 'package:project_user/screens/details/ShopWidget.dart';

class PostsWidget extends StatelessWidget {
  PostsWidget({super.key});

  final SalonController controller = Get.find();
  final ProviderPostsController postsController = Get.put(
    ProviderPostsController(),
  );

  @override
  Widget build(BuildContext context) {
    // استلام البيانات من الـ Arguments
    final args = Get.arguments as Map<String, dynamic>?;
    final String providerName = args?['name'] ?? 'مزود الخدمة';
    final String providerType = args?['type'] ?? 'salon';
    final int providerId = args?['id'] ?? 0;
    final double rating = args?['rating'] ?? 0.0;
    final String? imageUrl = args?['imageUrl'];

    // جلب المنشورات عند تحميل الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (providerId != 0) {
        postsController.fetchPosts(
          providerType: providerType,
          providerId: providerId,
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xff5A1824),
      body: SafeArea(
        child: Stack(
          children: [
            // الخلفية
            Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xFF591C27)),
                ),
                Expanded(child: Container(color: const Color(0xffF5F5F5))),
              ],
            ),

            // زر الرجوع
            Positioned(
              top: 15,
              left: 10,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            // المحتوى
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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
                              // اسم ولوجو مزود الخدمة
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            providerName,
                                            style: const TextStyle(
                                              fontSize: 34,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            providerType,
                                            style: const TextStyle(
                                              color: Color(0xff4B1A23),
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 30),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 45,
                                          ),
                                          Text(
                                            rating.toStringAsFixed(1),
                                            style: const TextStyle(
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
                                          image:
                                              imageUrl != null &&
                                                  imageUrl.isNotEmpty
                                              ? NetworkImage(
                                                      imageUrl,
                                                      headers: {
                                                        'User-Agent':
                                                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                                                      },
                                                    )
                                                    as ImageProvider
                                              : AssetImage(
                                                  ImageAssets.salonphoto,
                                                ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // التبويبات
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
                                        } else if (index == 1) {
                                          Get.to(() => BookingScreen());
                                        } else if (index == 2) {
                                          Get.to(() => ReviewsWidget());
                                        } else if (index == 4) {
                                          Get.to(() => ShopWidget());
                                        }
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
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

                              // قائمة المنشورات
                              Obx(() {
                                if (postsController.isLoading.value) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final posts = postsController.posts;
                                if (posts.isEmpty) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 40,
                                      ),
                                      child: Text(
                                        'لا توجد منشورات',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  );
                                }
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: posts.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 4,
                                        mainAxisSpacing: 4,
                                        childAspectRatio: .75,
                                      ),
                                  itemBuilder: (context, index) {
                                    final post = posts[index];
                                    final caption = post['caption'] ?? '';
                                    // معالجة media_json
                                    List<String> imageUrls = [];
                                    final mediaRaw = post['media_json'];
                                    if (mediaRaw is String) {
                                      try {
                                        final List<dynamic> decoded =
                                            jsonDecode(mediaRaw);
                                        imageUrls = decoded
                                            .whereType<Map<String, dynamic>>()
                                            .map((e) => e['url'] as String)
                                            .toList();
                                      } catch (e) {
                                        imageUrls = [];
                                      }
                                    } else if (mediaRaw is List) {
                                      imageUrls = mediaRaw
                                          .whereType<Map<String, dynamic>>()
                                          .map((e) => e['url'] as String)
                                          .toList();
                                    }
                                    // نأخذ أول صورة إن وجدت
                                    final imageUrl = imageUrls.isNotEmpty
                                        ? imageUrls.first
                                        : null;

                                    return Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageUrl != null
                                                  ? NetworkImage(
                                                          imageUrl,
                                                          headers: {
                                                            'User-Agent':
                                                                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                                                          },
                                                        )
                                                        as ImageProvider
                                                  : AssetImage(
                                                          ImageAssets
                                                              .onbording1,
                                                        )
                                                        as ImageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        // أيقونة الإعجاب
                                        Positioned(
                                          bottom: 8,
                                          left: 8,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.favorite_border,
                                                color: Colors.black,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${post['likes_count'] ?? 0}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
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
