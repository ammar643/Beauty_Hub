class ChatMessage {
  final int id;
  final int chatId;
  final int senderId;
  final String senderType;
  final String content;
  final String? mediaUrl;
  final DateTime createdAt;
  final bool isMine;

  ChatMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderType,
    required this.content,
    this.mediaUrl,
    required this.createdAt,
    required this.isMine,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json, int currentUserId) {
    return ChatMessage(
      id: json['id'] ?? 0,
      chatId: json['chat_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      senderType: json['sender_type'] ?? 'customer',
      content: json['content'] ?? '',
      mediaUrl: json['media_url'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
          : DateTime.now(),
      isMine: json['sender_id'] == currentUserId,
    );
  }
} 