import 'package:get/get.dart';
import 'package:project_user/services/chat_service.dart';

class ConversationsController extends GetxController {
  final ChatService _chatsService = ChatService();

  var isLoading = true.obs;
  var conversations = <Map<String, dynamic>>[].obs;
  var totalUnread = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchConversations();
  }

  Future<void> fetchConversations() async {
    isLoading.value = true;
    final result = await _chatsService.fetchConversations();

    if (result != null && result['success'] == true) {
      final data = result['data'] as Map<String, dynamic>;
      conversations.value = (data['conversations'] as List?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [];
      totalUnread.value = data['total_unread'] ?? 0;
    } else {
      conversations.clear();
      Get.snackbar('خطأ', result?['message'] ?? 'فشل جلب المحادثات');
    }
    isLoading.value = false;
  }

  Future<void> refreshConversations() async {
    await fetchConversations();
  }
}