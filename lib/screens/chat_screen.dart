import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController controller = Get.put(ChatController());
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final String otherType = args?['otherType'] ?? 'salon';
    final int otherId = args?['otherId'] ?? 0;
    final String otherName = args?['otherName'] ?? 'المزود';
    final String? otherPhoto = args?['otherPhoto'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (otherId != 0) {
        controller.openChat(
          otherType: otherType,
          otherId: otherId,
          otherName: otherName,
          otherPhoto: otherPhoto,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final other = controller.otherUser;
          return Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: otherPhoto != null && otherPhoto.isNotEmpty
                    ? NetworkImage(
                        otherPhoto,
                        headers: {
                          'User-Agent':
                              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                        },
                      ) as ImageProvider
                    :  AssetImage(ImageAssets.testphoto),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 10),
              Text(
                other['name'] ?? otherName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          );
        }),
        backgroundColor: const Color(0xFF591C27),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => controller.refreshMessages(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final messages = controller.messages;

              if (messages.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 60, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'لا توجد رسائل بعد',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              // ✅ عرض الرسائل من الأحدث إلى الأقدم (عكسياً)
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMine = message['is_mine'] ?? false;
                  final content = message['content'] ?? '';
                  final mediaUrl = message['media_url'] as String?;
                  final time = message['created_at'] ?? '';
                  final isImage = mediaUrl != null && mediaUrl.isNotEmpty;

                  return Align(
                    alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isMine
                            ? const Color(0xFF591C27)
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: isMine
                              ? const Radius.circular(12)
                              : const Radius.circular(0),
                          bottomRight: isMine
                              ? const Radius.circular(0)
                              : const Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ إذا كانت رسالة صورة
                          if (isImage)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                mediaUrl!,
                                headers: {
                                  'User-Agent':
                                      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                                },
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 180,
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          // ✅ إذا كانت رسالة نصية
                          if (content.isNotEmpty)
                            Text(
                              content,
                              style: TextStyle(
                                color: isMine ? Colors.white : Colors.black87,
                                fontSize: 15,
                              ),
                            ),

                          const SizedBox(height: 4),
                          Text(
                            _formatTime(time),
                            style: TextStyle(
                              color: isMine ? Colors.white70 : Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // ===== حقل الإدخال مع زر الصور =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // ✅ زر اختيار الصورة
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xffEFD96F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.image,
                      color: Color(0xFF591C27),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'اكتب رسالة...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() {
                  return GestureDetector(
                    onTap: controller.isSending.value ? null : _sendMessage,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF591C27),
                        shape: BoxShape.circle,
                      ),
                      child: controller.isSending.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      controller.sendMessage(text);
      _textController.clear();
    }
  }

  // ✅ دالة اختيار صورة من المعرض
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (image != null) {
        print("📁 Image path: ${image.path}");
        await controller.sendImage(image.path);
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل اختيار الصورة: $e');
    }
  }

  String _formatTime(String? timeString) {
    if (timeString == null) return '';
    try {
      final time = DateTime.tryParse(timeString);
      if (time == null) return '';
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }
}