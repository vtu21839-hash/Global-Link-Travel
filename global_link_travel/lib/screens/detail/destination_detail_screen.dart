import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../providers/booking_provider.dart';
import '../../utils/constants.dart';
import 'booking_form_screen.dart';
import 'cultural_info_screen.dart';

class DestinationDetailScreen extends StatefulWidget {
  final Map<String, dynamic> destination;

  const DestinationDetailScreen({super.key, required this.destination});

  @override
  State<DestinationDetailScreen> createState() => _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      destination['image'] as String,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 350,
                        color: AppColors.primary.withOpacity(0.1),
                        child: Icon(Icons.image, color: AppColors.primary, size: 60),
                      ),
                    ),
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            destination['name'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.white70, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                destination['country'] as String,
                                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: (destination['rating'] as num).toDouble(),
                                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                                itemCount: 5,
                                itemSize: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${destination['rating']}',
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Discover the beauty of ${destination['name']}, ${destination['description'] ?? 'a wonderful destination'}. '
                        'Experience breathtaking views, rich culture, and unforgettable memories. '
                        'Our travel packages include comfortable accommodation, guided tours, '
                        'and exclusive experiences tailored just for you.',
                        style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium, height: 1.6),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _buildInfoCard(Icons.access_time, 'Duration', '5 Days'),
                          const SizedBox(width: 12),
                          _buildInfoCard(Icons.people, 'Group', '2-10'),
                          const SizedBox(width: 12),
                          _buildInfoCard(Icons.wifi, 'WiFi', 'Free'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Local Guide',
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildCulturalButton(Icons.checkroom, 'Dress Code', AppColors.primary, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CulturalInfoScreen(
                                  destination: destination['name'] as String,
                                  country: destination['country'] as String,
                                ),
                              ),
                            );
                          }),
                          const SizedBox(width: 12),
                          _buildCulturalButton(Icons.hotel, 'Hotels', AppColors.teal, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CulturalInfoScreen(
                                  destination: destination['name'] as String,
                                  country: destination['country'] as String,
                                ),
                              ),
                            );
                          }),
                          const SizedBox(width: 12),
                          _buildCulturalButton(Icons.restaurant, 'Food', AppColors.accent, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CulturalInfoScreen(
                                  destination: destination['name'] as String,
                                  country: destination['country'] as String,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'What\'s Included',
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 12),
                      _buildIncludedItem('Round-trip flights'),
                      _buildIncludedItem('5-star hotel accommodation'),
                      _buildIncludedItem('Daily breakfast & dinner'),
                      _buildIncludedItem('Guided city tours'),
                      _buildIncludedItem('Airport transfers'),
                      _buildIncludedItem('Travel insurance'),
                      const SizedBox(height: 24),
                      Text(
                        'Reviews',
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 12),
                      _buildReview('John D.', 5, 'Amazing experience! The views were breathtaking.'),
                      _buildReview('Sarah M.', 4, 'Great trip, well organized. Highly recommend!'),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.arrow_back_ios_new, color: AppColors.textDark, size: 20),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 16,
            child: GestureDetector(
              onTap: () => setState(() => _isFavorite = !_isFavorite),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : AppColors.textDark,
                  size: 20,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Price',
                          style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium),
                        ),
                        Text(
                          '₹${destination['price']}',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookingFormScreen(destination: destination),
                              ),
                            );
                          },
                          child: const Text('Book Now'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
          ],
        ),
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.success, size: 20),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium)),
        ],
      ),
    );
  }

  Widget _buildReview(String name, int rating, String comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(name[0], style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.textDark)),
                    RatingBarIndicator(
                      rating: rating.toDouble(),
                      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium)),
        ],
      ),
    );
  }

  Widget _buildCulturalButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
