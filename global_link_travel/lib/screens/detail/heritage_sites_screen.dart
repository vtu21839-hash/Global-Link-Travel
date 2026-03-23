import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';

class HeritageSitesScreen extends StatefulWidget {
  const HeritageSitesScreen({super.key});

  @override
  State<HeritageSitesScreen> createState() => _HeritageSitesScreenState();
}

class _HeritageSitesScreenState extends State<HeritageSitesScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _heritageSites = [
    // Temples
    {
      'name': 'Golden Temple',
      'location': 'Amritsar, Punjab',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1514222134-b57cbb8ce073?w=600',
      'description': 'The holiest Sikh shrine, known as Harmandir Sahib. Famous for its stunning golden dome and the world\'s largest community kitchen serving 100,000+ people daily.',
      'timing': '4:00 AM - 10:00 PM',
      'entryFee': 0,
      'rating': 4.9,
      'bestTime': 'Nov - Mar',
      'tips': ['Cover your head before entering', 'Remove shoes at entrance', 'Free langar (meal) available 24/7'],
    },
    {
      'name': 'Tirupati Balaji',
      'location': 'Tirupati, Andhra Pradesh',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=600',
      'description': 'One of the richest and most visited temples in the world, dedicated to Lord Venkateswara. Receives 50,000-100,000 pilgrims daily.',
      'timing': '3:00 AM - 12:00 AM',
      'entryFee': 300,
      'rating': 4.8,
      'bestTime': 'Sep - Feb',
      'tips': ['Book darshan tickets online in advance', 'Special entry available for ₹300', 'Hair offering is a common practice'],
    },
    {
      'name': 'Meenakshi Temple',
      'location': 'Madurai, Tamil Nadu',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1584464491033-06628f3a6b7b?w=600',
      'description': 'Ancient Hindu temple with stunning Dravidian architecture featuring 14 colorful gopurams (towers) with 33,000 sculptures.',
      'timing': '5:00 AM - 12:30 PM, 4:00 PM - 10:00 PM',
      'entryFee': 50,
      'rating': 4.7,
      'bestTime': 'Oct - Mar',
      'tips': ['Visit during evening aarti for best experience', 'Photography allowed in outer areas', 'Lotus tank is a must-see'],
    },
    {
      'name': 'Khajuraho Temples',
      'location': 'Khajuraho, Madhya Pradesh',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1590766940554-634d89247b81?w=600',
      'description': 'UNESCO World Heritage Site with 25 surviving temples known for stunning nagara-style architecture and intricate sculptures.',
      'timing': '6:00 AM - 6:00 PM',
      'entryFee': 40,
      'rating': 4.6,
      'bestTime': 'Oct - Feb',
      'tips': ['Light & Sound show at 7:30 PM', 'Hire a guide for detailed history', 'Western group has most famous temples'],
    },
    {
      'name': 'Konark Sun Temple',
      'location': 'Konark, Odisha',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1621427528262-83ca8ce01e70?w=600',
      'description': '13th-century temple designed as a massive chariot with 24 carved wheels pulled by 7 horses. UNESCO World Heritage Site.',
      'timing': '6:00 AM - 8:00 PM',
      'entryFee': 40,
      'rating': 4.7,
      'bestTime': 'Oct - Mar',
      'tips': ['Sunrise is the best time for photos', 'Attend the annual dance festival in Dec', 'Wheels work as sundials'],
    },
    // Kingdoms/Forts
    {
      'name': 'Taj Mahal',
      'location': 'Agra, Uttar Pradesh',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=600',
      'description': 'One of the Seven Wonders of the World, built by Mughal Emperor Shah Jahan in memory of his wife Mumtaz Mahal. A symbol of eternal love.',
      'timing': '6:00 AM - 6:30 PM (Closed on Fridays)',
      'entryFee': 1100,
      'rating': 4.9,
      'bestTime': 'Oct - Mar',
      'tips': ['Visit at sunrise for best photos', 'Night viewing available on full moon', 'Buy tickets online to skip queues'],
    },
    {
      'name': 'Mysore Palace',
      'location': 'Mysore, Karnataka',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1600100397608-e1f1f5a0c8a3?w=600',
      'description': 'Historical palace and the royal residence of the Wadiyar dynasty. Features Indo-Saracenic architecture with stunning interiors.',
      'timing': '10:00 AM - 5:30 PM',
      'entryFee': 70,
      'rating': 4.8,
      'bestTime': 'Sep - Feb',
      'tips': ['Visit during Dasara festival (Oct) for illumination', 'Evening light show at 7 PM', 'Camera fee extra ₹50'],
    },
    {
      'name': 'Hawa Mahal',
      'location': 'Jaipur, Rajasthan',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=600',
      'description': 'Palace of Winds with 953 small windows (jharokhas) built for royal women to observe street life without being seen.',
      'timing': '9:00 AM - 5:00 PM',
      'entryFee': 50,
      'rating': 4.7,
      'bestTime': 'Oct - Mar',
      'tips': ['Best viewed from outside in morning light', 'Climb to top for city views', 'Combine with City Palace visit'],
    },
    {
      'name': 'Qutub Minar',
      'location': 'New Delhi',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=600',
      'description': 'Tallest brick minaret in the world at 72.5 meters. UNESCO World Heritage Site built in 1193 by Qutb-ud-din Aibak.',
      'timing': '7:00 AM - 5:00 PM',
      'entryFee': 600,
      'rating': 4.5,
      'bestTime': 'Oct - Mar',
      'tips': ['Visit early morning to avoid crowds', 'Iron Pillar has not rusted in 1600 years', 'Sound & Light show in evening'],
    },
    {
      'name': 'Amber Fort',
      'location': 'Jaipur, Rajasthan',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=600',
      'description': 'Majestic hilltop fort showcasing Rajput architecture with stunning Sheesh Mahal (Mirror Palace) and Diwan-e-Khas.',
      'timing': '8:00 AM - 5:30 PM',
      'entryFee': 200,
      'rating': 4.8,
      'bestTime': 'Oct - Mar',
      'tips': ['Take elephant ride or jeep to top', 'Evening light show at 7 PM', 'Don\'t miss Sheesh Mahal'],
    },
    {
      'name': 'Red Fort',
      'location': 'New Delhi',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1585135497273-1a86b09fe70e?w=600',
      'description': 'Historic fort that served as the main residence of Mughal Emperors. Site of Indian Independence Day celebrations.',
      'timing': '9:30 AM - 4:30 PM (Closed on Mondays)',
      'entryFee': 600,
      'rating': 4.6,
      'bestTime': 'Oct - Mar',
      'tips': ['Attend Independence Day flag hoisting (Aug 15)', 'Sound & Light show at 6 PM', 'Visit nearby Chandni Chowk'],
    },
  ];

  List<Map<String, dynamic>> _getFilteredSites() {
    if (_selectedFilter == 'All') return _heritageSites;
    return _heritageSites.where((site) => site['type'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSites = _getFilteredSites();
    final templeCount = _heritageSites.where((s) => s['type'] == 'Temple').length;
    final kingdomCount = _heritageSites.where((s) => s['type'] == 'Kingdom').length;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Heritage Sites', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('${_heritageSites.length} places to explore', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildFilterChip('All', '${_heritageSites.length}', AppColors.primary),
                const SizedBox(width: 10),
                _buildFilterChip('Temples', '$templeCount', AppColors.warning),
                const SizedBox(width: 10),
                _buildFilterChip('Kingdoms', '$kingdomCount', AppColors.primary),
              ],
            ),
          ),
          // Sites List
          Expanded(
            child: filteredSites.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.temple_buddhist, size: 60, color: AppColors.textLight),
                        const SizedBox(height: 16),
                        Text('No sites found', style: GoogleFonts.poppins(fontSize: 18, color: AppColors.textMedium)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredSites.length,
                    itemBuilder: (context, index) {
                      return _buildSiteCard(filteredSites[index]).animate().fadeIn(
                            delay: Duration(milliseconds: index * 80),
                            duration: 400.ms,
                          );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String count, Color color) {
    final isSelected = _selectedFilter == label || (label == 'Temples' && _selectedFilter == 'Temple') || (label == 'Kingdoms' && _selectedFilter == 'Kingdom');
    final filterValue = label == 'All' ? 'All' : (label == 'Temples' ? 'Temple' : 'Kingdom');
    final active = _selectedFilter == filterValue;

    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = filterValue),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? color : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: active ? color : AppColors.border),
          boxShadow: active ? [BoxShadow(color: color.withOpacity(0.3), blurRadius: 8)] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label == 'Temples') Icon(Icons.temple_buddhist, size: 16, color: active ? Colors.white : color),
            if (label == 'Kingdoms') Icon(Icons.castle, size: 16, color: active ? Colors.white : color),
            if (label != 'All') const SizedBox(width: 6),
            Text(
              '$label ($count)',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                color: active ? Colors.white : AppColors.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSiteCard(Map<String, dynamic> site) {
    final isTemple = site['type'] == 'Temple';
    final typeColor = isTemple ? AppColors.warning : AppColors.primary;
    final typeIcon = isTemple ? Icons.temple_buddhist : Icons.castle;

    return GestureDetector(
      onTap: () => _showSiteDetail(site),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: Column(
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                  child: Image.network(
                    site['image'] as String,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180,
                      color: typeColor.withOpacity(0.1),
                      child: Icon(typeIcon, color: typeColor, size: 50),
                    ),
                  ),
                ),
                // Type Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: typeColor, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(typeIcon, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(site['type'] as String, style: GoogleFonts.poppins(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                // Rating Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: AppColors.warning, size: 14),
                        const SizedBox(width: 4),
                        Text('${site['rating']}', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(site['name'] as String, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.textLight, size: 14),
                      const SizedBox(width: 4),
                      Text(site['location'] as String, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: AppColors.textLight, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          site['timing'] as String,
                          style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: (site['entryFee'] as int) == 0 ? AppColors.success.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          (site['entryFee'] as int) == 0 ? 'FREE ENTRY' : '₹${site['entryFee']}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: (site['entryFee'] as int) == 0 ? AppColors.success : AppColors.primary,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_month, color: AppColors.teal, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Best: ${site['bestTime']}',
                            style: GoogleFonts.poppins(fontSize: 12, color: AppColors.teal, fontWeight: FontWeight.w500),
                          ),
                        ],
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
  }

  void _showSiteDetail(Map<String, dynamic> site) {
    final isTemple = site['type'] == 'Temple';
    final typeColor = isTemple ? AppColors.warning : AppColors.primary;
    final typeIcon = isTemple ? Icons.temple_buddhist : Icons.castle;
    final tips = site['tips'] as List;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
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
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  site['image'] as String,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: typeColor.withOpacity(0.1),
                    child: Icon(typeIcon, color: typeColor, size: 60),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Name and Type
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(site['name'] as String, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.textMedium, size: 16),
                            const SizedBox(width: 4),
                            Text(site['location'] as String, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: typeColor, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Icon(typeIcon, color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Text(site['type'] as String, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Description
              Text('About', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(site['description'] as String, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium, height: 1.6)),
              const SizedBox(height: 16),
              // Quick Info
              _buildInfoRow(Icons.access_time, 'Opening Hours', site['timing'] as String),
              _buildInfoRow(Icons.currency_rupee, 'Entry Fee', (site['entryFee'] as int) == 0 ? 'FREE' : '₹${site['entryFee']}'),
              _buildInfoRow(Icons.calendar_month, 'Best Time', site['bestTime'] as String),
              _buildInfoRow(Icons.star, 'Rating', '${site['rating']} / 5.0'),
              const SizedBox(height: 16),
              // Tips
              Text('Visitor Tips', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...tips.map((tip) => _buildTipItem(tip as String)),
              const SizedBox(height: 20),
              // Action Buttons
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
                          SnackBar(content: const Text('Opening directions...'), backgroundColor: AppColors.primary),
                        );
                      },
                      icon: const Icon(Icons.directions),
                      label: const Text('Navigate'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight)),
              Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.success, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(tip, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium))),
        ],
      ),
    );
  }
}
