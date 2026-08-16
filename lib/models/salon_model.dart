class Salon {
  final int id;
  final String name;
  final String? profilePhoto;
  final String? coverPhoto;
  final String? description;
  final String? city;
  final String? governorate;
  final String? genderServed;
  final double ratingAvg;
  final int ratingCount;
  final int followersCount;
  final DateTime? createdAt;
  final String? phone;
  final String? email;
  final String? address_detail;

  Salon({
    this.address_detail,
    this.phone,
    this.email,
    required this.id,
    required this.name,
    this.profilePhoto,
    this.coverPhoto,
    this.description,
    this.city,
    this.governorate,
    this.genderServed,
    this.ratingAvg = 0.0,
    this.ratingCount = 0,
    this.followersCount = 0,
    this.createdAt,
  });

  factory Salon.fromJson(Map<String, dynamic> json) {
    double ratingAvgValue = 0.0;
    final rawRating = json['rating_avg'];
    if (rawRating != null) {
      if (rawRating is double)
        ratingAvgValue = rawRating;
      else if (rawRating is String)
        ratingAvgValue = double.tryParse(rawRating) ?? 0.0;
      else if (rawRating is int)
        ratingAvgValue = rawRating.toDouble();
    }

    return Salon(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'صالون',
      profilePhoto: json['profile_photo'] ?? json['image'],
      coverPhoto: json['cover_photo'],
      description: json['description'],
      city: json['city'],
      governorate: json['governorate'],
      genderServed: json['gender_served'],
      ratingAvg: ratingAvgValue,
      ratingCount: json['rating_count'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      phone: json['phone'],
      email: json['email'],
      address_detail: json['address_detail'],
    );
  }
}
