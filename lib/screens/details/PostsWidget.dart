import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/SalonController.dart';
import 'package:project_user/controllers/provider_posts_controller.dart';
import 'package:project_user/screens/comments_screen.dart';
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
    final args = Get.arguments as Map<String, dynamic>?;
    final String providerName = args?['name'] ?? 'مزود الخدمة';
    final String providerType = args?['type'] ?? 'salon';
    final int providerId = args?['id'] ?? 0;
    final double rating = args?['rating'] ?? 0.0;
    final String? imageUrl = args?['imageUrl'];

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
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // اسم المزود + الصورة
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
                                          image: imageUrl != null &&
                                                  imageUrl.isNotEmpty
                                              ? NetworkImage(
                                                  imageUrl,
                                                  headers: {
                                                    'User-Agent':
                                                        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                                                  },
                                                ) as ImageProvider
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
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // شبكة المنشورات
                              Obx(() {
                                if (postsController.isLoading.value) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF591C27),
                                    ),
                                  );
                                }
                                final posts = postsController.posts;
                                if (posts.isEmpty) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 40,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.photo_library_outlined,
                                            size: 60,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'لا توجد منشورات',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
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
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: 0.85,
                                      ),
                                  itemBuilder: (context, index) {
                                    final post = posts[index];
                                    final caption = post['caption'] ?? '';
                                    final int postId = post['id'] ?? 0;
                                    final int likesCount = post['likes_count'] ??
                                        0;
                                    final bool isLiked =
                                        post['is_liked'] ?? false;
                                    final int commentsCount =
                                        post['comments_count'] ?? 0;

                                    // استخراج الصور
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
                                    final imageUrl = imageUrls.isNotEmpty
                                        ? imageUrls.first
                                        : null;

                                    return _buildPostCard(
                                      imageUrl: imageUrl,
                                      caption: caption,
                                      postId: postId,
                                      likesCount: likesCount,
                                      isLiked: isLiked,
                                      commentsCount: commentsCount,
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

  Widget _buildPostCard({
    required String? imageUrl,
    required String caption,
    required int postId,
    required int likesCount,
    required bool isLiked,
    required int commentsCount,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // الصورة
            Positioned.fill(
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      headers: {
                        'User-Agent':
                            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                      },
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade100,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey.shade100,
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
            ),

            // تدرج شفاف فوق الصورة
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // النص (caption)
            if (caption.isNotEmpty)
              Positioned(
                bottom: 44,
                left: 8,
                right: 8,
                child: Text(
                  caption,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            // أزرار الإعجاب والتعليق
            Positioned(
              bottom: 6,
              left: 8,
              right: 8,
              child: Row(
                children: [
                  // زر الإعجاب
                  GestureDetector(
                    onTap: () {
                      if (postId > 0) {
                        postsController.toggleLike(postId);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            final currentPost = postsController.posts
                                .firstWhereOrNull((p) => p['id'] == postId);
                            final isLikedNow =
                                currentPost?['is_liked'] ?? false;
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              child: Icon(
                                isLikedNow
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                key: ValueKey(isLikedNow),
                                color: isLikedNow ? Colors.red : Colors.white,
                                size: 16,
                              ),
                            );
                          }),
                          const SizedBox(width: 4),
                          Text(
                            '$likesCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // زر التعليق
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => CommentsScreen(),
                        arguments: {'postId': postId},
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$commentsCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'تعليق',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
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