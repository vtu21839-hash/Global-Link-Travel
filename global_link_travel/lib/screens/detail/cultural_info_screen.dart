import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants.dart';

class CulturalInfoScreen extends StatefulWidget {
  final String destination;
  final String country;

  const CulturalInfoScreen({
    super.key,
    required this.destination,
    required this.country,
  });

  @override
  State<CulturalInfoScreen> createState() => _CulturalInfoScreenState();
}

class _CulturalInfoScreenState extends State<CulturalInfoScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, Map<String, dynamic>> _culturalData = {
    'Goa': {
      'dress': [
        {'name': 'Casual Beachwear', 'desc': 'Light cotton clothes, shorts, flip-flops', 'icon': Icons.beach_access},
        {'name': 'Festival Dress', 'desc': 'Colorful shirts, flowy dresses for Carnival', 'icon': Icons.celebration},
        {'name': 'Temple Visit', 'desc': 'Cover shoulders & knees, remove shoes', 'icon': Icons.temple_buddhist},
      ],
      'dressImage': 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400',
      'hotels': [
        {'name': 'Taj Resort & Spa', 'rating': 4.9, 'price': 8500, 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400', 'amenities': ['Pool', 'Beach Access', 'Spa']},
        {'name': 'Alila Diwa Goa', 'rating': 4.8, 'price': 7200, 'image': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=400', 'amenities': ['Pool', 'Restaurant', 'Gym']},
        {'name': 'W Goa', 'rating': 4.7, 'price': 9500, 'image': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400', 'amenities': ['Beach', 'Bar', 'Spa']},
      ],
      'food': [
        {'name': 'Fish Curry Rice', 'desc': 'Traditional Goan staple with coconut curry', 'icon': Icons.restaurant, 'price': 250},
        {'name': 'Prawn Balchao', 'desc': 'Spicy prawn pickle-style dish', 'icon': Icons.set_meal, 'price': 350},
        {'name': 'Bebinca', 'desc': 'Layered Goan dessert pudding', 'icon': Icons.cake, 'price': 150},
        {'name': 'Feni Cocktail', 'desc': 'Local cashew spirit drink', 'icon': Icons.local_bar, 'price': 200},
      ],
    },
    'Jaipur': {
      'dress': [
        {'name': 'Traditional Lehenga', 'desc': 'Colorful skirts for women, perfect for photos', 'icon': Icons.checkroom},
        {'name': 'Kurta Pajama', 'desc': 'Comfortable cotton for men', 'icon': Icons.man},
        {'name': 'Pagdi/Turban', 'desc': 'Traditional headwear, available locally', 'icon': Icons.face},
      ],
      'dressImage': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=400',
      'hotels': [
        {'name': 'Rambagh Palace', 'rating': 4.9, 'price': 25000, 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400', 'amenities': ['Heritage', 'Pool', 'Spa']},
        {'name': 'Jai Mahal Palace', 'rating': 4.8, 'price': 18000, 'image': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=400', 'amenities': ['Garden', 'Restaurant', 'Bar']},
        {'name': 'Samode Haveli', 'rating': 4.7, 'price': 12000, 'image': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400', 'amenities': ['Pool', 'Heritage', 'Tours']},
      ],
      'food': [
        {'name': 'Dal Baati Churma', 'desc': 'Rajasthani signature dish', 'icon': Icons.restaurant, 'price': 200},
        {'name': 'Laal Maas', 'desc': 'Spicy mutton curry', 'icon': Icons.set_meal, 'price': 400},
        {'name': 'Ghewar', 'desc': 'Sweet disc-shaped dessert', 'icon': Icons.cake, 'price': 100},
        {'name': 'Masala Chai', 'desc': 'Spiced tea at local stalls', 'icon': Icons.coffee, 'price': 30},
      ],
    },
    'Kerala': {
      'dress': [
        {'name': 'Mundu & Kerala Saree', 'desc': 'Traditional white/gold attire', 'icon': Icons.checkroom},
        {'name': 'Light Cotton', 'desc': 'Breathable clothes for humidity', 'icon': Icons.air},
        {'name': 'Rain Gear', 'desc': 'Umbrella & waterproof bag for monsoon', 'icon': Icons.umbrella},
      ],
      'dressImage': 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=400',
      'hotels': [
        {'name': 'Kumarakom Lake Resort', 'rating': 4.9, 'price': 15000, 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400', 'amenities': ['Backwater View', 'Ayurveda', 'Pool']},
        {'name': 'Taj Green Cove', 'rating': 4.8, 'price': 12000, 'image': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=400', 'amenities': ['Beach', 'Spa', 'Restaurant']},
        {'name': 'Spice Village', 'rating': 4.7, 'price': 8000, 'image': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400', 'amenities': ['Nature', 'Organic Food', 'Tours']},
      ],
      'food': [
        {'name': 'Kerala Fish Curry', 'desc': 'Coconut-based curry with seer fish', 'icon': Icons.restaurant, 'price': 280},
        {'name': 'Appam & Stew', 'desc': 'Rice pancakes with coconut stew', 'icon': Icons.set_meal, 'price': 180},
        {'name': 'Banana Chips', 'desc': 'Crispy snack, buy fresh from shops', 'icon': Icons.cookie, 'price': 80},
        {'name': 'Toddy', 'desc': 'Local palm wine drink', 'icon': Icons.local_bar, 'price': 100},
      ],
    },
    'Manali': {
      'dress': [
        {'name': 'Winter Jacket', 'desc': 'Heavy woolen for snow season', 'icon': Icons.ac_unit},
        {'name': 'Trekking Gear', 'desc': 'Hiking boots, thermal wear', 'icon': Icons.hiking},
        {'name': 'Summer Cotton', 'desc': 'Light layers for summer months', 'icon': Icons.wb_sunny},
      ],
      'dressImage': 'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
      'hotels': [
        {'name': 'The Himalayan', 'rating': 4.8, 'price': 9000, 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400', 'amenities': ['Mountain View', 'Fireplace', 'Spa']},
        {'name': 'Span Resort', 'rating': 4.7, 'price': 7500, 'image': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=400', 'amenities': ['River View', 'Restaurant', 'Trekking']},
        {'name': 'Solang Valley Resort', 'rating': 4.6, 'price': 6000, 'image': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400', 'amenities': ['Adventure Sports', 'Bonfire', 'Restaurant']},
      ],
      'food': [
        {'name': 'Siddu', 'desc': 'Steamed bread with ghee', 'icon': Icons.restaurant, 'price': 120},
        {'name': 'Trout Fish', 'desc': 'Fresh river trout, local specialty', 'icon': Icons.set_meal, 'price': 450},
        {'name': 'Thukpa', 'desc': 'Tibetan noodle soup', 'icon': Icons.ramen_dining, 'price': 180},
        {'name': 'Hot Chocolate', 'desc': 'Warm up at local cafes', 'icon': Icons.coffee, 'price': 150},
      ],
    },
    'default': {
      'dress': [
        {'name': 'Casual Comfortable', 'desc': 'Light cotton clothes', 'icon': Icons.checkroom},
        {'name': 'Formal Option', 'desc': 'For temple or formal visits', 'icon': Icons.accessibility_new},
        {'name': 'Weather Appropriate', 'desc': 'Check forecast before packing', 'icon': Icons.cloud},
      ],
      'dressImage': 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400',
      'hotels': [
        {'name': 'Luxury Hotel', 'rating': 4.8, 'price': 8000, 'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400', 'amenities': ['Pool', 'Spa', 'Restaurant']},
        {'name': 'Boutique Stay', 'rating': 4.6, 'price': 5000, 'image': 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=400', 'amenities': ['Breakfast', 'WiFi', 'Tours']},
        {'name': 'Budget Hostel', 'rating': 4.3, 'price': 1500, 'image': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400', 'amenities': ['Dorm', 'Kitchen', 'Common Area']},
      ],
      'food': [
        {'name': 'Local Thali', 'desc': 'Traditional meal plate', 'icon': Icons.restaurant, 'price': 200},
        {'name': 'Street Food', 'desc': 'Try local street specialties', 'icon': Icons.fastfood, 'price': 80},
        {'name': 'Regional Dessert', 'desc': 'Local sweet specialties', 'icon': Icons.cake, 'price': 100},
        {'name': 'Local Drink', 'desc': 'Traditional beverages', 'icon': Icons.local_cafe, 'price': 50},
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _getData() {
    return _culturalData[widget.destination] ?? _culturalData['default']!;
  }

  @override
  Widget build(BuildContext context) {
    final data = _getData();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Local Guide', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(widget.destination, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textMedium,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(icon: Icon(Icons.checkroom, size: 20), text: 'Dress'),
                Tab(icon: Icon(Icons.hotel, size: 20), text: 'Hotels'),
                Tab(icon: Icon(Icons.restaurant, size: 20), text: 'Food'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDressTab(data),
                _buildHotelsTab(data),
                _buildFoodTab(data),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDressTab(Map<String, dynamic> data) {
    final dressList = data['dress'] as List;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              data['dressImage'] as String,
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
          Text('What to Wear in ${widget.destination}', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...dressList.map((dress) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(dress['icon'] as IconData, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dress['name'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                      Text(dress['desc'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildHotelsTab(Map<String, dynamic> data) {
    final hotels = data['hotels'] as List;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        final hotel = hotels[index];
        final amenities = hotel['amenities'] as List;
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  hotel['image'] as String,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 150,
                    color: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.hotel, color: AppColors.primary, size: 40),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(hotel['name'] as String, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(Icons.star, color: AppColors.warning, size: 18),
                            const SizedBox(width: 4),
                            Text('${hotel['rating']}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: amenities.map((a) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(a as String, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.primary)),
                      )).toList(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹${hotel['price']}/night', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Booking ${hotel['name']}...'), backgroundColor: AppColors.success),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Book Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFoodTab(Map<String, dynamic> data) {
    final foods = data['food'] as List;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(food['icon'] as IconData, color: AppColors.accent, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food['name'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                    Text(food['desc'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('₹${food['price']}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.success)),
              ),
            ],
          ),
        );
      },
    );
  }
}
