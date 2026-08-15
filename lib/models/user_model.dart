class User {
  final int id;
  final String fullName;
  final String email;
  final String? profilePhoto;
  final String? phone;
  final String? city;
  final String? governorate;
  final int loyaltyPoints;
  final bool notificationsEnabled;
  final String language;
  final DateTime? lastLoginAt;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.profilePhoto,
    this.phone,
    this.city,
    this.governorate,
    this.loyaltyPoints = 0,
    this.notificationsEnabled = true,
    this.language = 'ar',
    this.lastLoginAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? json['name'] ?? 'مستخدم',
      email: json['email'] ?? '',
      profilePhoto: json['profile_photo'] ?? json['avatar'],
      phone: json['phone'],
      city: json['city'],
      governorate: json['governorate'],
      loyaltyPoints: json['loyalty_points'] ?? 0,
      notificationsEnabled: json['notifications_enabled'] ?? true,
      language: json['language'] ?? 'ar',
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.tryParse(json['last_login_at'])
          : null,
          
    );
  }
}