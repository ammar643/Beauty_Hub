import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/provider_details_controller.dart';

class PostsWidget extends StatelessWidget {
  final String name;
  final String typeLabel;
  final int providerId;
  final double rating;
  final String? imageUrl;

  const PostsWidget({
    super.key,
    required this.name,
    required this.typeLabel,
    required this.providerId,
    required this.rating,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final ProviderDetailsController controller = Get.find();

    // جلب المنشورات إذا لم تكن قد جُلبت
    if (controller.posts.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchPosts(type: typeLabel, id: providerId);
      });
    }

    return Obx(() {
      if (controller.isLoadingPosts.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final posts = controller.posts;
      if (posts.isEmpty) {
        return const Center(
          child: Text(
            'لا توجد منشورات',
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 0.75,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final caption = post['caption'] ?? '';

          // استخراج الصور
          List<String> imageUrls = [];
          final mediaRaw = post['media_json'];
          if (mediaRaw is String) {
            try {
              final decoded = jsonDecode(mediaRaw);
              if (decoded is List) {
                imageUrls = decoded.map((e) => e['url']?.toString() ?? '').toList();
              }
            } catch (e) {
              imageUrls = [];
            }
          }
          final imageUrl = imageUrls.isNotEmpty ? imageUrls.first : null;

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== الصورة =====
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: imageUrl != null && imageUrl.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(
                                  imageUrl,
                                  headers: {
                                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                                  },
                                ),
                                fit: BoxFit.cover,
                              )
                            :  DecorationImage(
                                image: AssetImage(ImageAssets.onbording1),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),

                  // ===== نص المنشور (Caption) =====
                  if (caption.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        caption,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  // ===== عدد الإعجابات =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${post['likes_count'] ?? 0}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}