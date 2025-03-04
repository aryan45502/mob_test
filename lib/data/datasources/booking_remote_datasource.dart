import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingRemoteDataSource {
  final String baseUrl;

  BookingRemoteDataSource({required this.baseUrl});

  Future<void> createBooking(String serviceId, String date, int guestCount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookings'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"service": serviceId, "date": date, "guestCount": guestCount}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create booking');
    }
  }

  Future<List<dynamic>> fetchBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/bookings'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch bookings');
    }
  }
}
