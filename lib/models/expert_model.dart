class Expert {
  final int id;
  final String fullName;
  final String? profilePhoto;
  final String? coverPhoto;
  final String? bio;
  final String? specialization;
  final String? city;
  final String? governorate;
  final int experienceYears;
  final double ratingAvg;
  final int ratingCount;
  final int followersCount;
  final bool isAvailable;
  final DateTime? createdAt;
  final String? phone;
  final String? email;
  Expert({
    this.phone,
    this.email,
    required this.id,
    required this.fullName,
    this.profilePhoto,
    this.coverPhoto,
    this.bio,
    this.specialization,
    this.city,
    this.governorate,
    this.experienceYears = 0,
    this.ratingAvg = 0.0,
    this.ratingCount = 0,
    this.followersCount = 0,
    this.isAvailable = true,
    this.createdAt,
  });

  factory Expert.fromJson(Map<String, dynamic> json) {
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

    return Expert(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? json['name'] ?? 'خبير',
      profilePhoto: json['profile_photo'] ?? json['image'],
      coverPhoto: json['cover_photo'],
      bio: json['bio'],
      specialization: json['specialization'],
      city: json['city'],
      governorate: json['governorate'],
      experienceYears: json['experience_years'] ?? 0,
      ratingAvg: ratingAvgValue,
      ratingCount: json['rating_count'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      isAvailable: json['is_available_for_hire'] == 1,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }
}
