import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/controllers/wallet_controller.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحفظة'),
        backgroundColor: const Color(0xFF591C27),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // ===== الرصيد =====
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF591C27), Color(0xFF8B3A4A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الرصيد الحالي',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${controller.balance.value} ${controller.currency.value}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'نقاط الولاء: ${controller.loyaltyPoints.value}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== زر الإيداع =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showDepositDialog(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffEFD96F),
                    foregroundColor: const Color(0xFF591C27),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'إيداع أموال',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ===== المعاملات الأخيرة =====
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'المعاملات الأخيرة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: controller.transactions.isEmpty
                    ? const Center(
                        child: Text('لا توجد معاملات حتى الآن'),
                      )
                    : ListView.builder(
                        itemCount: controller.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = controller.transactions[index];
                          final isCredit = transaction['direction'] == 'credit';
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: Icon(
                                isCredit ? Icons.arrow_upward : Icons.arrow_downward,
                                color: isCredit ? Colors.green : Colors.red,
                              ),
                              title: Text(
                                transaction['note'] ?? 'معاملة',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                transaction['created_at'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: Text(
                                '${isCredit ? '+' : '-'}${transaction['amount']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isCredit ? Colors.green : Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showDepositDialog() {
    final amountController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('إيداع أموال'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('أدخل المبلغ الذي تريد إيداعه'),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'المبلغ',
                prefixText: 'JOD ',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount != null) {
                Get.back();
                controller.deposit(amount);
              } else {
                Get.snackbar('خطأ', 'يرجى إدخال مبلغ صحيح');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF591C27),
              foregroundColor: Colors.white,
            ),
            child: const Text('تأكيد الإيداع'),
          ),
        ],
      ),
    );
  }
}