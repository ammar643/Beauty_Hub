import 'package:get/get.dart';
import 'package:project_user/services/medical_record_service.dart';

class MedicalRecordController extends GetxController {
  final MedicalRecordService _service = MedicalRecordService();

  var isLoading = true.obs;
  var isSaving = false.obs;

  // بيانات النموذج
  var allergies = ''.obs;
  var skinType = ''.obs;
  var hairType = ''.obs;
  var medications = ''.obs;
  var chronicConditions = ''.obs;
  var surgeries = ''.obs;
  var notes = ''.obs;
  var weight = ''.obs;
  var waist = ''.obs;
  var bloodType = ''.obs;

  // ✅ قوائم الخيارات (القيمة الفعلية + التسمية المعروضة)
  final List<Map<String, String>> skinTypes = [
    {'value': 'dry', 'label': 'جافة'},
    {'value': 'oily', 'label': 'دهنية'},
    {'value': 'normal', 'label': 'عادية'},
    {'value': 'combination', 'label': 'مختلطة'},
    {'value': 'sensitive', 'label': 'حساسة'},
  ];
  final List<Map<String, String>> hairTypes = [
    {'value': 'straight', 'label': 'أملس'},
    {'value': 'wavy', 'label': 'مموج'},
    {'value': 'curly', 'label': 'مجعد'},
    {'value': 'coily', 'label': 'كيرلي'},
    {'value': 'rough', 'label': 'خشن'},
    {'value': 'streat', 'label': 'أملس (مستقيم)'}, // لتطابق قيمة الـ API
  ];
  final List<Map<String, String>> bloodTypes = [
    {'value': 'A+', 'label': 'A+'},
    {'value': 'A-', 'label': 'A-'},
    {'value': 'B+', 'label': 'B+'},
    {'value': 'B-', 'label': 'B-'},
    {'value': 'AB+', 'label': 'AB+'},
    {'value': 'AB-', 'label': 'AB-'},
    {'value': 'O+', 'label': 'O+'},
    {'value': 'O-', 'label': 'O-'},
  ];

  @override
  void onInit() {
    super.onInit();
    fetchRecord();
  }

  Future<void> fetchRecord() async {
    isLoading.value = true;
    final result = await _service.fetchMedicalRecord();

    if (result != null && result['success'] == true) {
      final data = result['data'] as Map<String, dynamic>;
      allergies.value = data['allergies'] ?? '';
      skinType.value = data['skin_type'] ?? '';
      hairType.value = data['hair_type'] ?? '';
      medications.value = data['medications'] ?? '';
      chronicConditions.value = data['chronic_conditions'] ?? '';
      surgeries.value = data['previous_procedures'] ?? '';
      notes.value = data['notes'] ?? '';
      weight.value = data['weight']?.toString() ?? '';
      waist.value = data['waist']?.toString() ?? '';
      bloodType.value = data['blood_type'] ?? '';
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحميل السجل الطبي');
    }
    isLoading.value = false;
  }

  Future<void> saveRecord() async {
    isSaving.value = true;

    final data = {
      'allergies': allergies.value,
      'skin_type': skinType.value,
      'hair_type': hairType.value,
      'medications': medications.value,
      'chronic_conditions': chronicConditions.value,
      'previous_procedures': surgeries.value,
      'notes': notes.value,
      'weight': weight.value,
      'waist': waist.value,
      'blood_type': bloodType.value,
    };

    final result = await _service.updateMedicalRecord(data: data);

    if (result != null && result['success'] == true) {
      Get.snackbar('نجاح', 'تم تحديث السجل الطبي بنجاح');
      await fetchRecord();
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل تحديث السجل الطبي');
    }
    isSaving.value = false;
  }
}