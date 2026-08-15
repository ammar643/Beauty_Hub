import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_user/models/beauty_center_model.dart';
import 'package:project_user/models/expert_model.dart';
import 'package:project_user/models/post_model.dart';
import 'package:project_user/models/salon_model.dart';
import 'package:project_user/models/user_model.dart';
import 'package:project_user/services/home_service.dart';

class HomeController extends GetxController {
  final HomeService _homeService = HomeService();
  final GetStorage _box = GetStorage();

  var isLoading = true.obs;
  var salons = <Salon>[].obs;
  var beautyCenters = <BeautyCenter>[].obs;
  var experts = <Expert>[].obs;
  var posts = <Post>[].obs;
  var stories = <dynamic>[].obs;
  var currentIndex = 0.obs;
  var user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    // انتظر حتى يصبح التوكن موجوداً
    int attempts = 0;
    while (_box.read('token') == null && attempts < 15) {
      await Future.delayed(const Duration(milliseconds: 200));
      attempts++;
    }
    // إذا كان التوكن موجوداً، جلب البيانات
    if (_box.read('token') != null) {
      await fetchHomeData();
    } else {
      // إذا لم يتم العثور على توكن، جرب مرة أخرى بعد ثانية
      Future.delayed(const Duration(seconds: 1), () {
        if (_box.read('token') != null) {
          fetchHomeData();
        }
      });
    }
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading.value = true;

      final response = await _homeService.fetchUserData();

      if (response != null && response['success'] == true) {
        final data = response['data'];

        if (data['me'] != null) {
          user.value = User.fromJson(data['me']);
        }

        final topRated = data['top_rated'] ?? {};
        salons.value = (topRated['salons'] as List? ?? [])
            .map((json) => Salon.fromJson(json))
            .toList();
        beautyCenters.value = (topRated['beauty_centers'] as List? ?? [])
            .map((json) => BeautyCenter.fromJson(json))
            .toList();
        experts.value = (topRated['experts'] as List? ?? [])
            .map((json) => Expert.fromJson(json))
            .toList();

        final feed = data['feed'] ?? {};
        posts.value = (feed['posts'] as List? ?? [])
            .map((json) => Post.fromJson(json))
            .toList();

        stories.value = data['stories'] ?? [];

        // طباعة للتصحيح
        print('✅ تم تحميل البيانات: ${salons.length} صالونات');
      } else {
        Get.snackbar('خطأ', response?['message'] ?? 'فشل تحميل البيانات');
      }
    } catch (e) {
      print('❌ خطأ في جلب البيانات: $e');
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> refreshData() async {
    await fetchHomeData();
  }
}