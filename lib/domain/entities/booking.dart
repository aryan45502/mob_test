class Booking {
  final String id;
  final String serviceName;
  final String date;
  final int guestCount;
  final String status;

  Booking({
    required this.id,
    required this.serviceName,
    required this.date,
    required this.guestCount,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      serviceName: json['service']['name'],
      date: json['date'],
      guestCount: json['guestCount'],
      status: json['status'],
    );
  }
}
