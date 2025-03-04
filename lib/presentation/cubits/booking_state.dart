import 'package:wedding_event_planner/data/models/booking_model.dart';



abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingModel> bookings;
  BookingLoaded(this.bookings);
}

class BookingFailure extends BookingState {
  final String message;
  BookingFailure(this.message);
}
