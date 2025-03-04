import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wedding_event_planner/data/models/vendor_model.dart';
import 'package:wedding_event_planner/domain/entities/vendor.dart';


class VendorRemoteDataSource {
  final String baseUrl;

  VendorRemoteDataSource({required this.baseUrl});

  Future<List<Vendor>> fetchVendors() async {
    final response = await http.get(Uri.parse('$baseUrl/api/vendors'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Vendor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch vendors');
    }
  }
}
