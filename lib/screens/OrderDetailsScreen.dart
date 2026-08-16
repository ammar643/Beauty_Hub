
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/controllers/orders_controller.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int orderId;

  OrderDetailsScreen({required this.orderId});

  final OrdersController ordersController = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ordersController.fetchOrderDetails(orderId);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
        backgroundColor: const Color(0xFF591C27),
        foregroundColor: Colors.white,
        actions: [
          Obx(() {
            final status = ordersController.orderDetails['status'] ?? '';
            final bool canCancel = status == 'pending' || status == 'confirmed';
            return canCancel
                ? IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    onPressed: () {
                      _showCancelConfirmation(context);
                    },
                    tooltip: 'إلغاء الطلب',
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (ordersController.isOrderDetailsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final order = ordersController.orderDetails;
        final items = ordersController.orderItems;

        if (order.isEmpty && items.isEmpty) {
          return const Center(child: Text('لا توجد تفاصيل'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رقم الطلب: ${order['id'] ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('الحالة: ${order['status'] ?? ''}'),
                      Text('التاريخ: ${order['created_at'] ?? ''}'),
                      const SizedBox(height: 8),
                      Text(
                        'المبلغ الإجمالي: ${order['final_amount'] ?? '0'} JOD',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'المنتجات:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(item['name'] ?? ''),
                      subtitle: Text(
                        'الكمية: ${item['quantity']} × ${item['unit_price']} JOD',
                      ),
                      trailing: Text('${item['total_price']} JOD'),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }

    // ============================================================
  void _showCancelConfirmation(BuildContext context) {
    Get.defaultDialog(
      title: 'تأكيد الإلغاء',
      middleText: 'هل أنت متأكد من إلغاء هذا الطلب؟ سيتم استرداد المبلغ.',
      textConfirm: 'نعم، إلغاء',
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        ordersController.cancelOrder(orderId);
      },
    );
  }
}
