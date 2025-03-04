import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/booking_cubit.dart';

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Bookings")),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BookingLoaded) {
            return ListView.builder(
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final booking = state.bookings[index];
                return ListTile(
                  title: Text(booking.serviceName),
                  subtitle: Text("Date: ${booking.date}, Guests: ${booking.guestCount}"),
                );
              },
            );
          } else {
            return Center(child: Text("Failed to load bookings"));
          }
        },
      ),
    );
  }
}
