import 'package:wedding_event_planner/core/network/api_service.dart';
import 'package:wedding_event_planner/domain/entities/booking.dart';



class BookingRepository {
  final ApiService apiService;

  BookingRepository(this.apiService);

  Future<List<Booking>> getBookings() async {
    return await apiService.fetchBookings();
  }

  Future<void> bookService(String serviceId, String date, int guestCount) async {
    await apiService.bookService(serviceId, date, guestCount);
  }
}
