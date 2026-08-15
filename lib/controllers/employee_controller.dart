
import 'package:get/get.dart';
import 'package:project_user/services/employee_service.dart';

class EmployeeController extends GetxController {
  final EmployeeService _employeeService = EmployeeService();

  var employees = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  Future<void> fetchEmployees({
    required String providerType,
    required int providerId,
  }) async {
    isLoading.value = true;
    final result = await _employeeService.fetchEmployees(
      providerType: providerType,
      providerId: providerId,
    );
    if (result != null && result['success'] == true) {
      employees.value = (result['data'] as List?)?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      employees.clear();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل الموظفين');
    }
    isLoading.value = false;
  }
}