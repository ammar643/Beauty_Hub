import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_user/constant/imageAssets.dart';
import 'package:project_user/controllers/conversations_controller.dart';
import 'package:project_user/controllers/home/HomeController.dart';
import 'package:project_user/screens/chat_screen.dart';
import 'package:project_user/screens/home/ExploreScreen.dart';
import 'package:project_user/screens/home/ReservationsScreen/ReservationsScreen%20.dart';
import 'package:project_user/screens/home/SettingScreen.dart';
import 'package:project_user/screens/home/homeScreen.dart';
import 'package:project_user/widgets/home/ImageButtonWidget.dart';
import 'package:project_user/widgets/home/ImageButtonWidget2.dart';

class Conversationsscreen extends StatelessWidget {
  Conversationsscreen({super.key});

  final HomeController homeController = Get.find();
  final ConversationsController chatsController = Get.put(
    ConversationsController(),
  );

  @override
  Widget build(BuildContext context) {
    homeController.changeIndex(2);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            // ===== FOLLOWS TITLE =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Follows",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // ===== FOLLOWS LIST =====
            _buildFollowsList(),

            const SizedBox(height: 10),

            // ===== CHATS TITLE =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Chats",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ===== CHATS LIST =====
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => chatsController.refreshConversations(),
                child: Obx(() {
                  if (chatsController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final conversations = chatsController.conversations;

                  if (conversations.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 60,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'لا توجد محادثات',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final chat = conversations[index];
                      final other = chat['other'] ?? {};
                      final lastMessage = chat['last_message'] ?? {};
                      final unreadCount = chat['unread_count'] ?? 0;

                      final String chatId = (chat['chat_id'] ?? 0).toString();
                      final String otherName = other['name'] ?? 'مزود';
                      final String otherType = other['type'] ?? 'salon';
                      final int otherId = other['id'] ?? 0;
                      final String? otherPhoto = other['photo'];
                      final String lastMessageContent =
                          lastMessage['content'] ?? '...';
                      final String lastMessageAt =
                          lastMessage['created_at'] ?? '';

                      return _buildChatCard(
                        chatId: chatId,
                        otherName: otherName,
                        otherType: otherType,
                        otherId: otherId,
                        otherPhoto: otherPhoto,
                        lastMessage: lastMessageContent,
                        lastMessageAt: lastMessageAt,
                        unreadCount: unreadCount,
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),

      // ===== BOTTOM NAVIGATION =====
      bottomNavigationBar: Obx(
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
              if (index == 0)
                Get.off(() => HomeScreen());
              else if (index == 1)
                Get.off(() => ExploreScreen());
              else if (index == 2)
                Get.off(() => Conversationsscreen());
              else if (index == 3)
                Get.to(() => ReservationsScreen());
              else if (index == 4)
                Get.off(() => SettingScreen());
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
      ),
    );
  }

  Widget _buildFollowsList() {
    final List<String> follows = [
      ImageAssets.testphoto,
      ImageAssets.onbording1,
      ImageAssets.onbording2,
      ImageAssets.Rectangle,
    ];

    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: follows.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 12),
            width: 75,
            height: 75,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(follows[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ===== CHAT CARD =====
  Widget _buildChatCard({
    required String chatId,
    required String otherName,
    required String otherType,
    required int otherId,
    String? otherPhoto,
    required String lastMessage,
    required String lastMessageAt,
    required int unreadCount,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ChatScreen(),
          arguments: {
            'chatId': int.tryParse(chatId) ?? 0,
            'otherType': otherType,
            'otherId': otherId,
            'otherName': otherName,
            'otherPhoto': otherPhoto,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xffECECEC),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          children: [
            // ===== Profile Photo =====
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: otherPhoto != null && otherPhoto.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(
                          otherPhoto,
                          headers: {
                            'User-Agent':
                                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                          },
                        ),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: AssetImage(ImageAssets.testphoto),
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            const SizedBox(width: 12),

            // ===== Name and Last Message =====
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        otherName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xFF591C27),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$unreadCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // ===== Time =====
            Align(
              alignment: Alignment.topRight,
              child: Text(
                _formatDate(lastMessageAt),
                style: const TextStyle(color: Color(0xFF591C27), fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';
    try {
      final date = DateTime.tryParse(dateString);
      if (date == null) return '';
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inDays == 0) {
        return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      } else if (diff.inDays == 1) {
        return 'أمس';
      } else if (diff.inDays < 7) {
        return '${diff.inDays} أيام';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return '';
    }
  }
}
