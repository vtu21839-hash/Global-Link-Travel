import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../utils/constants.dart';
import '../detail/create_trip_screen.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  List<Map<String, dynamic>> _getTripsByStatus(String status) {
    return DestinationData.userTrips.where((trip) => trip['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Trips',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        '${DestinationData.userTrips.length} trips planned',
                        style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium),
                      ),
                    ],
                  ).animate().fadeIn(duration: 400.ms),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CreateTripScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(Icons.add, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textMedium,
                labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
                unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 13),
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: 'Ongoing (${_getTripsByStatus('Ongoing').length})'),
                  Tab(text: 'Planned (${_getTripsByStatus('Planned').length})'),
                  Tab(text: 'Past (${_getTripsByStatus('Past').length})'),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTripsList('Ongoing'),
                  _buildTripsList('Planned'),
                  _buildTripsList('Past'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsList(String status) {
    final trips = _getTripsByStatus(status);

    if (trips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.map_outlined, size: 40, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'No $status trips',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 8),
            Text(
              status == 'Planned' ? 'Plan your next adventure!' : 'Your trips will appear here',
              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium),
            ),
            const SizedBox(height: 16),
            if (status == 'Planned')
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateTripScreen()),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Plan a Trip'),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        Color statusColor;
        switch (status) {
          case 'Ongoing':
            statusColor = AppColors.success;
            break;
          case 'Planned':
            statusColor = AppColors.warning;
            break;
          default:
            statusColor = AppColors.textLight;
        }

        return Container(
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
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                    child: Image.network(
                      trip['image'] as String,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 160,
                        color: AppColors.primary.withOpacity(0.1),
                        child: Icon(Icons.image, color: AppColors.primary, size: 40),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  if (status == 'Ongoing')
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: () => _showChecklistSheet(trip),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.checklist, color: AppColors.primary, size: 20),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.textLight, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          trip['location'] as String,
                          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: AppColors.textLight, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          trip['dates'] as String,
                          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _showTripDetailsSheet(trip, status),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('View Details', style: TextStyle(color: AppColors.primary)),
                          ),
                        ),
                        if (status == 'Planned') ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _showEditTripSheet(trip),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('Edit'),
                            ),
                          ),
                        ],
                        if (status == 'Ongoing') ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _showShareLocationSheet(trip),
                              icon: const Icon(Icons.share_location, size: 18),
                              label: const Text('Share'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.success,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                        if (status == 'Past') ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _showReviewSheet(trip),
                              icon: const Icon(Icons.rate_review, size: 18),
                              label: const Text('Review'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.warning,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
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

  void _showTripDetailsSheet(Map<String, dynamic> trip, String status) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
              Text(trip['title'] as String, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.location_on, 'Location', trip['location'] as String),
              _buildDetailRow(Icons.calendar_today, 'Dates', trip['dates'] as String),
              _buildDetailRow(Icons.info_outline, 'Status', status),
              const SizedBox(height: 16),
              Text('Trip Itinerary', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildItineraryItem('Day 1', 'Arrival & Check-in'),
              _buildItineraryItem('Day 2', 'Local Sightseeing'),
              _buildItineraryItem('Day 3', 'Adventure Activities'),
              _buildItineraryItem('Day 4', 'Leisure & Shopping'),
              _buildItineraryItem('Day 5', 'Departure'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
          Text('$label: ', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium)),
          Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildItineraryItem(String day, String activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(day, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          Text(activity, style: GoogleFonts.poppins(fontSize: 14)),
        ],
      ),
    );
  }

  void _showEditTripSheet(Map<String, dynamic> trip) {
    final titleController = TextEditingController(text: trip['title'] as String);
    final locationController = TextEditingController(text: trip['location'] as String);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Edit Trip', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Trip Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Text(trip['dates'] as String, style: GoogleFonts.poppins(fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text('Trip updated!'), backgroundColor: AppColors.success),
                  );
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChecklistSheet(Map<String, dynamic> trip) {
    final items = [
      {'text': 'Passport & IDs', 'checked': true},
      {'text': 'Travel Insurance', 'checked': true},
      {'text': 'Medications', 'checked': false},
      {'text': 'Chargers & Power Bank', 'checked': false},
      {'text': 'Clothes & Toiletries', 'checked': true},
      {'text': 'Camera & Accessories', 'checked': false},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              Text('Trip Checklist', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ...items.asMap().entries.map((entry) => CheckboxListTile(
                    title: Text(entry.value['text'] as String),
                    value: entry.value['checked'] as bool,
                    onChanged: (val) {
                      setModalState(() => items[entry.key]['checked'] = val!);
                    },
                    activeColor: AppColors.primary,
                  )),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _showShareLocationSheet(Map<String, dynamic> trip) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Icon(Icons.share_location, color: AppColors.success, size: 50),
            const SizedBox(height: 12),
            Text('Share Live Location', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Share your real-time location with friends and family', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: AppColors.textMedium)),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.people, color: AppColors.primary),
              title: const Text('Share with Travel Buddies'),
              trailing: Switch(value: true, onChanged: (_) {}, activeColor: AppColors.primary),
            ),
            ListTile(
              leading: Icon(Icons.family_restroom, color: AppColors.primary),
              title: const Text('Share with Family'),
              trailing: Switch(value: false, onChanged: (_) {}, activeColor: AppColors.primary),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text('Location sharing enabled!'), backgroundColor: AppColors.success),
                  );
                },
                child: const Text('Start Sharing'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReviewSheet(Map<String, dynamic> trip) {
    double rating = 4;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              Text('Rate Your Trip', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(trip['title'] as String, style: GoogleFonts.poppins(color: AppColors.textMedium)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) => GestureDetector(
                  onTap: () => setModalState(() => rating = i + 1.0),
                  child: Icon(
                    i < rating ? Icons.star : Icons.star_border,
                    color: AppColors.warning,
                    size: 40,
                  ),
                )),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Write your review',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Review submitted!'), backgroundColor: AppColors.success),
                    );
                  },
                  child: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
