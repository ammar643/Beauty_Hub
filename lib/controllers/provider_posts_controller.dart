import 'package:get/get.dart';
import 'package:project_user/services/provider_posts_service.dart';

class ProviderPostsController extends GetxController {
  final ProviderPostsService _postsService = ProviderPostsService();

  var posts = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

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
}