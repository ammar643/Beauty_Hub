import 'package:get/get.dart';
import 'package:project_user/services/provider_posts_service.dart';

class ProviderPostsController extends GetxController {
  final ProviderPostsService _postsService = ProviderPostsService();

  var isLoading = false.obs;
  var posts = <Map<String, dynamic>>[].obs;
  var isLiking = false.obs;

  Future<void> fetchPosts({
    required String providerType,
    required int providerId,
  }) async {
    isLoading.value = true;
    final result = await _postsService.fetchPosts(
      providerType: providerType,
      providerId: providerId,
    );
    if (result != null && result['success'] == true) {
      posts.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      posts.clear();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل المنشورات');
    }
    isLoading.value = false;
  }

  Future<void> toggleLike(int postId) async {
    if (isLiking.value) return;
    isLiking.value = true;

    final int index = posts.indexWhere((p) => p['id'] == postId);
    if (index == -1) {
      isLiking.value = false;
      return;
    }

    final Map<String, dynamic> originalPost = Map.from(posts[index]);

    posts[index]['is_liked'] = !(posts[index]['is_liked'] ?? false);
    posts[index]['likes_count'] = (posts[index]['likes_count'] ?? 0) +
        (posts[index]['is_liked'] ? 1 : -1);
    posts.refresh();

    final result = await _postsService.toggleLike(postId);
    if (result == null || result['success'] != true) {
      posts[index] = originalPost;
      posts.refresh();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحديث الإعجاب');
    }
    isLiking.value = false;
  }

  Future<void> addComment(int postId, String comment) async {
    if (comment.trim().isEmpty) {
      Get.snackbar('تنبيه', 'الرجاء كتابة تعليق');
      return;
    }

    final result = await _postsService.addComment(
      postId: postId,
      comment: comment.trim(),
    );

    if (result != null && result['success'] == true) {
      final int index = posts.indexWhere((p) => p['id'] == postId);
      if (index != -1) {
        posts[index]['comments_count'] = (posts[index]['comments_count'] ?? 0) + 1;
        posts.refresh();
      }
      Get.snackbar('نجاح', 'تم إضافة التعليق');
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل إضافة التعليق');
    }
  }
}