import 'package:wedding_event_planner/core/network/api_service.dart';
import 'package:wedding_event_planner/data/datasources/booking_remote_datasource.dart';
import 'package:wedding_event_planner/domain/entities/booking.dart';
import 'package:wedding_event_planner/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;

  BookingRepositoryImpl({required this.bookingRemoteDataSource});

  @override
  Future<void> bookService(String serviceId, String date, int guestCount) async {
    await bookingRemoteDataSource.createBooking(serviceId, date, guestCount);
  }

  @override
  Future<List<Booking>> getBookings() async {
    final response = await bookingRemoteDataSource.fetchBookings();
    return response.map((json) => Booking.fromJson(json)).toList();
  }

  @override
  // TODO: implement apiService
  ApiService get apiService => throw UnimplementedError();
}
