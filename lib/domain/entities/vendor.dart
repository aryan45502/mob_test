class Vendor {
  final String id;
  final String name;
  final String category;
  final double price;
  final String image;

  Vendor({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
    );
  }
}
