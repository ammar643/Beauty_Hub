import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/provider_details_controller.dart';
import 'package:project_user/models/beauty_center_model.dart';
import 'package:project_user/models/salon_model.dart';
import 'package:project_user/screens/chat_screen.dart';

class InfoWidget extends StatelessWidget {
  final String? description;
  final String? phone;
  final String? email;
  final String? city;
  final String? governorate;
  final String? addressDetail;
  final dynamic provider;
  final String providerType;
  final int providerId;
  final int followersCount;
  final String name; 
  final String? imageUrl;

  const InfoWidget({
    super.key,
    this.description,
    this.phone,
    this.email,
    this.city,
    this.governorate,
    this.addressDetail,
    this.provider,
    required this.providerType,
    required this.providerId,
    required this.followersCount,
    required this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final ProviderDetailsController controller =
        Get.find<ProviderDetailsController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== الوصف =====
          Text(
            description ?? 'لا يوجد وصف',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // ===== معلومات المزود =====
          const Text(
            'معلومات المزود:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // الهاتف
          Row(
            children: [
              const Icon(Icons.phone, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(phone?.isNotEmpty == true ? phone! : 'غير متوفر'),
            ],
          ),
          const SizedBox(height: 6),

          // البريد الإلكتروني
          Row(
            children: [
              const Icon(Icons.email, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(email?.isNotEmpty == true ? email! : 'غير متوفر'),
            ],
          ),
          const SizedBox(height: 6),

          // المدينة والمحافظة
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                (city != null && city!.isNotEmpty ? city! : '') +
                    (governorate != null && governorate!.isNotEmpty
                        ? ', ${governorate!}'
                        : ''),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // عدد المتابعين
          Row(
            children: [
              const Icon(Icons.people_outline, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text('$followersCount متابع'),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => ChatScreen(),
                    arguments: {
                      'otherType':
                          providerType, 
                      'otherId': providerId,
                      'otherName': name,
                      'otherPhoto': imageUrl,
                    },
                  );
                },
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF591C27),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // زر المتابعة
              Obx(
                () => GestureDetector(
                  onTap: controller.isFollowLoading.value
                      ? null
                      : () {
                          controller.toggleFollow(
                            type: providerType,
                            id: providerId,
                          );
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: controller.isFollowing.value
                          ? Colors.grey
                          : const Color(0xffEFD96F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: controller.isFollowLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF591C27),
                            ),
                          )
                        : Text(
                            controller.isFollowing.value
                                ? 'Unfollow'
                                : 'Follow',
                            style: TextStyle(
                              color: controller.isFollowing.value
                                  ? Colors.white
                                  : const Color(0xFF591C27),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ===== الخدمات (للصالونات والمراكز) =====
          if (provider is Salon || provider is BeautyCenter) ...[
            const Text(
              'الخدمات:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _serviceItem(Icons.school, 'دورات'),
                _serviceItem(Icons.face, 'شعر'),
                _serviceItem(Icons.brush, 'مكياج'),
                _serviceItem(Icons.color_lens, 'صبغ'),
              ],
            ),
            const SizedBox(height: 25),
          ],

          // ===== الموظفين (للصالونات والمراكز) =====
          if (provider is Salon || provider is BeautyCenter) ...[
            const Text(
              'الموظفون:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Obx(() {
              if (controller.isLoadingEmployees.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final employees = controller.employees;
              if (employees.isEmpty) {
                return const Text(
                  'لا يوجد موظفون',
                  style: TextStyle(color: Colors.grey),
                );
              }
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    final fullName = employee['full_name'] ?? 'موظف';
                    final specialization = employee['specialization'] ?? '';
                    final photo = employee['profile_photo'];

                    return Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: photo != null && photo.isNotEmpty
                                    ? NetworkImage(
                                            photo,
                                            headers: {
                                              'User-Agent':
                                                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                                            },
                                          )
                                          as ImageProvider
                                    : AssetImage(ImageAssets.onbording1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (specialization.isNotEmpty)
                                  Text(
                                    specialization,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 30),
          ],

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // زر المتابعة
              Obx(
                () => GestureDetector(
                  onTap: controller.isFollowLoading.value
                      ? null
                      : () {
                          controller.toggleFollow(
                            type: providerType,
                            id: providerId,
                          );
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: controller.isFollowing.value
                          ? Colors.grey
                          : const Color(0xffEFD96F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: controller.isFollowLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF591C27),
                            ),
                          )
                        : Text(
                            controller.isFollowing.value
                                ? 'Unfollow'
                                : 'Follow',
                            style: TextStyle(
                              color: controller.isFollowing.value
                                  ? Colors.white
                                  : const Color(0xFF591C27),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _serviceItem(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: const Color(0xFF591C27)),
        ),
        const SizedBox(height: 8),
        Text(title),
      ],
    );
  }
}
