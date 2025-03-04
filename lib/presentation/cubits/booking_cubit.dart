import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_event_planner/domain/entities/booking.dart';
import 'package:wedding_event_planner/domain/repositories/booking_repository.dart';


abstract class BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<Booking> bookings;
  BookingLoaded(this.bookings);
}

class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
}

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository bookingRepository;

  BookingCubit({required this.bookingRepository}) : super(BookingLoading());

  void fetchBookings() async {
    try {
      emit(BookingLoading());
      final bookings = await bookingRepository.getBookings();
      emit(BookingLoaded(bookings));
    } catch (e) {
      emit(BookingError("Failed to fetch bookings"));
    }
  }

  void bookService(String serviceId, String date, int guestCount) async {
    try {
      await bookingRepository.bookService(serviceId, date, guestCount);
      fetchBookings();
    } catch (e) {
      emit(BookingError("Booking failed"));
    }
  }
}
