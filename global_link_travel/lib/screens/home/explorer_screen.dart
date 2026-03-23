import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';
import '../detail/destination_detail_screen.dart';

class ExplorerScreen extends StatefulWidget {
  const ExplorerScreen({super.key});

  @override
  State<ExplorerScreen> createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  List<Map<String, dynamic>> _filteredDestinations = [];
  List<Map<String, dynamic>> _filteredPackages = [];

  @override
  void initState() {
    super.initState();
    _filteredDestinations = DestinationData.popularDestinations;
    _filteredPackages = DestinationData.travelPackages;
  }

  void _filterResults(String query) {
    setState(() {
      if (_selectedCategory == 'All') {
        _filteredDestinations = DestinationData.popularDestinations.where((dest) {
          final name = (dest['name'] as String).toLowerCase();
          final country = (dest['country'] as String).toLowerCase();
          return name.contains(query.toLowerCase()) || country.contains(query.toLowerCase());
        }).toList();
      } else {
        _filteredDestinations = DestinationData.popularDestinations.where((dest) {
          final category = (dest['category'] as String?) ?? '';
          final name = (dest['name'] as String).toLowerCase();
          final matchesCategory = category == _selectedCategory;
          final matchesQuery = query.isEmpty || name.contains(query.toLowerCase());
          return matchesCategory && matchesQuery;
        }).toList();
      }
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterResults(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explorer',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 6),
              Text(
                'Discover amazing places',
                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium),
              ).animate().fadeIn(delay: 50.ms, duration: 400.ms),
              const SizedBox(height: 20),
              _buildSearchBar().animate().fadeIn(delay: 100.ms, duration: 400.ms),
              const SizedBox(height: 20),
              _buildCategories().animate().fadeIn(delay: 150.ms, duration: 400.ms),
              const SizedBox(height: 24),
              _buildSectionTitle('Trending Trips'),
              const SizedBox(height: 12),
              _buildTrendingTrips().animate().fadeIn(delay: 200.ms, duration: 400.ms),
              const SizedBox(height: 24),
              _buildSectionTitle('Destinations (${_filteredDestinations.length})'),
              const SizedBox(height: 12),
              _buildDestinationsList().animate().fadeIn(delay: 250.ms, duration: 400.ms),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.textLight),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _filterResults,
              decoration: InputDecoration(
                hintText: 'Search destinations...',
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(color: AppColors.textLight),
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _filterResults('');
              },
              child: Icon(Icons.close, color: AppColors.textLight, size: 20),
            ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final allCategories = [
      {'name': 'All', 'icon': Icons.apps, 'color': AppColors.primary},
      ...DestinationData.categories,
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        itemBuilder: (context, index) {
          final cat = allCategories[index];
          final isSelected = _selectedCategory == cat['name'];
          final color = cat['color'] as Color;
          return GestureDetector(
            onTap: () => _selectCategory(cat['name'] as String),
            child: Container(
              width: 75,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isSelected ? color : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: (isSelected ? color : Colors.black).withOpacity(isSelected ? 0.3 : 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      color: isSelected ? Colors.white : color,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['name'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppColors.textDark : AppColors.textMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildTrendingTrips() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: DestinationData.trendingTrips.length,
        itemBuilder: (context, index) {
          final trip = DestinationData.trendingTrips[index];
          return GestureDetector(
            onTap: () => _showTripDetailSheet(trip),
            child: Container(
              width: 280,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      trip['image'] as String,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: Icon(Icons.image, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.trending_up, color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Trending',
                            style: GoogleFonts.poppins(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        trip['duration'] as String,
                        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip['title'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(trip['avatar'] as String),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              trip['author'] as String,
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                            ),
                            const Spacer(),
                            Icon(Icons.favorite, color: AppColors.accent, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${trip['likes']}',
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                            ),
                            const SizedBox(width: 10),
                            Icon(Icons.comment, color: Colors.white70, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${trip['comments']}',
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showTripDetailSheet(Map<String, dynamic> trip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  trip['image'] as String,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.image, color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(trip['avatar'] as String),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(trip['title'] as String, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('by ${trip['author']}', style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(trip['duration'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatChip(Icons.favorite, '${trip['likes']} Likes', AppColors.accent),
                  const SizedBox(width: 10),
                  _buildStatChip(Icons.comment, '${trip['comments']} Comments', AppColors.primary),
                ],
              ),
              const SizedBox(height: 16),
              Text('Trip Highlights', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildHighlightItem(Icons.location_on, 'Scenic Locations'),
              _buildHighlightItem(Icons.camera_alt, 'Photo Opportunities'),
              _buildHighlightItem(Icons.restaurant, 'Local Cuisine'),
              _buildHighlightItem(Icons.hotel, 'Comfortable Stay'),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text('Added to favorites!'), backgroundColor: AppColors.success),
                        );
                      },
                      icon: Icon(Icons.favorite_border, color: AppColors.accent),
                      label: Text('Save', style: TextStyle(color: AppColors.accent)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.accent),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text('Trip shared!'), backgroundColor: AppColors.success),
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(text, style: GoogleFonts.poppins(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium)),
        ],
      ),
    );
  }

  Widget _buildDestinationsList() {
    if (_filteredDestinations.isEmpty) {
      return Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: AppColors.textLight),
              const SizedBox(height: 12),
              Text(
                'No destinations found',
                style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textMedium),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredDestinations.length,
      itemBuilder: (context, index) {
        final dest = _filteredDestinations[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DestinationDetailScreen(destination: dest)),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(18)),
                  child: Image.network(
                    dest['image'] as String,
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 110,
                      height: 110,
                      color: AppColors.primary.withOpacity(0.1),
                      child: Icon(Icons.image, color: AppColors.primary),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                dest['name'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.warning.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, color: AppColors.warning, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${dest['rating']}',
                                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.textLight, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '${dest['country']}',
                              style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
                            ),
                            if (dest['category'] != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  dest['category'] as String,
                                  style: GoogleFonts.poppins(fontSize: 10, color: AppColors.primary),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹${dest['price']}',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Icon(Icons.arrow_forward_ios, color: AppColors.textLight, size: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
