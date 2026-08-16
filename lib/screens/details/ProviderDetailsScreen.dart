import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/bookingController.dart';
import 'package:project_user/controllers/home/SalonController.dart';
import 'package:project_user/controllers/provider_details_controller.dart';
import 'package:project_user/models/beauty_center_model.dart';
import 'package:project_user/models/expert_model.dart';
import 'package:project_user/models/salon_model.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/widgets/provider/BookingWidget.dart';
import 'package:project_user/widgets/provider/InfoWidget.dart';
import 'package:project_user/widgets/provider/PostsWidget.dart';
import 'package:project_user/widgets/provider/ReviewsWidget.dart';
import 'package:project_user/widgets/provider/ShopWidget.dart';

class ProviderDetailsScreen extends StatelessWidget {
  ProviderDetailsScreen({super.key});

  final SalonController salonController = Get.put(SalonController());
  final ProviderDetailsController detailsController = Get.put(
    ProviderDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    // تسجيل BookingController
    Get.put(BookingController());

    final dynamic provider = Get.arguments['provider'];
    final String type = Get.arguments['type'] ?? 'salon';

    // ===== استخراج بيانات مزود الخدمة =====
    String name = '';
    String typeLabel = '';
    String? imageUrl;
    String? description;
    String? city;
    String? governorate;
    double rating = 0.0;
    String? phone;
    String? email;
    String? addressDetail;
    int providerId = 0;
    int followersCount = 0;

    if (provider is Salon) {
      name = provider.name;
      typeLabel = 'salon';
      imageUrl = provider.profilePhoto;
      description = provider.description;
      city = provider.city;
      governorate = provider.governorate;
      rating = provider.ratingAvg;
      phone = provider.phone;
      email = provider.email;
      addressDetail = provider.address_detail ?? '';
      providerId = provider.id;
      followersCount = provider.followersCount;
    } else if (provider is BeautyCenter) {
      name = provider.name;
      typeLabel = 'beauty center';
      imageUrl = provider.profilePhoto;
      description = provider.description;
      city = provider.city;
      governorate = provider.governorate;
      rating = provider.ratingAvg;
      phone = provider.phone;
      email = provider.email;
      addressDetail = provider.addressDetail ?? '';
      providerId = provider.id;
      followersCount = provider.followersCount;
    } else if (provider is Expert) {
      name = provider.fullName;
      typeLabel = 'expert';
      imageUrl = provider.profilePhoto;
      description = provider.bio;
      city = provider.city;
      governorate = provider.governorate;
      rating = provider.ratingAvg;
      phone = provider.phone;
      email = provider.email;
      providerId = provider.id;
      followersCount = provider.followersCount;
    }

    // ===== تهيئة حالة المتابعة =====
    detailsController.initializeFollow(
      initialFollowing: false,
      initialCount: followersCount,
    );

    // ===== جلب الموظفين والخدمات (للصالونات والمراكز فقط) =====
    if (provider is Salon || provider is BeautyCenter) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        detailsController.fetchEmployees(type: type, id: providerId);
        detailsController.fetchServices(type: type, id: providerId);
      });
    }

    // ===== صورة العرض =====
    ImageProvider displayImage;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      displayImage =
          NetworkImage(
                imageUrl,
                headers: {
                  'User-Agent':
                      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                },
              )
              as ImageProvider;
    } else {
      displayImage = AssetImage(ImageAssets.salonphoto);
    }

    // ===== قائمة الصفحات =====
    final List<Widget> pages = [
      InfoWidget(
        description: description,
        phone: phone,
        email: email,
        city: city,
        governorate: governorate,
        addressDetail: addressDetail,
        provider: provider,
        providerType: type,
        providerId: providerId,
        followersCount: followersCount,
        name: name,
      ),
      BookingWidget(
        providerType: type,
        providerId: providerId,
        name: name,
        typeLabel: typeLabel,
        rating: rating,
        imageUrl: imageUrl,
      ),
      const ReviewsWidget(),
      PostsWidget(
        name: name,
        typeLabel: typeLabel,
        providerId: providerId,
        rating: rating,
        imageUrl: imageUrl,
      ),
      const ShopWidget(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Stack(
        children: [
          // ===== HEADER =====
          Column(
            children: [
              Container(
                height: 260,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF591C27),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
            ],
          ),

          // ===== CONTENT CARD =====
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // ===== TITLE + RATING + PROFILE PHOTO =====
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 45,
                                          ),
                                          Text(
                                            rating.toStringAsFixed(1),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  typeLabel,
                                  style: const TextStyle(
                                    color: Color(0xff4B1A23),
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: -15,
                        child: Container(
                          width: 109,
                          height: 109,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                            image: DecorationImage(
                              image: displayImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ===== TABS =====
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(5, (index) {
                        final tabs = [
                          "Info",
                          "Booking",
                          "Reviews",
                          "Posts",
                          "Shop",
                        ];
                        final isSelected =
                            salonController.selectedTab.value == index;
                        return GestureDetector(
                          onTap: () {
                            salonController.changeTab(index);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xff5A1824)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ===== PAGES =====
                  Expanded(
                    child: Obx(
                      () => IndexedStack(
                        index: salonController.selectedTab.value,
                        children: pages,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ===== BACK BUTTON =====
          Positioned(
            top: 50,
            left: 15,
            child: IconButton(
              onPressed: () {
                Get.offAll(() => ExploreScreen());
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
