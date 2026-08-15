import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/api/app_config.dart';

import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/favorite_controller.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/controllers/home/explore_controller.dart';

import 'package:project_user/models/beauty_center_model.dart';
import 'package:project_user/models/expert_model.dart';
import 'package:project_user/models/salon_model.dart';

import 'package:project_user/screens/ConversationsScreen.dart';
import 'package:project_user/screens/details/ProviderDetailsScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationsScreen%20.dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/home/homeScreen.dart';
import 'package:project_user/screens/product_details_screen.dart';

import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

final String baseUrl = appConfig;
// 'http://192.168.1.101:8000';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  final ExploreController exploreController = Get.put(ExploreController());

  // ============================================================
  // FULL IMAGE URL
  // ============================================================

  String _getFullImageUrl(String path) {
    if (path.trim().isEmpty) {
      return '';
    }

    final cleanPath = path.trim();

    // ----------------------------------------------------------
    // إذا كان الرابط من Backend نفسه
    // ----------------------------------------------------------

    if (cleanPath.startsWith('$baseUrl/storage/')) {
      return cleanPath;
    }

    // ----------------------------------------------------------
    // إذا كان الرابط http/https خارجي
    // لا نسمح به
    // ----------------------------------------------------------

    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return '';
    }

    // ----------------------------------------------------------
    // إذا كانت الصورة قادمة مثل:
    //
    // salons/cover.jpg
    // centers/cover.jpg
    // experts/sara.jpg
    //
    // تصبح:
    //
    // http://10.174.176.82:8000/storage/...
    // ----------------------------------------------------------

    final cleanPathWithoutSlash = cleanPath.startsWith('/')
        ? cleanPath.substring(1)
        : cleanPath;

    return '$baseUrl/storage/$cleanPathWithoutSlash';
  }

  // ============================================================
  // CHECK IMAGE
  // ============================================================

  bool _hasValidBackendImage(String? path) {
    if (path == null || path.trim().isEmpty) {
      return false;
    }

    final value = path.trim();

    // رابط كامل من Backend
    if (value.startsWith('$baseUrl/storage/')) {
      return true;
    }

    // أي رابط خارجي مثل Picsum
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return false;
    }

    // مسار Backend مثل salons/cover.jpg
    return true;
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    homeController.changeIndex(1);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => exploreController.refreshData(),

          child: Obx(() {
            if (exploreController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                const SizedBox(height: 20),

                _buildSearchBar(),

                const SizedBox(height: 12),

                _buildTagsOrCategories(),

                const SizedBox(height: 12),

                _buildCities(),

                const SizedBox(height: 10),

                _buildActiveFilters(),

                const SizedBox(height: 5),

                _buildTabs(),

                const Divider(),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: _buildGrid(),
                  ),
                ),
              ],
            );
          }),
        ),
      ),

      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),

      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 62,

              decoration: BoxDecoration(
                color: const Color(0xffECEAEC),
                borderRadius: BorderRadius.circular(20),
              ),

              child: TextField(
                onChanged: (value) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    exploreController.updateSearch(value);
                  });
                },

                decoration: const InputDecoration(
                  border: InputBorder.none,

                  prefixIcon: Icon(Icons.search, color: Color(0xFF591C27)),

                  hintText: "Search",

                  hintStyle: TextStyle(color: Color(0xFF591C27)),

                  contentPadding: EdgeInsets.symmetric(vertical: 18),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          GestureDetector(
            onTap: () => _showFilterDialog(),

            child: Container(
              width: 52,
              height: 52,

              decoration: BoxDecoration(
                color: const Color(0xffEFD96F),
                borderRadius: BorderRadius.circular(15),
              ),

              child: const Icon(Icons.tune, color: Color(0xFF591C27)),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TAGS OR CATEGORIES
  // ============================================================

  Widget _buildTagsOrCategories() {
    if (exploreController.currentTabIndex.value == 3) {
      return _buildCategoriesWidget();
    }

    return _buildTagsWidget();
  }

  // ============================================================
  // TAGS
  // ============================================================

  Widget _buildTagsWidget() {
    return SizedBox(
      height: 35,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: exploreController.availableTags.length,

        itemBuilder: (context, index) {
          final tag = exploreController.availableTags[index];

          final isSelected = exploreController.selectedTag.value == tag;

          return GestureDetector(
            onTap: () {
              if (isSelected) {
                exploreController.updateTag('');
              } else {
                exploreController.updateTag(tag);
              }
            },

            child: Container(
              margin: const EdgeInsets.only(left: 15),

              padding: const EdgeInsets.symmetric(horizontal: 15),

              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF591C27)
                    : const Color(0xFF9E9E9E),

                borderRadius: BorderRadius.circular(20),
              ),

              child: Center(
                child: Text(
                  isSelected ? "✓ $tag" : "× $tag",

                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // CATEGORIES
  // ============================================================

  Widget _buildCategoriesWidget() {
    return Obx(() {
      final cats = exploreController.categories;

      if (cats.isEmpty) {
        return const SizedBox(
          height: 35,

          child: Center(child: Text('لا توجد تصنيفات')),
        );
      }

      return SizedBox(
        height: 35,

        child: ListView.builder(
          scrollDirection: Axis.horizontal,

          itemCount: cats.length,

          itemBuilder: (context, index) {
            final cat = cats[index];

            final isSelected =
                exploreController.selectedCategory.value ==
                cat['id'].toString();

            return GestureDetector(
              onTap: () {
                exploreController.updateCategory(cat['id'].toString());
              },

              child: Container(
                margin: const EdgeInsets.only(left: 15),

                padding: const EdgeInsets.symmetric(horizontal: 15),

                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF591C27)
                      : const Color(0xFF9E9E9E),

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Center(
                  child: Text(
                    isSelected
                        ? "✓ ${cat['name_ar'] ?? cat['name_en'] ?? ''}"
                        : "${cat['name_ar'] ?? cat['name_en'] ?? ''}",

                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  // ============================================================
  // CITIES
  // ============================================================

  Widget _buildCities() {
    return SizedBox(
      height: 38,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: exploreController.availableCities.length,

        itemBuilder: (context, index) {
          final city = exploreController.availableCities[index];

          final isSelected = exploreController.selectedCity.value == city;

          return GestureDetector(
            onTap: () {
              if (isSelected) {
                exploreController.updateCity('');
              } else {
                exploreController.updateCity(city);
              }
            },

            child: Container(
              margin: const EdgeInsets.only(left: 15),

              padding: const EdgeInsets.symmetric(horizontal: 18),

              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF702E3A)
                    : const Color(0xFF676F73),

                borderRadius: BorderRadius.circular(20),
              ),

              child: Center(
                child: Text(
                  city,

                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // ACTIVE FILTERS
  // ============================================================

  Widget _buildActiveFilters() {
    final city = exploreController.selectedCity.value;

    final tag = exploreController.selectedTag.value;

    final search = exploreController.searchQuery.value;

    final category = exploreController.selectedCategory.value;

    if (city.isEmpty && tag.isEmpty && search.isEmpty && category.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 40,

      padding: const EdgeInsets.symmetric(horizontal: 18),

      child: ListView(
        scrollDirection: Axis.horizontal,

        children: [
          if (city.isNotEmpty)
            _buildFilterChip(
              "City: $city",
              () => exploreController.updateCity(''),
            ),

          if (tag.isNotEmpty)
            _buildFilterChip(
              "Tag: $tag",
              () => exploreController.updateTag(''),
            ),

          if (search.isNotEmpty)
            _buildFilterChip(
              "Search: $search",
              () => exploreController.updateSearch(''),
            ),

          if (category.isNotEmpty)
            _buildFilterChip(
              "Category: ${_getCategoryName(category)}",
              () => exploreController.updateCategory(''),
            ),

          const SizedBox(width: 8),

          GestureDetector(
            onTap: exploreController.clearFilters,

            child: const Chip(
              label: Text('Clear All'),

              backgroundColor: Colors.red,

              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CATEGORY NAME
  // ============================================================

  String _getCategoryName(String id) {
    final cat = exploreController.categories.firstWhereOrNull(
      (c) => c['id'].toString() == id,
    );

    return cat != null ? (cat['name_ar'] ?? cat['name_en'] ?? '') : id;
  }

  // ============================================================
  // FILTER CHIP
  // ============================================================

  Widget _buildFilterChip(String label, VoidCallback onDelete) {
    return Container(
      margin: const EdgeInsets.only(right: 8),

      child: Chip(
        label: Text(label),

        onDeleted: onDelete,

        deleteIcon: const Icon(Icons.close, size: 16),
      ),
    );
  }

  // ============================================================
  // TABS
  // ============================================================

  Widget _buildTabs() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          _buildTabItem("Salons", 0),
          _buildTabItem("Centers", 1),
          _buildTabItem("Experts", 2),
          _buildTabItem("Products", 3),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = exploreController.currentTabIndex.value == index;

    return GestureDetector(
      onTap: () => exploreController.changeTab(index),

      child: Text(
        title,

        style: TextStyle(
          fontSize: 16,

          color: isSelected ? const Color(0xFF591C27) : const Color(0xFF676F73),

          decoration: isSelected ? TextDecoration.underline : null,

          decorationColor: const Color(0xFF591C27),

          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }

  // ============================================================
  // GRID
  // ============================================================

  Widget _buildGrid() {
    final items = exploreController.getCurrentItems();

    if (items.isEmpty) {
      return const Center(
        child: Text(
          "لا توجد بيانات متاحة",

          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      itemCount: items.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 18,
        childAspectRatio: 0.72,
      ),

      itemBuilder: (context, index) {
        final item = items[index];

        String name = '';
        String type = '';
        String? imageUrl;

        double rating = 0;

        String? price;

        // ------------------------------------------------------
        // SALON
        // ------------------------------------------------------

        if (item is Salon) {
          name = item.name;

          type = 'salon';

          imageUrl = item.profilePhoto;

          rating = item.ratingAvg;
        }
        // ------------------------------------------------------
        // BEAUTY CENTER
        // ------------------------------------------------------
        else if (item is BeautyCenter) {
          name = item.name;

          type = 'beauty center';

          imageUrl = item.profilePhoto;

          rating = item.ratingAvg;
        }
        // ------------------------------------------------------
        // EXPERT
        // ------------------------------------------------------
        else if (item is Expert) {
          name = item.fullName;

          type = 'expert';

          imageUrl = item.profilePhoto;

          rating = item.ratingAvg;
        }
        // ------------------------------------------------------
        // PRODUCT
        // ------------------------------------------------------
        else if (item is Map<String, dynamic>) {
          name = item['name']?.toString() ?? 'منتج';

          type = 'product';

          imageUrl =
              item['main_image']?.toString() ?? item['image']?.toString();

          price = item['price']?.toString() ?? '0';

          rating = 0;
        }

        return _buildCard(
          name: name,
          type: type,
          imageUrl: imageUrl,
          rating: rating,
          item: item,
          price: price,
        );
      },
    );
  }

  // ============================================================
  // CARD
  // ============================================================

  Widget _buildCard({
    required String name,
    required String type,
    String? imageUrl,
    required double rating,
    required dynamic item,
    String? price,
  }) {
    final FavoriteController favController = Get.find<FavoriteController>();

    String providerType = '';

    int providerId = 0;

    // ----------------------------------------------------------
    // PROVIDER TYPE + ID
    // ----------------------------------------------------------

    if (item is Salon) {
      providerType = 'salon';
      providerId = item.id;
    } else if (item is BeautyCenter) {
      providerType = 'beauty_center';
      providerId = item.id;
    } else if (item is Expert) {
      providerType = 'expert';
      providerId = item.id;
    } else if (item is Map<String, dynamic> && type == 'product') {
      providerId = item['provider_id'] ?? 0;

      providerType = item['provider_type'] ?? '';
    }

    // ----------------------------------------------------------
    // VALID BACKEND IMAGE
    // ----------------------------------------------------------

    final bool hasImage = _hasValidBackendImage(imageUrl);

    final String fullImageUrl = hasImage ? _getFullImageUrl(imageUrl!) : '';

    // ----------------------------------------------------------
    // CARD
    // ----------------------------------------------------------

    return GestureDetector(
      onTap: () {
        // ------------------------------------------------------
        // PROVIDER
        // ------------------------------------------------------

        if (item is Salon || item is BeautyCenter || item is Expert) {
          String providerScreenType = '';

          if (item is Salon) {
            providerScreenType = 'salon';
          } else if (item is BeautyCenter) {
            providerScreenType = 'beauty_center';
          } else if (item is Expert) {
            providerScreenType = 'expert';
          }

          Get.to(
            () => ProviderDetailsScreen(),

            arguments: {'provider': item, 'type': providerScreenType},
          );
        }
        // ------------------------------------------------------
        // PRODUCT
        // ------------------------------------------------------
        else if (type == 'product') {
          final int productId = (item as Map<String, dynamic>)['id'] ?? 0;

          if (productId > 0) {
            Get.to(
              () => ProductDetailsScreen(),

              arguments: {'productId': productId},
            );
          } else {
            Get.snackbar('خطأ', 'معرف المنتج غير صحيح');
          }
        }
      },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),

          color: Colors.white,

          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisSize: MainAxisSize.min,

          children: [
            // ==================================================
            // IMAGE
            // ==================================================
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),

                  child: Container(
                    height: 140,

                    width: double.infinity,

                    color: Colors.grey[200],

                    child: hasImage && fullImageUrl.isNotEmpty
                        ? Image.network(
                            fullImageUrl,

                            width: double.infinity,

                            height: 140,

                            fit: BoxFit.cover,

                            headers: const {
                              'User-Agent':
                                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                            },

                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return Container(
                                width: double.infinity,

                                height: 140,

                                color: Colors.grey[200],

                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },

                            // لا توجد صورة بديلة
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint('❌ IMAGE ERROR');

                              debugPrint('URL: $fullImageUrl');

                              debugPrint('ERROR: $error');

                              return const SizedBox.shrink();
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ),

                // ==================================================
                // FAVORITE
                // ==================================================
                if (type != 'product')
                  Positioned(
                    top: 12,
                    right: 12,

                    child: GestureDetector(
                      onTap: () {
                        if (providerType.isNotEmpty && providerId != 0) {
                          favController.toggleFavorite(
                            providerType,
                            providerId,
                          );
                        }
                      },

                      child: Obx(() {
                        final isFav = favController.isFavorited(
                          providerType,
                          providerId,
                        );

                        return Container(
                          padding: const EdgeInsets.all(4),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),

                            shape: BoxShape.circle,
                          ),

                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,

                            color: isFav ? Colors.red : Colors.grey,

                            size: 22,
                          ),
                        );
                      }),
                    ),
                  ),
              ],
            ),

            // ==================================================
            // INFO
            // ==================================================
            Padding(
              padding: const EdgeInsets.all(10),

              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          name,

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,

                            fontSize: 16,
                          ),

                          overflow: TextOverflow.ellipsis,

                          maxLines: 1,
                        ),

                        if (type == 'product')
                          Text(
                            '${price ?? '0'} JOD',

                            style: const TextStyle(
                              color: Color(0xFF591C27),

                              fontWeight: FontWeight.bold,

                              fontSize: 14,
                            ),
                          )
                        else
                          Text(
                            type,

                            style: const TextStyle(
                              color: Colors.grey,

                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),

                  if (type != 'product')
                    Container(
                      width: 28,
                      height: 28,

                      decoration: const BoxDecoration(
                        color: Color(0xffEFD96F),

                        shape: BoxShape.circle,
                      ),

                      child: Center(
                        child: Text(
                          rating.toStringAsFixed(0),

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,

                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FILTER DIALOG
  // ============================================================

  void _showFilterDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),

        decoration: const BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            const Text(
              'Filter Options',

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text('Min Rating:'),

                const SizedBox(width: 10),

                Obx(
                  () => Text(
                    exploreController.minRating.value.toStringAsFixed(1),
                  ),
                ),

                Expanded(
                  child: Obx(
                    () => Slider(
                      value: exploreController.minRating.value,

                      min: 0,

                      max: 5,

                      divisions: 10,

                      onChanged: (val) {
                        exploreController.updateMinRating(val);
                      },
                    ),
                  ),
                ),
              ],
            ),

            Obx(
              () => DropdownButtonFormField<String>(
                value: exploreController.genderServed.value.isEmpty
                    ? null
                    : exploreController.genderServed.value,

                hint: const Text('Gender Served'),

                items: const [
                  DropdownMenuItem(value: '', child: Text('All')),

                  DropdownMenuItem(value: 'male', child: Text('Male')),

                  DropdownMenuItem(value: 'female', child: Text('Female')),

                  DropdownMenuItem(value: 'both', child: Text('Both')),
                ],

                onChanged: (val) {
                  exploreController.updateGender(val ?? '');
                },
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),

                  child: const Text('Apply'),
                ),

                ElevatedButton(
                  onPressed: () {
                    exploreController.clearFilters();

                    Get.back();
                  },

                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNav() {
    return Obx(
      () => Container(
        height: 90,

        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),

            topRight: Radius.circular(30),
          ),

          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),

        child: BottomNavigationBar(
          currentIndex: homeController.currentIndex.value,

          type: BottomNavigationBarType.fixed,

          selectedItemColor: const Color(0xFF591C27),

          unselectedItemColor: const Color(0xFF591C27),

          showSelectedLabels: false,

          showUnselectedLabels: false,

          onTap: (index) {
            homeController.changeIndex(index);

            if (index == 0) {
              Get.off(() => HomeScreen());
            } else if (index == 1) {
              Get.off(() => ExploreScreen());
            } else if (index == 2) {
              Get.off(() => Conversationsscreen());
            } else if (index == 3) {
              Get.to(() => ReservationsScreen());
            } else if (index == 4) {
              Get.off(() => SettingScreen());
            }
          },

          items: [
            BottomNavigationBarItem(
              icon: ImageButtonWidget(imagePath: ImageAssets.home),

              activeIcon: Padding(
                padding: EdgeInsets.only(left: 10),

                child: ImageButtonWidget2(
                  imagePath: ImageAssets.BottomNavigationBar6,
                ),
              ),

              label: '',
            ),

            BottomNavigationBarItem(
              icon: ImageButtonWidget(
                imagePath: ImageAssets.BottomNavigationBar2,
              ),

              activeIcon: Padding(
                padding: EdgeInsets.only(left: 10),

                child: ImageButtonWidget2(imagePath: ImageAssets.Frame1),
              ),

              label: '',
            ),

            BottomNavigationBarItem(
              icon: ImageButtonWidget(
                imagePath: ImageAssets.BottomNavigationBar3,
              ),

              activeIcon: Padding(
                padding: EdgeInsets.only(left: 10),

                child: ImageButtonWidget2(imagePath: ImageAssets.Frame2),
              ),

              label: '',
            ),

            BottomNavigationBarItem(
              icon: ImageButtonWidget(
                imagePath: ImageAssets.BottomNavigationBar4,
              ),

              activeIcon: Padding(
                padding: EdgeInsets.only(left: 10),

                child: ImageButtonWidget2(imagePath: ImageAssets.Frame3),
              ),

              label: '',
            ),

            BottomNavigationBarItem(
              icon: ImageButtonWidget(
                imagePath: ImageAssets.BottomNavigationBar5,
              ),

              activeIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 5),

                child: ImageButtonWidget2(imagePath: ImageAssets.Frame4),
              ),

              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
