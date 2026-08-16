class BeautyCenter {
  final int id;
  final String name;
  final String? profilePhoto;
  final String? coverPhoto;
  final String? description;
  final String? serviceTypes;
  final String? city;
  final String? governorate;
  final String? genderServed;
  final double ratingAvg;
  final int ratingCount;
  final int followersCount;
  final DateTime? createdAt;
final String? phone;
final String? email;
  final String? addressDetail;

  BeautyCenter({
    this.addressDetail,
    this.phone, this.email,
    required this.id,
    required this.name,
    this.profilePhoto,
    this.coverPhoto,
    this.description,
    this.serviceTypes,
    this.city,
    this.governorate,
    this.genderServed,
    this.ratingAvg = 0.0,
    this.ratingCount = 0,
    this.followersCount = 0,
    this.createdAt,
  });

  factory BeautyCenter.fromJson(Map<String, dynamic> json) {
    double ratingAvgValue = 0.0;
    final rawRating = json['rating_avg'];
    if (rawRating != null) {
      if (rawRating is double) ratingAvgValue = rawRating;
      else if (rawRating is String) ratingAvgValue = double.tryParse(rawRating) ?? 0.0;
      else if (rawRating is int) ratingAvgValue = rawRating.toDouble();
    }

    return BeautyCenter(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'مركز تجميل',
      profilePhoto: json['profile_photo'] ?? json['image'],
      coverPhoto: json['cover_photo'],
      description: json['description'],
      serviceTypes: json['service_types'],
      city: json['city'],
      governorate: json['governorate'],
      genderServed: json['gender_served'],
      ratingAvg: ratingAvgValue,
      ratingCount: json['rating_count'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }
}