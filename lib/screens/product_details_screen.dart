import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/controllers/product_details_controller.dart';
import 'package:project_user/utiles/image_helper.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  final ProductDetailsController controller = Get.put(
    ProductDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;

    final int productId =
        arguments != null && arguments['productId'] != null
            ? int.tryParse(arguments['productId'].toString()) ?? 0
            : 0;

    controller.setProductId(productId);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF591C27),
              ),
            );
          }

          final product = controller.product;

          if (product.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد بيانات للمنتج',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            );
          }

          // ============================================================
          // DATA FROM BACKEND ONLY
          // ============================================================

          final String name =
              product['name']?.toString() ?? '';

          final String description =
              product['description']?.toString() ?? '';

          final double price =
              double.tryParse(
                    product['price']?.toString() ?? '0',
                  ) ??
                  0.0;

          final String mainImage =
              product['main_image']?.toString() ?? '';

          final int stockQuantity =
              int.tryParse(
                    product['stock_quantity']?.toString() ?? '0',
                  ) ??
                  0;

          final bool inStock =
              product['in_stock'] == true ||
              product['in_stock']?.toString() == '1';

          final String providerType =
              product['provider_type']?.toString() ?? '';

          // إذا كان الـ API يرجع rating استخدمه.
          // لا نضع قيمة وهمية.
          final double rating =
              double.tryParse(
                    product['rating']?.toString() ?? '',
                  ) ??
                  0.0;

          return Column(
            children: [
              // ========================================================
              // BACK BUTTON
              // ========================================================

              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF591C27),
                      size: 24,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ),

              // ========================================================
              // CONTENT
              // ========================================================

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ==================================================
                      // PRODUCT IMAGE
                      // BACKEND ONLY
                      // ==================================================

                      _buildProductImage(mainImage),

                      // ==================================================
                      // PRODUCT DETAILS CARD
                      // ==================================================

                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 30,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            // ==========================================
                            // PRODUCT NAME + RATING
                            // ==========================================

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    name.isNotEmpty
                                        ? name
                                        : 'بدون اسم',
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight:
                                          FontWeight.w800,
                                      letterSpacing: -0.5,
                                      color:
                                          Color(0xFF1A1A2E),
                                    ),
                                    maxLines: 2,
                                    overflow:
                                        TextOverflow.ellipsis,
                                  ),
                                ),

                                // ======================================
                                // RATING FROM BACKEND ONLY
                                // ======================================

                                if (rating > 0)
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color:
                                              Color(0xFF591C27),
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          rating.toStringAsFixed(
                                            1,
                                          ),
                                          style:
                                              const TextStyle(
                                            color: Color(
                                              0xFF591C27,
                                            ),
                                            fontWeight:
                                                FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // ==========================================
                            // PROVIDER TYPE
                            // ==========================================

                            if (providerType.isNotEmpty)
                              Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 16,
                                    decoration:
                                        BoxDecoration(
                                      color:
                                          const Color(
                                        0xFF591C27,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(
                                        2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    providerType,
                                    style:
                                        const TextStyle(
                                      fontSize: 15,
                                      color:
                                          Color(0xFF6B6B83),
                                      fontWeight:
                                          FontWeight.w500,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),

                            // ==========================================
                            // DESCRIPTION
                            // BACKEND ONLY
                            // ==========================================

                            if (description.isNotEmpty) ...[
                              const SizedBox(height: 14),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFF8F7FA),
                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                child: Text(
                                  description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color:
                                        Color(0xFF4A4A5A),
                                    height: 1.6,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ],

                            const SizedBox(height: 20),

                            // ==========================================
                            // DIVIDER
                            // ==========================================

                            Container(
                              height: 1,
                              color:
                                  const Color(0xFFE8E8EE),
                            ),

                            const SizedBox(height: 16),

                            // ==========================================
                            // PRICE + STOCK
                            // ==========================================

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'السعر',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color(0xFF8A8A9E),
                                        fontWeight:
                                            FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${price.toStringAsFixed(2)} JOD',
                                      style: const TextStyle(
                                        color:
                                            Color(0xFF1A1A2E),
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),

                                // ======================================
                                // STOCK FROM BACKEND
                                // ======================================

                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: inStock
                                        ? const Color(
                                            0xFFE8F5E9,
                                          )
                                        : const Color(
                                            0xFFFFEBEE,
                                          ),
                                    borderRadius:
                                        BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        inStock
                                            ? Icons.check_circle
                                            : Icons.block,
                                        color: inStock
                                            ? Colors.green
                                            : Colors.red,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        inStock
                                            ? 'متوفر: $stockQuantity'
                                            : 'غير متوفر',
                                        style: TextStyle(
                                          color: inStock
                                              ? Colors.green[700]
                                              : Colors.red[700],
                                          fontWeight:
                                              FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // ==========================================
                            // DIVIDER
                            // ==========================================

                            Container(
                              height: 1,
                              color:
                                  const Color(0xFFE8E8EE),
                            ),

                            const SizedBox(height: 16),

                            // ==========================================
                            // QUANTITY
                            // ==========================================

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'الكمية',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                        FontWeight.w600,
                                    color:
                                        Color(0xFF1A1A2E),
                                  ),
                                ),

                                Container(
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(0xFFF8F7FA),
                                    borderRadius:
                                        BorderRadius.circular(
                                      14,
                                    ),
                                    border: Border.all(
                                      color: const Color(
                                        0xFFE8E8EE,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // ==============================
                                      // MINUS
                                      // ==============================

                                      GestureDetector(
                                        onTap: () {
                                          if (controller
                                                  .quantity
                                                  .value >
                                              1) {
                                            controller.quantity
                                                .value--;
                                          }
                                        },
                                        child: SizedBox(
                                          width: 44,
                                          height: 44,
                                          child: Obx(
                                            () => Icon(
                                              Icons.remove,
                                              color: controller
                                                          .quantity
                                                          .value >
                                                      1
                                                  ? const Color(
                                                      0xFF591C27,
                                                    )
                                                  : const Color(
                                                      0xFFBDBDBD,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // ==============================
                                      // QUANTITY
                                      // ==============================

                                      SizedBox(
                                        width: 44,
                                        height: 44,
                                        child: Center(
                                          child: Obx(
                                            () => Text(
                                              '${controller.quantity.value}',
                                              style:
                                                  const TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Color(
                                                  0xFF1A1A2E,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // ==============================
                                      // PLUS
                                      // ==============================

                                      GestureDetector(
                                        onTap: () {
                                          if (!inStock ||
                                              stockQuantity <=
                                                  0) {
                                            Get.snackbar(
                                              'تنبيه',
                                              'المنتج غير متوفر',
                                              backgroundColor:
                                                  Colors.white,
                                              colorText:
                                                  const Color(
                                                0xFF1A1A2E,
                                              ),
                                              snackPosition:
                                                  SnackPosition
                                                      .BOTTOM,
                                            );
                                            return;
                                          }

                                          if (controller
                                                  .quantity
                                                  .value <
                                              stockQuantity) {
                                            controller.quantity
                                                .value++;
                                          } else {
                                            Get.snackbar(
                                              'تنبيه',
                                              'الكمية المتاحة هي $stockQuantity',
                                              backgroundColor:
                                                  Colors.white,
                                              colorText:
                                                  const Color(
                                                0xFF1A1A2E,
                                              ),
                                              snackPosition:
                                                  SnackPosition
                                                      .BOTTOM,
                                            );
                                          }
                                        },
                                        child: SizedBox(
                                          width: 44,
                                          height: 44,
                                          child: Obx(
                                            () => Icon(
                                              Icons.add,
                                              color: controller
                                                          .quantity
                                                          .value <
                                                      stockQuantity
                                                  ? const Color(
                                                      0xFF591C27,
                                                    )
                                                  : const Color(
                                                      0xFFBDBDBD,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // ==========================================
                            // ACTION BUTTONS
                            // ==========================================

                            Row(
                              children: [
                                // ======================================
                                // BOOK
                                // ======================================

                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration:
                                        BoxDecoration(
                                      gradient:
                                          const LinearGradient(
                                        colors: [
                                          Color(0xffEFD96F),
                                          Color(0xffF5E6A3),
                                        ],
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(
                                        16,
                                      ),
                                    ),
                                    child: ElevatedButton(
                                      onPressed:
                                          inStock &&
                                                  stockQuantity >
                                                      0
                                              ? () {
                                                  Get.snackbar(
                                                    'حجز',
                                                    'سيتم إضافة ${controller.quantity.value} من المنتج إلى الحجز',
                                                    backgroundColor:
                                                        Colors.white,
                                                    colorText:
                                                        const Color(
                                                      0xFF1A1A2E,
                                                    ),
                                                    snackPosition:
                                                        SnackPosition
                                                            .BOTTOM,
                                                    margin:
                                                        const EdgeInsets
                                                            .all(
                                                      16,
                                                    ),
                                                    borderRadius:
                                                        12,
                                                  );
                                                }
                                              : null,
                                      style:
                                          ElevatedButton
                                              .styleFrom(
                                        backgroundColor:
                                            Colors.transparent,
                                        foregroundColor:
                                            const Color(
                                          0xff5A1824,
                                        ),
                                        disabledBackgroundColor:
                                            Colors.transparent,
                                        shadowColor:
                                            Colors.transparent,
                                        shape:
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                            16,
                                          ),
                                        ),
                                        padding:
                                            const EdgeInsets
                                                .symmetric(
                                          vertical: 18,
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        'احجز الآن',
                                        style: TextStyle(
                                          fontWeight:
                                              FontWeight.w800,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // ======================================
                                // TOTAL
                                // ======================================

                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding:
                                        const EdgeInsets
                                            .symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    decoration:
                                        BoxDecoration(
                                      gradient:
                                          const LinearGradient(
                                        colors: [
                                          Color(0xFF591C27),
                                          Color(0xFF7A2D3E),
                                        ],
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(
                                        16,
                                      ),
                                    ),
                                    child: Center(
                                      child: Obx(
                                        () => Column(
                                          children: [
                                            const Text(
                                              'المجموع',
                                              style:
                                                  TextStyle(
                                                color: Colors
                                                    .white70,
                                                fontSize: 11,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              '${(price * controller.quantity.value).toStringAsFixed(2)} JOD',
                                              style:
                                                  const TextStyle(
                                                color:
                                                    Colors.white,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  

  Widget _buildProductImage(String imagePath) {
    if (imagePath.trim().isEmpty) {
      return Container(
        width: double.infinity,
        height: 300,
        color: const Color(0xffEAEAEA),
        child: const Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey,
            size: 50,
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: ImageHelper.cachedImage(
              imagePath,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),

          // Gradient فقط، وليس صورة.
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  const Color(0xffF5F5F5)
                      .withOpacity(0.4),
                  const Color(0xffF5F5F5)
                      .withOpacity(0.9),
                  const Color(0xffF5F5F5),
                ],
                stops: const [
                  0.0,
                  0.3,
                  0.6,
                  0.8,
                  1.0,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}