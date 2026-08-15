import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalRecordBookingDialog extends StatefulWidget {
  final Map<String, dynamic> medicalRecord;
  final Function(Map<String, dynamic>) onConfirm;
  final VoidCallback onSkip;

  const MedicalRecordBookingDialog({
    super.key,
    required this.medicalRecord,
    required this.onConfirm,
    required this.onSkip,
  });

  @override
  State<MedicalRecordBookingDialog> createState() =>
      _MedicalRecordBookingDialogState();
}

class _MedicalRecordBookingDialogState
    extends State<MedicalRecordBookingDialog> {
  late TextEditingController allergiesController;
  late TextEditingController skinTypeController;
  late TextEditingController hairTypeController;
  late TextEditingController medicationsController;
  late TextEditingController chronicConditionsController;
  late TextEditingController proceduresController;
  late TextEditingController weightController;
  late TextEditingController waistController;
  late TextEditingController bloodTypeController;

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
    {'value': 'streat', 'label': 'أملس (مستقيم)'},
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
  void initState() {
    super.initState();
    final record = widget.medicalRecord;
    allergiesController =
        TextEditingController(text: record['allergies'] ?? '');
    skinTypeController =
        TextEditingController(text: record['skin_type'] ?? '');
    hairTypeController =
        TextEditingController(text: record['hair_type'] ?? '');
    medicationsController =
        TextEditingController(text: record['medications'] ?? '');
    chronicConditionsController =
        TextEditingController(text: record['chronic_conditions'] ?? '');
    proceduresController =
        TextEditingController(text: record['previous_procedures'] ?? '');
    weightController =
        TextEditingController(text: record['weight']?.toString() ?? '');
    waistController =
        TextEditingController(text: record['waist']?.toString() ?? '');
    bloodTypeController =
        TextEditingController(text: record['blood_type'] ?? '');
  }

  @override
  void dispose() {
    allergiesController.dispose();
    skinTypeController.dispose();
    hairTypeController.dispose();
    medicationsController.dispose();
    chronicConditionsController.dispose();
    proceduresController.dispose();
    weightController.dispose();
    waistController.dispose();
    bloodTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.health_and_safety, color: Color(0xFF591C27)),
              const SizedBox(width: 8),
              const Text(
                'السجل الطبي',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF591C27),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'هل هناك أي تغييرات في السجل؟',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildSectionTitle('المعلومات العامة'),
                  _buildEditableField('الوزن (كجم)', weightController),
                  _buildEditableField('محيط الخصر (سم)', waistController),
                  _buildDropdown(
                    label: 'فصيلة الدم',
                    controller: bloodTypeController,
                    items: bloodTypes,
                  ),
                  _buildDropdown(
                    label: 'نوع البشرة',
                    controller: skinTypeController,
                    items: skinTypes,
                  ),
                  _buildDropdown(
                    label: 'نوع الشعر',
                    controller: hairTypeController,
                    items: hairTypes,
                  ),

                  const SizedBox(height: 12),

                  _buildSectionTitle('الحساسية'),
                  _buildEditableField('الحساسية', allergiesController,
                      hintText: 'افصل بينها بفاصلة', maxLines: 2),

                  _buildSectionTitle('الأدوية المتناولة'),
                  _buildEditableField('الأدوية', medicationsController,
                      hintText: 'افصل بينها بفاصلة', maxLines: 2),

                  _buildSectionTitle('الأمراض المزمنة'),
                  _buildEditableField('الأمراض المزمنة', chronicConditionsController,
                      hintText: 'افصل بينها بفاصلة', maxLines: 2),

                  _buildSectionTitle('العمليات الجراحية وغير الجراحية'),
                  _buildEditableField('العمليات السابقة', proceduresController,
                      hintText: 'افصل بينها بفاصلة', maxLines: 2),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onSkip,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF591C27),
                    side: const BorderSide(color: Color(0xFF591C27)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('تجاوز'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final updatedData = {
                      'allergies': allergiesController.text,
                      'skin_type': skinTypeController.text,
                      'hair_type': hairTypeController.text,
                      'medications': medicationsController.text,
                      'chronic_conditions': chronicConditionsController.text,
                      'previous_procedures': proceduresController.text,
                      'weight': weightController.text,
                      'waist': waistController.text,
                      'blood_type': bloodTypeController.text,
                    };
                    widget.onConfirm(updatedData);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF591C27),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'تأكيد الحجز',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF591C27),
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {String hintText = '', int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required TextEditingController controller,
    required List<Map<String, String>> items,
  }) {
    String currentValue = controller.text;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: currentValue.isNotEmpty ? currentValue : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item['value'],
                child: Text(item['label'] ?? item['value'] ?? ''),
              );
            }).toList(),
            onChanged: (value) {
              controller.text = value ?? '';
              setState(() {});
            },
          ),
        ], 
      ),
    );
  }
}