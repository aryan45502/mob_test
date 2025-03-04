import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wedding_event_planner/data/models/vendor_model.dart';
import 'package:wedding_event_planner/domain/entities/booking.dart';
import 'package:wedding_event_planner/domain/entities/vendor.dart';


class ApiService {
  static const String baseUrl = "http://192.168.2.120:5000/api";

  final String token;

  ApiService({required this.token});

  // Fetch Vendors
  Future<List<Vendor>> fetchVendors() async {
    final response = await http.get(
      Uri.parse("$baseUrl/vendors"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Vendor.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load vendors");
    }
  }

  // Fetch User's Bookings
  Future<List<Booking>> fetchBookings() async {
    final response = await http.get(
      Uri.parse("$baseUrl/bookings/my"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load bookings");
    }
  }

  // Book a Service
  Future<void> bookService(String serviceId, String date, int guestCount) async {
    final response = await http.post(
      Uri.parse("$baseUrl/bookings"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode({
        "service": serviceId,
        "date": date,
        "guestCount": guestCount,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to book service");
    }
  }
}
