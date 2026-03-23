class Booking {
  final String id;
  final String destination;
  final String country;
  final String image;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guests;
  final double totalPrice;
  final String status;
  final String packageType;

  Booking({
    required this.id,
    required this.destination,
    required this.country,
    required this.image,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.totalPrice,
    required this.status,
    required this.packageType,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      destination: json['destination'],
      country: json['country'],
      image: json['image'],
      checkIn: DateTime.parse(json['checkIn']),
      checkOut: DateTime.parse(json['checkOut']),
      guests: json['guests'],
      totalPrice: json['totalPrice'].toDouble(),
      status: json['status'],
      packageType: json['packageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destination': destination,
      'country': country,
      'image': image,
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'guests': guests,
      'totalPrice': totalPrice,
      'status': status,
      'packageType': packageType,
    };
  }
}
