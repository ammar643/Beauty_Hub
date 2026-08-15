import 'package:get/get.dart';
import 'package:project_user/services/wallet_service.dart';

class WalletController extends GetxController {
  final WalletService _walletService = WalletService();

  var isLoading = true.obs;
  var balance = 0.0.obs;
  var currency = 'JOD'.obs;
  var loyaltyPoints = 0.obs;
  var transactions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallet();
  }

  Future<void> fetchWallet() async {
    isLoading.value = true;
    final result = await _walletService.fetchWallet();
    if (result != null && result['success'] == true) {
      final data = result['data'];
      balance.value = (data['balance'] ?? 0.0).toDouble();
      currency.value = data['currency'] ?? 'JOD';
      loyaltyPoints.value = data['loyalty_points'] ?? 0;
      transactions.value = List<Map<String, dynamic>>.from(data['recent_transactions'] ?? []);
    } else {
      Get.snackbar('خطأ', 'فشل تحميل بيانات المحفظة');
    }
    isLoading.value = false;
  }

  Future<void> deposit(double amount) async {
    if (amount <= 0) {
      Get.snackbar('خطأ', 'يجب أن يكون المبلغ أكبر من صفر');
      return;
    }
    isLoading.value = true;
    final result = await _walletService.deposit(amount: amount);
    if (result != null && result['success'] == true) {
      final data = result['data'];
      balance.value = (data['balance'] ?? 0.0).toDouble();
      Get.snackbar('نجاح', 'تم الإيداع بنجاح');
      // إعادة تحميل المعاملات
      await fetchWallet();
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل الإيداع');
    }
    isLoading.value = false;
  }

  void refreshData() async {
    await fetchWallet();
  }
}