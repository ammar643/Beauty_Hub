import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/controllers/medical_record_controller.dart';

class MedicalRecordScreen extends StatelessWidget {
  MedicalRecordScreen({super.key});

  final MedicalRecordController controller = Get.put(MedicalRecordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('السجل الطبي'),
        backgroundColor: const Color(0xFF591C27),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('المعلومات العامة'),
              _buildTextField('الوزن (كجم)', controller.weight),
              _buildTextField('محيط الخصر (سم)', controller.waist),
              _buildDropdown(
                label: 'فصيلة الدم',
                value: controller.bloodType.value,
                items: controller.bloodTypes,
                onChanged: (val) => controller.bloodType.value = val ?? '',
              ),
              _buildDropdown(
                label: 'نوع البشرة',
                value: controller.skinType.value,
                items: controller.skinTypes,
                onChanged: (val) => controller.skinType.value = val ?? '',
              ),
              _buildDropdown(
                label: 'نوع الشعر',
                value: controller.hairType.value,
                items: controller.hairTypes,
                onChanged: (val) => controller.hairType.value = val ?? '',
              ),

              const SizedBox(height: 20),

              _buildSectionTitle('الحساسية'),
              _buildTextField('الحساسية (افصل بينها بفاصلة)',
                  controller.allergies, maxLines: 2),

              const SizedBox(height: 20),

              _buildSectionTitle('الأدوية المتناولة'),
              _buildTextField('الأدوية (افصل بينها بفاصلة)',
                  controller.medications, maxLines: 2),

              const SizedBox(height: 20),

              _buildSectionTitle('الأمراض المزمنة'),
              _buildTextField('الأمراض المزمنة (افصل بينها بفاصلة)',
                  controller.chronicConditions, maxLines: 2),

              const SizedBox(height: 20),

              _buildSectionTitle('العمليات الجراحية وغير الجراحية'),
              _buildTextField('العمليات السابقة (افصل بينها بفاصلة)',
                  controller.surgeries, maxLines: 2),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isSaving.value ? null : controller.saveRecord,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF591C27),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isSaving.value
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'حفظ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF591C27),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, RxString controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: controller.value,
        onChanged: (value) => controller.value = value,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<Map<String, String>> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value.isNotEmpty ? value : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item['value'],
            child: Text(item['label'] ?? item['value'] ?? ''),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}