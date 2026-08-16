import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/controllers/favorite_controller.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoriteController favController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
        backgroundColor: const Color(0xFF591C27),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      // ✅ خلفية لونية بدلاً من الصورة المفقودة
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Obx(() {
          // ✅ تحويل الخريطة إلى قائمة مفاتيح
          final keys = favController.favorites.keys.toList();

          if (keys.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'لا توجد عناصر مفضلة',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final key = keys[index];
              final isFavorite = favController.favorites[key] ?? false;

              if (!isFavorite) return const SizedBox.shrink();

              // استخراج النوع والمعرف من المفتاح
              final parts = key.split('_');
              final type = parts.length > 1 ? parts[0] : '';
              final id = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.favorite, color: Colors.red),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المعرف: $id',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'النوع: $type',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        if (type.isNotEmpty && id != 0) {
                          favController.toggleFavorite(type, id);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}