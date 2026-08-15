class Product {
  final int id;
  final String name;
  final double price;
  final String? image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'منتج',
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['image'] ?? json['main_image'] ?? json['profile_photo'],
    );
  }
}