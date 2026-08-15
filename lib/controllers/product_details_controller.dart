import 'package:get/get.dart';
import 'package:project_user/services/explore_service.dart';

class ProductDetailsController extends GetxController {
  final ExploreService _productService = ExploreService();

  var isLoading = true.obs;
  var product = <String, dynamic>{}.obs;
  var productId = 0.obs;
var quantity = 1.obs;
  void setProductId(int id) {
    productId.value = id;
    quantity.value = 1;
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    isLoading.value = true;
    final result = await _productService.fetchProductDetails(productId.value);
    if (result != null && result['success'] == true) {
      product.value = result['data'] as Map<String, dynamic>;
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل تفاصيل المنتج');
    }
    isLoading.value = false;
  }
} 