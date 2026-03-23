import 'package:flutter/material.dart';
import '../models/booking.dart';

class BookingProvider with ChangeNotifier {
  final List<Booking> _bookings = [];
  bool _isLoading = false;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;

  Future<void> createBooking({
    required String destination,
    required String country,
    required String image,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
    required double totalPrice,
    required String packageType,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      destination: destination,
      country: country,
      image: image,
      checkIn: checkIn,
      checkOut: checkOut,
      guests: guests,
      totalPrice: totalPrice,
      status: 'Confirmed',
      packageType: packageType,
    );

    _bookings.insert(0, booking);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> cancelBooking(String bookingId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      final oldBooking = _bookings[index];
      _bookings[index] = Booking(
        id: oldBooking.id,
        destination: oldBooking.destination,
        country: oldBooking.country,
        image: oldBooking.image,
        checkIn: oldBooking.checkIn,
        checkOut: oldBooking.checkOut,
        guests: oldBooking.guests,
        totalPrice: oldBooking.totalPrice,
        status: 'Cancelled',
        packageType: oldBooking.packageType,
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}
