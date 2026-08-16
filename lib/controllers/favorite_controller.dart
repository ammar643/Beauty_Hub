import 'package:get/get.dart';
import 'package:project_user/services/explore_service.dart';

class FavoriteController extends GetxController {
  final ExploreService _service = ExploreService();

  final Map<String, bool> _favorites = {};
  final RxMap<String, bool> favorites = RxMap<String, bool>();

  bool isFavorited(String type, int id) {
    final key = '${type}_$id';
    return favorites[key] ?? false;
  }

  Future<void> toggleFavorite(String type, int id) async {
    final key = '${type}_$id';
    final current = favorites[key] ?? false;

    favorites[key] = !current;

    final result = await _service.toggleFavorite(
      providerType: type,
      providerId: id,
    );

    if (result != null && result['success'] == true) {
      Get.snackbar('نجاح', current ? 'تمت الإزالة من المفضلة' : 'تمت الإضافة إلى المفضلة');
    } else {
      favorites[key] = current;
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحديث المفضلة');
    }
  }
}