import 'dart:convert';

class Post {
  final int id;
  final String? caption;
  final List<String> mediaUrls;
  final int likesCount;
  final String? userName;
  final String? userType;
  final String? userAvatar;
  final String? providerType;
  final int? providerId;
  final DateTime? createdAt;

  Post({
    required this.id,
    this.caption,
    this.mediaUrls = const [],
    this.likesCount = 0,
    this.userName,
    this.userType,
    this.userAvatar,
    this.providerType,
    this.providerId,
    this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // ===== معالجة media_json (قد تكون String أو List) =====
    List<String> mediaList = [];
    dynamic mediaRaw = json['media_json'] ?? json['images'] ?? json['media'];

    if (mediaRaw is String) {
      try {
        final decoded = jsonDecode(mediaRaw);
        if (decoded is List) {
          mediaList = decoded.map((e) => e.toString()).toList();
        }
      } catch (e) {
        mediaList = [];
      }
    } else if (mediaRaw is List) {
      mediaList = mediaRaw.map((e) => e.toString()).toList();
    }

    return Post(
      id: json['id'] ?? 0,
      caption: json['caption'] ?? json['content'] ?? json['body'],
      mediaUrls: mediaList,
      likesCount: json['likes_count'] ?? 0,
      userName: json['user_name'] ??
          json['name'] ??
          json['provider_name'] ??
          'مقدم الخدمة',
      userType: json['user_type'] ?? json['type'] ?? json['provider_type'],
      userAvatar: json['user_avatar'] ?? json['profile_photo'],
      providerType: json['provider_type'],
      providerId: json['provider_id'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }
}