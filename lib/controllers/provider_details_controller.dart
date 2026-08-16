import 'package:get/get.dart';
import 'package:project_user/services/provider_posts_service.dart';
import 'package:project_user/services/provider_service.dart';

class ProviderDetailsController extends GetxController {
  final ProviderService _service = ProviderService();
  final ProviderPostsService _postsService = ProviderPostsService();

  // ===== State =====
  var isLoadingPosts = false.obs;
  var isLoadingEmployees = false.obs;
  var isLoadingServices = false.obs;
  var isFollowLoading = false.obs;
  var isLiking = false.obs;

  var posts = <Map<String, dynamic>>[].obs;
  var employees = <Map<String, dynamic>>[].obs;
  var services = <Map<String, dynamic>>[].obs;

  var isFollowing = false.obs;
  var followersCount = 0.obs;

  var currentProviderType = ''.obs;
  var currentProviderId = 0.obs;

  // =============================================
  // Initialize provider data
  // =============================================
  void initializeProvider({required String type, required int id}) {
    currentProviderType.value = type;
    currentProviderId.value = id;
  }

  // =============================================
  // Initialize follow status
  // =============================================
  void initializeFollow({
    required bool initialFollowing,
    required int initialCount,
  }) {
    isFollowing.value = initialFollowing;
    followersCount.value = initialCount;
  }

  // =============================================
  // Fetch posts
  // =============================================
  Future<void> fetchPosts({required String type, required int id}) async {
    isLoadingPosts.value = true;
    final result = await _postsService.fetchPosts(
      providerType: type,
      providerId: id,
    );
    if (result != null && result['success'] == true) {
      posts.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      posts.clear();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل المنشورات');
    }
    isLoadingPosts.value = false;
  }

  // =============================================
  // Fetch employees
  // =============================================
  Future<void> fetchEmployees({required String type, required int id}) async {
    isLoadingEmployees.value = true;
    final result = await _service.fetchEmployees(
      providerType: type,
      providerId: id,
    );
    if (result != null && result['success'] == true) {
      employees.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      employees.clear();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل الموظفين');
    }
    isLoadingEmployees.value = false;
  }

  // =============================================
  // Fetch services
  // =============================================
  Future<void> fetchServices({required String type, required int id}) async {
    isLoadingServices.value = true;
    final result = await _service.fetchServices(
      providerType: type,
      providerId: id,
    );
    if (result != null && result['success'] == true) {
      services.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      services.clear();
    }
    isLoadingServices.value = false;
  }

    // =============================================
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
    } else {
   
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
    await fetchPosts(
      type: currentProviderType.value,
      id: currentProviderId.value,
    );
    Get.snackbar('نجاح', 'تم إضافة التعليق');
  } else {
    Get.snackbar('خطأ', result?['message'] ?? 'فشل إضافة التعليق');
  }
}
  // ======================
  Future<void> toggleFollow({required String type, required int id}) async {
    if (isFollowLoading.value) return;
    isFollowLoading.value = true;

    final result = await _service.toggleFollow(
      providerType: type,
      providerId: id,
    );
    if (result != null && result['success'] == true) {
      isFollowing.value = !isFollowing.value;
      followersCount.value += isFollowing.value ? 1 : -1;
      Get.snackbar(
        'نجاح',
        isFollowing.value ? 'تمت المتابعة' : 'تم إلغاء المتابعة',
      );
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تغيير حالة المتابعة');
    }
    isFollowLoading.value = false;
  }
}