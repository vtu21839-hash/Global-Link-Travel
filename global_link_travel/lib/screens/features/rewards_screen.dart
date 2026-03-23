import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _totalPoints = 2450;
  int _level = 12;

  final List<Map<String, dynamic>> _badges = [
    {'title': 'First Trip', 'icon': Icons.flag, 'color': Color(0xFF6C5CE7), 'earned': true, 'date': 'Jan 2025', 'points': 100},
    {'title': 'Beach Lover', 'icon': Icons.beach_access, 'color': Color(0xFF00CEC9), 'earned': true, 'date': 'Feb 2025', 'points': 200},
    {'title': 'Mountain Climber', 'icon': Icons.landscape, 'color': Color(0xFFE17055), 'earned': true, 'date': 'Mar 2025', 'points': 300},
    {'title': 'City Explorer', 'icon': Icons.location_city, 'color': Color(0xFFFDCB6E), 'earned': true, 'date': 'Apr 2025', 'points': 250},
    {'title': 'Social Butterfly', 'icon': Icons.people, 'color': Color(0xFF00B894), 'earned': true, 'date': 'May 2025', 'points': 150},
    {'title': 'Photographer', 'icon': Icons.camera_alt, 'color': Color(0xFFFF6B6B), 'earned': true, 'date': 'Jun 2025', 'points': 200},
    {'title': 'Globetrotter', 'icon': Icons.public, 'color': Color(0xFF6C5CE7), 'earned': false, 'points': 500, 'progress': 0.6},
    {'title': 'Foodie', 'icon': Icons.restaurant, 'color': Color(0xFFE17055), 'earned': false, 'points': 300, 'progress': 0.4},
    {'title': 'Adventurer', 'icon': Icons.terrain, 'color': Color(0xFF00CEC9), 'earned': false, 'points': 400, 'progress': 0.25},
    {'title': 'Legend', 'icon': Icons.emoji_events, 'color': Color(0xFFFDCB6E), 'earned': false, 'points': 1000, 'progress': 0.1},
  ];

  final List<Map<String, dynamic>> _rewards = [
    {'title': '₹500 Off Next Booking', 'points': 500, 'icon': Icons.local_offer, 'color': Color(0xFF6C5CE7)},
    {'title': 'Free Travel Insurance', 'points': 800, 'icon': Icons.shield, 'color': Color(0xFF00B894)},
    {'title': 'Priority Support', 'points': 300, 'icon': Icons.support_agent, 'color': Color(0xFFE17055)},
    {'title': 'Exclusive Trip Access', 'points': 1500, 'icon': Icons.star, 'color': Color(0xFFFDCB6E)},
  ];

  final List<Map<String, dynamic>> _leaderboard = [
    {'name': 'Priya Patel', 'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100', 'points': 4250, 'level': 18, 'rank': 1},
    {'name': 'Amit Kumar', 'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100', 'points': 3890, 'level': 16, 'rank': 2},
    {'name': 'You', 'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100', 'points': 2450, 'level': 12, 'rank': 3},
    {'name': 'Sneha Reddy', 'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100', 'points': 2100, 'level': 10, 'rank': 4},
    {'name': 'Vikram Singh', 'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100', 'points': 1850, 'level': 9, 'rank': 5},
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          _buildPointsCard().animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textMedium,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
              unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 13),
              dividerColor: Colors.transparent,
              tabs: const [Tab(text: 'Badges'), Tab(text: 'Rewards'), Tab(text: 'Leaderboard')],
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildBadgesTab(), _buildRewardsTab(), _buildLeaderboardTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsCard() {
    final nextLevelPoints = (_level + 1) * 250;
    final currentLevelPoints = _level * 250;
    final progress = (_totalPoints - currentLevelPoints) / (nextLevelPoints - currentLevelPoints);

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientEnd]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Points', style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
                  Text('$_totalPoints', style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber, size: 28),
                    Text('Level $_level', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation(Colors.amber),
            ),
          ),
          const SizedBox(height: 8),
          Text('${nextLevelPoints - _totalPoints} points to Level ${_level + 1}', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildBadgesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Earned (${_badges.where((b) => b['earned'] == true).length})', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: _badges.where((b) => b['earned'] == true).length,
            itemBuilder: (context, index) {
              final badge = _badges.where((b) => b['earned'] == true).toList()[index];
              return _buildBadgeCard(badge, true);
            },
          ),
          const SizedBox(height: 20),
          Text('In Progress (${_badges.where((b) => b['earned'] == false).length})', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: _badges.where((b) => b['earned'] == false).length,
            itemBuilder: (context, index) {
              final badge = _badges.where((b) => b['earned'] == false).toList()[index];
              return _buildBadgeCard(badge, false);
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildBadgeCard(Map<String, dynamic> badge, bool earned) {
    final color = badge['color'] as Color;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: color.withOpacity(earned ? 0.2 : 0.05), blurRadius: 10)],
        border: earned ? Border.all(color: color.withOpacity(0.3)) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: earned ? color.withOpacity(0.1) : AppColors.border.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(badge['icon'] as IconData, color: earned ? color : AppColors.textLight, size: 28),
              ),
              if (earned)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(color: AppColors.success, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                    child: const Icon(Icons.check, color: Colors.white, size: 10),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            badge['title'] as String,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 11, fontWeight: earned ? FontWeight.w600 : FontWeight.normal, color: earned ? AppColors.textDark : AppColors.textLight),
          ),
          if (earned)
            Text('+${badge['points']} pts', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.success, fontWeight: FontWeight.w600))
          else if (badge['progress'] != null)
            Text('${((badge['progress'] as double) * 100).toInt()}%', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textLight)),
        ],
      ),
    );
  }

  Widget _buildRewardsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: _rewards.map((reward) {
          final canRedeem = _totalPoints >= (reward['points'] as int);
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: (reward['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                  child: Icon(reward['icon'] as IconData, color: reward['color'] as Color, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reward['title'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                      Text('${reward['points']} points', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: canRedeem ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: canRedeem ? AppColors.primary : AppColors.border,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(canRedeem ? 'Redeem' : 'Locked', style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLeaderboardTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _leaderboard.length,
      itemBuilder: (context, index) {
        final user = _leaderboard[index];
        final isMe = user['name'] == 'You';
        final rank = user['rank'] as int;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary.withOpacity(0.05) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: isMe ? Border.all(color: AppColors.primary.withOpacity(0.3)) : null,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: rank <= 3 ? [Colors.amber, Colors.grey, Colors.brown][rank - 1] : AppColors.border,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text('#$rank', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: rank <= 3 ? Colors.white : AppColors.textMedium))),
              ),
              const SizedBox(width: 12),
              CircleAvatar(radius: 22, backgroundImage: NetworkImage(user['avatar'] as String)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isMe ? 'You' : user['name'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: isMe ? FontWeight.bold : FontWeight.w500)),
                    Text('Level ${user['level']}', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('${user['points']}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  Text('points', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textLight)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
