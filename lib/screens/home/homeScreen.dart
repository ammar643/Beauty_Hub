import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/api/app_config.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/models/beauty_center_model.dart';
import 'package:project_user/models/expert_model.dart';
import 'package:project_user/models/post_model.dart';
import 'package:project_user/models/salon_model.dart';
import 'package:project_user/screens/ConversationsScreen.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationsScreen%20.dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/medical_record_screen.dart';
import 'package:project_user/screens/wallet_screen.dart';
import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';
import 'package:project_user/widgets/home/MySlider.dart';

 final String baseUrl = appConfig;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ============================================================
  // بناء رابط الصورة
  // ============================================================

  String _getFullImageUrl(String? path) {
    if (path == null || path.trim().isEmpty) {
      return '';
    }

    String cleanPath = path.trim();

    // إذا كان الرابط كاملاً
    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return cleanPath;
    }

    // إزالة / من البداية
    cleanPath = cleanPath.replaceFirst(RegExp(r'^/+'), '');

    // إذا كان Laravel يرجع storage/...
    if (cleanPath.startsWith('storage/')) {
      return '$baseUrl/$cleanPath';
    }

    // إذا كان يرجع فقط اسم الملف أو المسار
    return '$baseUrl/storage/$cleanPath';
  }

  // ============================================================
  // Headers
  // ============================================================

  Map<String, String> get _imageHeaders {
    return {
      'User-Agent': 'Mozilla/5.0',
      'Accept':
          'image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8',
    };
  }

  // ============================================================
  // صورة Network آمنة
  // ============================================================

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

      // أثناء التحميل
      loadingBuilder:
          (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child;
            }

            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: borderRadius,
              ),
              child: const Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },

      // عند فشل الصورة
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
            debugPrint('❌ IMAGE ERROR');
            debugPrint('URL: $imageUrl');
            debugPrint('ERROR: $error');

            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: borderRadius,
              ),
              child: const Center(
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
      return ClipRRect(borderRadius: borderRadius, child: image);
    }

    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,

      // ============================================================
      // DRAWER
      // ============================================================
      drawer: Drawer(
        child: SafeArea(
          child: Obx(() {
            final user = controller.user.value;

            final String userImageUrl = _getFullImageUrl(user?.profilePhoto);

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  decoration: const BoxDecoration(color: Color(0xFF591C27)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: userImageUrl.isNotEmpty
                              ? _networkImage(
                                  imageUrl: userImageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        user?.fullName ?? 'مرحباً بك',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        user?.email ?? 'البريد الإلكتروني',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                _buildDrawerItem(
                  icon: Icons.wallet,
                  title: 'المحفظة',
                  onTap: () {
                    Get.back();
                    Get.to(() => WalletScreen());
                  },
                ),

                _buildDrawerItem(
                  icon: Icons.person_outline,
                  title: 'الملف الشخصي',
                  onTap: () {
                    Get.back();

                    Get.snackbar('قريباً', 'صفحة الملف الشخصي قيد التطوير');
                  },
                ),

                _buildDrawerItem(
                  icon: Icons.health_and_safety,
                  title: 'السجل الطبي',
                  onTap: () {
                    Get.back();
                    Get.to(() => MedicalRecordScreen());
                  },
                ),

                _buildDrawerItem(
                  icon: Icons.history,
                  title: 'الحجوزات السابقة',
                  onTap: () {
                    Get.back();

                    Get.snackbar('قريباً', 'صفحة الحجوزات قيد التطوير');
                  },
                ),

                _buildDrawerItem(
                  icon: Icons.settings,
                  title: 'الإعدادات',
                  onTap: () {
                    Get.back();

                    Get.snackbar('قريباً', 'صفحة الإعدادات قيد التطوير');
                  },
                ),

                const Spacer(),

                _buildDrawerItem(
                  icon: Icons.logout,
                  title: 'تسجيل الخروج',
                  onTap: () {
                    Get.back();

                    Get.snackbar('تسجيل الخروج', 'سيتم تسجيل الخروج قريباً');
                  },
                ),

                const SizedBox(height: 20),
              ],
            );
          }),
        ),
      ),

      // ============================================================
      // APP BAR
      // ============================================================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 33,
                    color: Color(0xFF591C27),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Image.asset(
                      ImageAssets.photoBeautHub,
                      width: 105,
                      height: 25,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                Container(
                  width: 46,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.testphoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ============================================================
      // BODY
      // ============================================================
      body: RefreshIndicator(
        onRefresh: () => controller.refreshData(),

        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.salons.isEmpty &&
              controller.beautyCenters.isEmpty &&
              controller.experts.isEmpty &&
              controller.posts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'لا توجد بيانات متاحة حالياً',
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      controller.refreshData();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const MySlider(),

              const SizedBox(height: 10),

              // ====================================================
              // SALONS
              // ====================================================
              if (controller.salons.isNotEmpty)
                _buildHorizontalSection(
                  title: 'أفضل الصالونات:',
                  items: controller.salons,
                ),

              if (controller.salons.isNotEmpty) const SizedBox(height: 5),

              // ====================================================
              // BEAUTY CENTERS
              // ====================================================
              if (controller.beautyCenters.isNotEmpty)
                _buildHorizontalSection(
                  title: 'أفضل المراكز:',
                  items: controller.beautyCenters,
                ),

              if (controller.beautyCenters.isNotEmpty)
                const SizedBox(height: 5),

              // ====================================================
              // EXPERTS
              // ====================================================
              if (controller.experts.isNotEmpty)
                _buildHorizontalSection(
                  title: 'أفضل الخبراء:',
                  items: controller.experts,
                ),

              if (controller.experts.isNotEmpty) const SizedBox(height: 5),

              // ====================================================
              // DIVIDER
              // ====================================================
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Divider(
                  thickness: 3,
                  color: Color(0xffE5E5E5),
                  height: 3,
                ),
              ),

              // ====================================================
              // POSTS TITLE
              // ====================================================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'المنشورات',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 5),

              // ====================================================
              // POSTS
              // ====================================================
              if (controller.posts.isNotEmpty)
                ...controller.posts.map((post) => _buildPostCard(post)),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text(
                  'Sign up to comment, edit, inspect and review your profile.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),
            ],
          );
        }),
      ),

      // ============================================================
      // BOTTOM NAVIGATION
      // ============================================================
      bottomNavigationBar: Container(
        height: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),

        child: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,

            onTap: (index) {
              controller.changeIndex(index);

              if (index == 1) {
                Get.to(() => ExploreScreen());
              } else if (index == 2) {
                Get.to(() => Conversationsscreen());
              } else if (index == 3) {
                Get.to(() => ReservationsScreen());
              } else if (index == 4) {
                Get.off(() => SettingScreen());
              }
            },

            type: BottomNavigationBarType.fixed,

            selectedItemColor: const Color(0xFF591C27),

            unselectedItemColor: const Color(0xFF591C27),

            showSelectedLabels: false,
            showUnselectedLabels: false,

            items: [
              BottomNavigationBarItem(
                icon: ImageButtonWidget(imagePath: ImageAssets.home),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
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
                  padding: const EdgeInsets.only(left: 10),
                  child: ImageButtonWidget2(imagePath: ImageAssets.Frame1),
                ),
                label: '',
              ),

              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar3,
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ImageButtonWidget2(imagePath: ImageAssets.Frame2),
                ),
                label: '',
              ),

              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar4,
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ImageButtonWidget2(imagePath: ImageAssets.Frame3),
                ),
                label: '',
              ),

              BottomNavigationBarItem(
                icon: ImageButtonWidget(
                  imagePath: ImageAssets.BottomNavigationBar5,
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: ImageButtonWidget2(imagePath: ImageAssets.Frame4),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DRAWER ITEM
  // ============================================================

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF591C27)),
      title: Text(title),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  // ============================================================
  // HORIZONTAL SECTION
  // ============================================================

  Widget _buildHorizontalSection<T>({
    required String title,
    required List<T> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 90,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            padding: const EdgeInsets.symmetric(horizontal: 12),

            itemCount: items.length,

            itemBuilder: (context, index) {
              final item = items[index];

              String imageUrl = '';

              if (item is Salon) {
                imageUrl = item.profilePhoto ?? '';
              } else if (item is BeautyCenter) {
                imageUrl = item.profilePhoto ?? '';
              } else if (item is Expert) {
                imageUrl = item.profilePhoto ?? '';
              }

              final String fullUrl = _getFullImageUrl(imageUrl);

              // مهم جدًا لمعرفة من أين يأتي الرابط
              debugPrint('================================');
              debugPrint('TYPE: ${item.runtimeType}');
              debugPrint('IMAGE FROM API: $imageUrl');
              debugPrint('FINAL IMAGE URL: $fullUrl');
              debugPrint('================================');

              return Padding(
                padding: const EdgeInsets.only(right: 12),

                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[200],

                  child: ClipOval(
                    child: fullUrl.isNotEmpty
                        ? _networkImage(
                            imageUrl: fullUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Widget _buildPostCard(Post post) {
    final String avatarUrl = _getFullImageUrl(post.userAvatar);
    final List<String> imageUrls = post.mediaUrls
        .map((url) => _getFullImageUrl(url))
        .where((url) => url.isNotEmpty)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== POST HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Color(0x69000000), blurRadius: 4),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.grey[200],
                              child: ClipOval(
                                child: avatarUrl.isNotEmpty
                                    ? _networkImage(
                                        imageUrl: avatarUrl,
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox.shrink(), // لا صورة وهمية
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.userName ?? 'مقدم الخدمة',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    post.userType ?? 'salon',
                                    style: const TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xffEFD96F),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 4),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "متابعة",
                        style: TextStyle(
                          color: Color(0xFF591C27),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ===== POST CAPTION =====
              if (post.caption != null && post.caption!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    post.caption!,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              const SizedBox(height: 8),

              // ===== POST IMAGES =====
              if (imageUrls.isNotEmpty)
                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: PageView(
                    children: imageUrls.map<Widget>((fullUrl) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _networkImage(
                          imageUrl: fullUrl,
                          width: double.infinity,
                          height: 320,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                )
              else
                const SizedBox.shrink(), // لا توجد صور، لا شيء
              // ===== LIKES COUNT =====
              if (post.likesCount > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${post.likesCount} إعجاب',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
