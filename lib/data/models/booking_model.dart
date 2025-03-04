class BookingModel {
  final String id;
  final String userId;
  final String serviceName;
  final String date;
  final int guestCount;
  final String status;

  BookingModel({
    required this.id,
    required this.userId,
    required this.serviceName,
    required this.date,
    required this.guestCount,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'],
      userId: json['user'],
      serviceName: json['service']['name'],
      date: json['date'],
      guestCount: json['guestCount'],
      status: json['status'],
    );
  }
}
