import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_user/services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService();
  final GetStorage _box = GetStorage();

  var isLoading = false.obs;
  var isSending = false.obs;
  var messages = <Map<String, dynamic>>[].obs;
  var chatId = 0.obs;
  var otherUser = <String, dynamic>{}.obs;
  var currentUserId = 0.obs;

  final List<Map<String, dynamic>> mockMessages = [
    {
      'id': 1,
      'content': 'مرحباً، كيف يمكنني مساعدتك؟',
      'is_mine': false,
      'created_at': DateTime.now().subtract(const Duration(minutes: 5)).toIso8601String(),
    },
    {
      'id': 2,
      'content': 'أريد حجز موعد لقص الشعر.',
      'is_mine': true,
      'created_at': DateTime.now().subtract(const Duration(minutes: 4)).toIso8601String(),
    },
    {
      'id': 3,
      'content': 'تفضل، ما هو الوقت المناسب لك؟',
      'is_mine': false,
      'created_at': DateTime.now().subtract(const Duration(minutes: 3)).toIso8601String(),
    },
    {
      'id': 4,
      'content': 'هل يوجد موعد متاح غداً الساعة 10 صباحاً؟',
      'is_mine': true,
      'created_at': DateTime.now().subtract(const Duration(minutes: 2)).toIso8601String(),
    },
    {
      'id': 5,
      'content': 'نعم، الموعد متاح. هل تؤكد الحجز؟',
      'is_mine': false,
      'created_at': DateTime.now().subtract(const Duration(minutes: 1)).toIso8601String(),
    },
    {
      'id': 6,
      'content': '',
      'media_url': 'https://picsum.photos/seed/chat_image/400/300',
      'is_mine': true,
      'created_at': DateTime.now().toIso8601String(),
    },
  ];

  @override
  void onInit() {
    super.onInit();
    currentUserId.value = _box.read('user_id') ?? 0;
    if (messages.isEmpty) {
      messages.value = mockMessages;
    }
  }

  Future<void> openChat({
    required String otherType,
    required int otherId,
    required String otherName,
    String? otherPhoto,
  }) async {
    isLoading.value = true;
    final result = await _chatService.openChat(
      otherType: otherType,
      otherId: otherId,
    );

    if (result != null && result['success'] == true) {
      final data = result['data'];
      chatId.value = data['chat_id'];
      otherUser.value = data['other'] ?? {};
      await fetchMessages();
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل فتح المحادثة');
    }
    isLoading.value = false;
  }

  Future<void> fetchMessages() async {
    if (chatId.value == 0) return;
    final result = await _chatService.fetchMessages(chatId: chatId.value);
    if (result != null && result['success'] == true) {
      final data = result['data'] as Map<String, dynamic>;
      final rawMessages = data['messages'] as List? ?? [];
      final userId = currentUserId.value;
      messages.value = rawMessages.map((msg) {
        final map = msg as Map<String, dynamic>;
        final isMine = map['from_me'] ?? false;
        return {
          ...map,
          'is_mine': isMine,
        };
      }).toList();
    } else {
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    if (chatId.value == 0) {
      Get.snackbar('خطأ', 'لا توجد محادثة مفتوحة');
      return;
    }

    isSending.value = true;
    final result = await _chatService.sendMessage(
      chatId: chatId.value,
      content: content.trim(),
    );

    if (result != null && result['success'] == true) {
      await fetchMessages();
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل إرسال الرسالة');
    }
    isSending.value = false;
  }

  Future<void> sendImage(String imagePath) async {
    if (chatId.value == 0) {
      Get.snackbar('خطأ', 'لا توجد محادثة مفتوحة');
      return;
    }

    isSending.value = true;
    final result = await _chatService.sendImageMessage(
      chatId: chatId.value,
      imagePath: imagePath,
    );

    if (result != null && result['success'] == true) {
      await fetchMessages();
      Get.snackbar('نجاح', 'تم إرسال الصورة بنجاح');
    } else {
      Get.snackbar('خطأ', result?['message'] ?? 'فشل إرسال الصورة');
    }
    isSending.value = false;
  }

  Future<void> refreshMessages() async {
    await fetchMessages();
  }
}