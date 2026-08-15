import 'package:get/get.dart';
import 'package:project_user/services/provider_service.dart';

class ProviderDetailsController extends GetxController {
  final ProviderService _service = ProviderService();

  // ===== حالة الشاشة =====
  var isLoadingPosts = false.obs;
  var isLoadingEmployees = false.obs;
  var isFollowLoading = false.obs;

  var posts = <Map<String, dynamic>>[].obs;
  var employees = <Map<String, dynamic>>[].obs;

  var isFollowing = false.obs;
  var followersCount = 0.obs;
var services = <Map<String, dynamic>>[].obs;
var isLoadingServices = false.obs;
  // ===== تهيئة بيانات المتابعة =====
  void initializeFollow({required bool initialFollowing, required int initialCount}) {
    isFollowing.value = initialFollowing;
    followersCount.value = initialCount;
  }

  // ===== جلب المنشورات =====
  Future<void> fetchPosts({required String type, required int id}) async {
    isLoadingPosts.value = true;
    final result = await _service.fetchPosts(providerType: type, providerId: id);
    if (result != null && result['success'] == true) {
      posts.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      posts.clear();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل المنشورات');
    }
    isLoadingPosts.value = false;
  }

  // ===== جلب الموظفين =====
  Future<void> fetchEmployees({required String type, required int id}) async {
    isLoadingEmployees.value = true;
    final result = await _service.fetchEmployees(providerType: type, providerId: id);
    if (result != null && result['success'] == true) {
      employees.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      employees.clear();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل الموظفين');
    }
    isLoadingEmployees.value = false;
  }
Future<void> fetchServices({required String type, required int id}) async {
  isLoadingServices.value = true;
  final result = await _service.fetchServices(providerType: type, providerId: id);
  if (result != null && result['success'] == true) {
    services.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
  } else {
    services.clear();
  }
  isLoadingServices.value = false;
}
  // ===== تبديل المتابعة =====
  Future<void> toggleFollow({required String type, required int id}) async {
    if (isFollowLoading.value) return;
    isFollowLoading.value = true;

    final result = await _service.toggleFollow(providerType: type, providerId: id);
    if (result != null && result['success'] == true) {
      isFollowing.value = !isFollowing.value;
      followersCount.value += isFollowing.value ? 1 : -1;
      Get.snackbar('نجاح', isFollowing.value ? 'تمت المتابعة' : 'تم إلغاء المتابعة');
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تغيير حالة المتابعة');
    }
    isFollowLoading.value = false;
  }
}