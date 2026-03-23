import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';

class TravelJournalScreen extends StatefulWidget {
  const TravelJournalScreen({super.key});

  @override
  State<TravelJournalScreen> createState() => _TravelJournalScreenState();
}

class _TravelJournalScreenState extends State<TravelJournalScreen> {
  final List<Map<String, dynamic>> _journalEntries = [
    {
      'title': 'Sunrise at Tiger Hill',
      'trip': 'Darjeeling',
      'date': 'Mar 21, 2026',
      'mood': '🤩',
      'content': 'Woke up at 4 AM but it was totally worth it! The sunrise over Kanchenjunga was magical. The colors changed from pink to orange to golden. Best sunrise I\'ve ever seen!',
      'images': ['https://images.unsplash.com/photo-1544735716-392fe2489ffa?w=400'],
      'isFavorite': true,
    },
    {
      'title': 'Tea Garden Walk',
      'trip': 'Darjeeling',
      'date': 'Mar 21, 2026',
      'mood': '😌',
      'content': 'Visited Happy Valley Tea Estate. Learned about tea processing and tasted fresh Darjeeling tea. The rolling hills covered in tea bushes looked like a green carpet.',
      'images': ['https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400'],
      'isFavorite': false,
    },
    {
      'title': 'Toy Train Adventure',
      'trip': 'Darjeeling',
      'date': 'Mar 22, 2026',
      'mood': '😄',
      'content': 'Rode the UNESCO World Heritage Darjeeling Himalayan Railway! The narrow gauge train chugged through the hills with amazing views. At Batasia Loop, we could see the entire valley.',
      'images': [],
      'isFavorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Journal', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () => _showAddEntrySheet(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJournalStats().animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 20),
            _buildTimeline().animate().fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEntrySheet(),
        icon: const Icon(Icons.edit),
        label: const Text('New Entry'),
      ),
    );
  }

  Widget _buildJournalStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientEnd]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('${_journalEntries.length}', 'Entries', Icons.book),
          Container(height: 40, width: 1, color: Colors.white30),
          _buildStatItem('${_journalEntries.where((e) => e['isFavorite'] == true).length}', 'Favorites', Icons.favorite),
          Container(height: 40, width: 1, color: Colors.white30),
          _buildStatItem('1', 'Trip', Icons.flight),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: Colors.white70)),
      ],
    );
  }

  Widget _buildTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Memories', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ..._journalEntries.asMap().entries.map((entry) {
          return _buildJournalCard(entry.value, entry.key == _journalEntries.length - 1);
        }),
      ],
    );
  }

  Widget _buildJournalCard(Map<String, dynamic> entry, bool isLast) {
    final images = entry['images'] as List;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(entry['mood'] as String, style: const TextStyle(fontSize: 20)),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 100,
                  color: AppColors.border,
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry['title'] as String, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: AppColors.textLight, size: 14),
                                const SizedBox(width: 4),
                                Text(entry['trip'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                                const SizedBox(width: 12),
                                Icon(Icons.calendar_today, color: AppColors.textLight, size: 12),
                                const SizedBox(width: 4),
                                Text(entry['date'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => entry['isFavorite'] = !entry['isFavorite']);
                        },
                        child: Icon(
                          entry['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                          color: entry['isFavorite'] ? AppColors.accent : AppColors.textLight,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    entry['content'] as String,
                    style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium, height: 1.5),
                  ),
                  if (images.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        images.first as String,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 150,
                          color: AppColors.primary.withOpacity(0.1),
                          child: Icon(Icons.image, color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEntrySheet() {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('New Journal Entry', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(labelText: 'What happened today?', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            Text('How are you feeling?', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['🤩', '😄', '😌', '😊', '😢'].map((mood) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(mood, style: const TextStyle(fontSize: 24)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Save Entry')),
            ),
          ],
        ),
      ),
    );
  }
}
