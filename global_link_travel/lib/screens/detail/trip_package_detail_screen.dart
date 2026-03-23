import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';

class TripPackageDetailScreen extends StatefulWidget {
  final Map<String, dynamic> package;

  const TripPackageDetailScreen({super.key, required this.package});

  @override
  State<TripPackageDetailScreen> createState() => _TripPackageDetailScreenState();
}

class _TripPackageDetailScreenState extends State<TripPackageDetailScreen> {
  bool _isFavorite = false;
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final pkg = widget.package;
    final itinerary = pkg['itinerary'] as List;
    final highlights = pkg['highlights'] as List;
    final inclusions = pkg['inclusions'] as List;
    final exclusions = pkg['exclusions'] as List;

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
                      pkg['image'] as String,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 300,
                        color: AppColors.primary.withOpacity(0.1),
                        child: Icon(Icons.image, color: AppColors.primary, size: 60),
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              pkg['subtitle'] as String,
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            pkg['title'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildInfoChip(Icons.access_time, pkg['duration'] as String),
                              const SizedBox(width: 12),
                              _buildInfoChip(Icons.star, '${pkg['rating']} (${pkg['reviews']} reviews)'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildQuickInfo().animate().fadeIn(delay: 100.ms, duration: 400.ms),
                      const SizedBox(height: 20),
                      _buildHighlights(highlights).animate().fadeIn(delay: 150.ms, duration: 400.ms),
                      const SizedBox(height: 20),
                      _buildTabBar().animate().fadeIn(delay: 200.ms, duration: 400.ms),
                      const SizedBox(height: 16),
                      _selectedTab == 0
                          ? _buildItinerary(itinerary)
                          : _selectedTab == 1
                              ? _buildInclusionsExclusions(inclusions, exclusions)
                              : _buildReviews(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
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
                          'Starting from',
                          style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
                        ),
                        Text(
                          '₹${pkg['price']}',
                          style: GoogleFonts.poppins(
                            fontSize: 26,
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
                          onPressed: () {},
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

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(text, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildQuickInfo() {
    final pkg = widget.package;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildQuickInfoItem(Icons.calendar_today, pkg['duration'] as String, 'Duration'),
          Container(height: 40, width: 1, color: AppColors.border),
          _buildQuickInfoItem(Icons.people, pkg['groupSize'] as String, 'Group Size'),
          Container(height: 40, width: 1, color: AppColors.border),
          _buildQuickInfoItem(Icons.fitness_center, pkg['difficulty'] as String, 'Difficulty'),
        ],
      ),
    );
  }

  Widget _buildQuickInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 6),
        Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMedium)),
      ],
    );
  }

  Widget _buildHighlights(List highlights) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Highlights', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: highlights.map((h) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: AppColors.primary, size: 16),
                  const SizedBox(width: 8),
                  Text(h as String, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.primary)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _buildTabButton('Itinerary', 0),
          _buildTabButton('Inclusions', 1),
          _buildTabButton('Reviews', 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.white : AppColors.textMedium,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItinerary(List itinerary) {
    return Column(
      children: itinerary.map((day) {
        final meals = day['meals'] as List;
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.all(16),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              leading: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'D${day['day']}',
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              title: Text(
                day['title'] as String,
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark),
              ),
              children: [
                Text(
                  day['description'] as String,
                  style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium, height: 1.5),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: meals.map((meal) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.restaurant, color: AppColors.success, size: 14),
                          const SizedBox(width: 4),
                          Text(meal as String, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.success)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInclusionsExclusions(List inclusions, List exclusions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inclusions', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.success)),
        const SizedBox(height: 10),
        ...inclusions.map((item) => _buildCheckItem(item as String, true)),
        const SizedBox(height: 20),
        Text('Exclusions', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.error)),
        const SizedBox(height: 10),
        ...exclusions.map((item) => _buildCheckItem(item as String, false)),
      ],
    );
  }

  Widget _buildCheckItem(String text, bool isIncluded) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            isIncluded ? Icons.check_circle : Icons.cancel,
            color: isIncluded ? AppColors.success : AppColors.error,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium)),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Column(
      children: [
        _buildReviewCard('Amit Kumar', 5, 'Absolutely loved this trip! The itinerary was perfect and the arrangements were flawless.'),
        _buildReviewCard('Sneha Reddy', 4, 'Great experience. The local guide was very knowledgeable. Would recommend!'),
        _buildReviewCard('Rohan Mehta', 5, 'Best travel experience ever! Everything was well organized.'),
      ],
    );
  }

  Widget _buildReviewCard(String name, int rating, String comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(name[0], style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.textDark)),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < rating ? Icons.star : Icons.star_border,
                          color: AppColors.warning,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(comment, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium, height: 1.5)),
        ],
      ),
    );
  }
}
