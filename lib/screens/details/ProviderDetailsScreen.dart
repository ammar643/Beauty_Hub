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

final String baseUrl = 'http://10.174.176.82:8000';

class ProviderDetailsScreen extends StatelessWidget {
  ProviderDetailsScreen({super.key});

  final SalonController salonController = Get.put(SalonController());
  final ProviderDetailsController detailsController = Get.put(
    ProviderDetailsController(),
  );

  // ============================================================
  // Image handling functions (no `const`)
  // ============================================================

  String _getFullImageUrl(String? path) {
    if (path == null || path.trim().isEmpty) return '';
    String cleanPath = path.trim();
    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return cleanPath;
    }
    cleanPath = cleanPath.replaceFirst(RegExp(r'^/+'), '');
    if (cleanPath.startsWith('storage/')) {
      return '$baseUrl/$cleanPath';
    }
    return '$baseUrl/storage/$cleanPath';
  }

  Map<String, String> get _imageHeaders {
    return {
      'User-Agent': 'Mozilla/5.0',
      'Accept': 'image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8',
    };
  }

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.isEmpty) {
      return AssetImage(ImageAssets.salonphoto);
    }
    return NetworkImage(
      imageUrl,
      headers: _imageHeaders,
    );
  }

  Widget _networkImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
  }) {
    if (imageUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: borderRadius,
        ),
      );
    }

    final image = Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      headers: _imageHeaders,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: borderRadius,
          ),
          child: Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('❌ IMAGE ERROR: $imageUrl');
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: borderRadius,
          ),
          child: Center(
            child: Icon(
              Icons.broken_image_outlined,
              color: Colors.grey,
              size: 35,
            ),
          ),
        );
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: image,
      );
    }
    return image;
  }

  // ============================================================

  @override
  Widget build(BuildContext context) {
    Get.put(BookingController());

    final dynamic provider = Get.arguments['provider'];
    final String type = Get.arguments['type'] ?? 'salon';

    // Extract provider data
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

    detailsController.initializeProvider(type: type, id: providerId);

    detailsController.initializeFollow(
      initialFollowing: false,
      initialCount: followersCount,
    );

    if (provider is Salon || provider is BeautyCenter) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        detailsController.fetchEmployees(type: type, id: providerId);
        detailsController.fetchServices(type: type, id: providerId);
      });
    }

    final String fullImageUrl = _getFullImageUrl(imageUrl);

    // ===== Pages =====
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
      ReviewsWidget(),
      PostsWidget(
        name: name,
        typeLabel: typeLabel,
        providerId: providerId,
        rating: rating,
        imageUrl: imageUrl,
      ),
      ShopWidget(),
    ];

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Stack(
        children: [
          // ===== HEADER =====
          Column(
            children: [
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),

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
                                    SizedBox(width: 160),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 45,
                                          ),
                                          Text(
                                            rating.toStringAsFixed(1),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  typeLabel,
                                  style: TextStyle(
                                    color: Color(0xff4B1A23),
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Main profile image using _getImageProvider
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
                              image: fullImageUrl.isNotEmpty
                                  ? _getImageProvider(fullImageUrl)
                                  : AssetImage(ImageAssets.salonphoto),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

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
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xff5A1824)
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

                  SizedBox(height: 10),

                  // ===== PAGES =====
                  Expanded(
                    child: Obx(
                      () => IndexedStack(
                        index: salonController.selectedTab.value,
                        children: pages,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
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
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}