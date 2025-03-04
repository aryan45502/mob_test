import 'package:wedding_event_planner/domain/entities/vendor.dart';

class VendorModel extends Vendor {
  VendorModel({
    required String id,
    required String name,
    required String category,
    required String image,
    required double price,
  }) : super(id: id, name: name, category: category, image: image, price: price);

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'];

    // ✅ Replace "http://localhost:5000/" with "http://10.0.2.2:5000/"
    if (imageUrl.contains("localhost")) {
      imageUrl = imageUrl.replaceAll("localhost", "10.0.2.2");
    }

    return VendorModel(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      image: imageUrl, // ✅ Use the updated URL
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'image': image,
      'price': price,
    };
  }
}
