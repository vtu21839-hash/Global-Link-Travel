import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../providers/booking_provider.dart';
import '../../utils/constants.dart';
import '../home/main_screen.dart';

class BookingFormScreen extends StatefulWidget {
  final Map<String, dynamic> destination;

  const BookingFormScreen({super.key, required this.destination});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  DateTime _checkIn = DateTime.now().add(const Duration(days: 7));
  DateTime _checkOut = DateTime.now().add(const Duration(days: 12));
  int _guests = 2;
  String _selectedPackage = 'Standard';

  final List<Map<String, dynamic>> _packages = [
    {'name': 'Standard', 'priceMultiplier': 1.0, 'description': 'Basic package with hotel & breakfast'},
    {'name': 'Premium', 'priceMultiplier': 1.5, 'description': 'Premium hotel, all meals & tours'},
    {'name': 'Luxury', 'priceMultiplier': 2.0, 'description': '5-star hotel, private tours & spa'},
  ];

  double get _totalPrice {
    final basePrice = (widget.destination['price'] as num).toDouble();
    final packageMultiplier = _packages.firstWhere((p) => p['name'] == _selectedPackage)['priceMultiplier'] as double;
    final nights = _checkOut.difference(_checkIn).inDays;
    return basePrice * packageMultiplier * _guests * (nights / 5);
  }

  Future<void> _selectDate(bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? _checkIn : _checkOut,
      firstDate: isCheckIn ? DateTime.now() : _checkIn.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkIn = picked;
          if (_checkOut.isBefore(_checkIn.add(const Duration(days: 1)))) {
            _checkOut = _checkIn.add(const Duration(days: 5));
          }
        } else {
          _checkOut = picked;
        }
      });
    }
  }

  Future<void> _handleBooking() async {
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);

    await bookingProvider.createBooking(
      destination: widget.destination['name'] as String,
      country: widget.destination['country'] as String,
      image: widget.destination['image'] as String,
      checkIn: _checkIn,
      checkOut: _checkOut,
      guests: _guests,
      totalPrice: _totalPrice,
      packageType: _selectedPackage,
    );

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: AppColors.success, size: 40),
            ),
            const SizedBox(height: 20),
            Text(
              'Booking Confirmed!',
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 8),
            Text(
              'Your trip to ${widget.destination['name']} has been booked successfully.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: AppColors.textMedium),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                    (route) => false,
                  );
                },
                child: const Text('View Bookings'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Trip', style: GoogleFonts.poppins()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.destination['image'] as String,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 80,
                        height: 80,
                        color: AppColors.primary.withOpacity(0.1),
                        child: Icon(Icons.image, color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.destination['name'] as String,
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.textLight, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              widget.destination['country'] as String,
                              style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Select Dates', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(true),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Check-in', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textLight)),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('MMM dd, yyyy').format(_checkIn),
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(false),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Check-out', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textLight)),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('MMM dd, yyyy').format(_checkOut),
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Number of Guests', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _guests > 1 ? () => setState(() => _guests--) : null,
                    icon: Icon(Icons.remove_circle_outline, color: AppColors.primary),
                  ),
                  Text(
                    '$_guests Guest${_guests > 1 ? 's' : ''}',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  IconButton(
                    onPressed: _guests < 10 ? () => setState(() => _guests++) : null,
                    icon: Icon(Icons.add_circle_outline, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Package Type', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 12),
            ..._packages.map((package) {
              final isSelected = _selectedPackage == package['name'];
              return GestureDetector(
                onTap: () => setState(() => _selectedPackage = package['name'] as String),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.border,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package['name'] as String,
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark),
                            ),
                            Text(
                              package['description'] as String,
                              style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'x${package['priceMultiplier']}',
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildPriceRow('Base Price', '₹${widget.destination['price']}'),
                  _buildPriceRow('Guests', 'x$_guests'),
                  _buildPriceRow('Duration', '${_checkOut.difference(_checkIn).inDays} Days'),
                  _buildPriceRow('Package', _selectedPackage),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      Text(
                        '₹${_totalPrice.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _handleBooking,
                child: const Text('Confirm Booking'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(color: AppColors.textMedium)),
          Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.textDark)),
        ],
      ),
    );
  }
}
