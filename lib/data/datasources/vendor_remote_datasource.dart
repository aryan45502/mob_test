import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wedding_event_planner/data/models/vendor_model.dart';

class VendorRemoteDataSource {
  final String baseUrl;

  VendorRemoteDataSource({required this.baseUrl});

  Future<List<VendorModel>> fetchVendors() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/vendors'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((vendor) => VendorModel.fromJson(vendor)).toList();
      } else {
        throw Exception('Failed to fetch vendors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching vendors: $e');
    }
  }
}
