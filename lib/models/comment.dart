class Comment {
  final int id;
  final int postId;
  final int userId;
  final int? parentCommentId;
  final String comment;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? userFullName; 
  final String? userProfilePhoto;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    this.parentCommentId,
    required this.comment,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.userFullName,
    this.userProfilePhoto,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      parentCommentId: json['parent_comment_id'],
      comment: json['comment'] ?? '',
      isDeleted: json['is_deleted'] == 1,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      userFullName: json['user_full_name'],
      userProfilePhoto: json['user_profile_photo'],
    );
  }
}