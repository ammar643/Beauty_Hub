import 'package:get/get.dart';
import 'package:project_user/models/comment.dart';
import 'package:project_user/services/provider_posts_service.dart';

class CommentsController extends GetxController {
  final ProviderPostsService _postsService = ProviderPostsService();

  var isLoading = true.obs;
  var comments = <Comment>[].obs;
  var postId = 0.obs;
  var isSending = false.obs;

  void setPostId(int id) {
    postId.value = id;
    fetchComments();
  }

  Future<void> fetchComments() async {
    isLoading.value = true;
    try {
      final result = await _postsService.fetchComments(postId.value);
      print('📥 Comments response: $result');
      if (result != null && result['success'] == true) {
        final data = result['data'] as List? ?? [];
        comments.value = data.map((json) => Comment.fromJson(json)).toList();
      } else {
        comments.clear();
        Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل التعليقات');
      }
    } catch (e) {
      print('❌ Error fetching comments: $e');
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addComment(String text) async {
    if (text.trim().isEmpty) {
      Get.snackbar('تنبيه', 'الرجاء كتابة تعليق');
      return;
    }
    isSending.value = true;
    final result = await _postsService.addComment(
      postId: postId.value,
      comment: text.trim(),
    );
    isSending.value = false;

    if (result != null && result['success'] == true) {
      await fetchComments();
      Get.snackbar('نجاح', 'تم إضافة التعليق');
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل إضافة التعليق');
    }
  }
}