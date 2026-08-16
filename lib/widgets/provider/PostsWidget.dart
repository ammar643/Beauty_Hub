import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/provider_details_controller.dart';
import 'package:project_user/screens/comments_screen.dart';

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
          child: Text('لا توجد منشورات', style: TextStyle(color: Colors.grey)),
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
          final int postId = post['id'] ?? 0;
          final int likesCount = post['likes_count'] ?? 0;
          final bool isLiked = post['is_liked'] ?? false;
          final int commentsCount = post['comments_count'] ?? 0;

          // Extract images
          List<String> imageUrls = [];
          final mediaRaw = post['media_json'];
          if (mediaRaw is String) {
            try {
              final decoded = jsonDecode(mediaRaw);
              if (decoded is List) {
                imageUrls = decoded
                    .map((e) => e['url']?.toString() ?? '')
                    .toList();
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
                  // ===== Image =====
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: imageUrl != null && imageUrl.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(
                                  imageUrl,
                                  headers: {
                                    'User-Agent':
                                        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                                  },
                                ),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: AssetImage(ImageAssets.onbording1),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),

                  // ===== Caption =====
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

                  // ===== Like & Comment Buttons =====
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        // Like button
                        GestureDetector(
                          onTap: () {
                            if (postId > 0) {
                              controller.toggleLike(postId);
                            }
                          },
                          child: Obx(() {
                            final currentPost = controller.posts
                                .firstWhereOrNull((p) => p['id'] == postId);
                            final isLikedNow =
                                currentPost?['is_liked'] ?? false;
                            return Icon(
                              isLikedNow
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isLikedNow ? Colors.red : Colors.grey,
                              size: 18,
                            );
                          }),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$likesCount',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Comment button
                        GestureDetector(
                          onTap: () {
                            // In the comment button's onTap
                          
                              Get.to(
                                CommentsScreen(),
                                arguments: {
                                  'postId': postId,
                                  'providerId': providerId, 
                                  'typeLabel': typeLabel, 
                                },
                              );
                           
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.grey,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$commentsCount',
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
                ],
              ),
            ),
          );
        },
      );
    });
  }

  // ===== Comment Dialog =====
}
