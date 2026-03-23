import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';

class GroupTripPlannerScreen extends StatefulWidget {
  const GroupTripPlannerScreen({super.key});

  @override
  State<GroupTripPlannerScreen> createState() => _GroupTripPlannerScreenState();
}

class _GroupTripPlannerScreenState extends State<GroupTripPlannerScreen> {
  final List<Map<String, dynamic>> _groups = [
    {
      'name': 'Goa Squad 2026',
      'destination': 'Goa',
      'dates': 'Apr 15-20, 2026',
      'members': [
        {'name': 'Rahul Sharma', 'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100', 'role': 'Admin', 'isOnline': true},
        {'name': 'Priya Patel', 'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100', 'role': 'Member', 'isOnline': true},
        {'name': 'Amit Kumar', 'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100', 'role': 'Member', 'isOnline': false},
        {'name': 'Sneha Reddy', 'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100', 'role': 'Member', 'isOnline': true},
      ],
      'polls': [
        {'question': 'Which beach should we visit first?', 'options': [
          {'text': 'Baga Beach', 'votes': 3},
          {'text': 'Calangute Beach', 'votes': 1},
          {'text': 'Anjuna Beach', 'votes': 2},
        ], 'totalVotes': 6, 'myVote': 0},
      ],
      'status': 'active',
      'budget': 25000,
    },
    {
      'name': 'Ladakh Riders',
      'destination': 'Ladakh',
      'dates': 'Jun 5-15, 2026',
      'members': [
        {'name': 'Rahul Sharma', 'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100', 'role': 'Admin', 'isOnline': true},
        {'name': 'Vikram Singh', 'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100', 'role': 'Member', 'isOnline': false},
      ],
      'polls': [],
      'status': 'planning',
      'budget': 55000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Trips', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () => _showCreateGroupSheet(), icon: const Icon(Icons.group_add)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._groups.asMap().entries.map((entry) {
              return _buildGroupCard(entry.value).animate().fadeIn(
                    delay: Duration(milliseconds: entry.key * 100),
                    duration: 400.ms,
                  );
            }),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateGroupSheet(),
        icon: const Icon(Icons.group_add),
        label: const Text('Create Group'),
      ),
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group) {
    final members = group['members'] as List;
    final isActive = group['status'] == 'active';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientEnd]),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(group['name'] as String, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.white70, size: 14),
                          const SizedBox(width: 4),
                          Text(group['destination'] as String, style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                          const SizedBox(width: 12),
                          const Icon(Icons.calendar_today, color: Colors.white70, size: 14),
                          const SizedBox(width: 4),
                          Text(group['dates'] as String, style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.success : AppColors.warning,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isActive ? 'Active' : 'Planning',
                    style: GoogleFonts.poppins(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Members (${members.length})', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                    Row(
                    children: [
                      ...members.take(3).map<Widget>((m) {
                        return Transform.translate(
                          offset: const Offset(-8, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(m['avatar'] as String),
                            ),
                          ),
                        );
                      }),
                      if (members.length > 3)
                        Transform.translate(
                          offset: const Offset(-8, 0),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            child: Text('+${members.length - 3}', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionChip(Icons.poll, 'Polls', () => _showPollSheet(group)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildActionChip(Icons.chat, 'Chat', () {}),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildActionChip(Icons.map, 'Itinerary', () {}),
                    ),
                  ],
                ),
                if ((group['polls'] as List).isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildActivePoll((group['polls'] as List).first),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 4),
            Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivePoll(Map<String, dynamic> poll) {
    final options = poll['options'] as List;
    final totalVotes = poll['totalVotes'] as int;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.poll, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text('Active Poll', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 8),
          Text(poll['question'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          ...options.asMap().entries.map((entry) {
            final opt = entry.value;
            final percent = totalVotes > 0 ? (opt['votes'] as int) / totalVotes : 0.0;
            final isMyVote = entry.key == (poll['myVote'] as int? ?? -1);
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isMyVote ? AppColors.primary.withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: isMyVote ? Border.all(color: AppColors.primary) : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(opt['text'] as String, style: GoogleFonts.poppins(fontSize: 13, fontWeight: isMyVote ? FontWeight.w600 : FontWeight.normal)),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: percent,
                            minHeight: 6,
                            backgroundColor: AppColors.border,
                            valueColor: AlwaysStoppedAnimation(AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('${(percent * 100).toInt()}%', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
            );
          }),
          Text('$totalVotes votes', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight)),
        ],
      ),
    );
  }

  void _showPollSheet(Map<String, dynamic> group) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            Text('Create Poll', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Question', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Option 1', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: 'Option 2', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Create Poll'))),
          ],
        ),
      ),
    );
  }

  void _showCreateGroupSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            Text('Create Trip Group', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Group Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Destination', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Dates', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Create Group'))),
          ],
        ),
      ),
    );
  }
}
