import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';
import '../detail/destination_detail_screen.dart';
import '../detail/social_matches_screen.dart';
import '../detail/heritage_sites_screen.dart';
import '../auth/login_screen.dart';
import '../features/chat_screen.dart';
import '../features/expense_tracker_screen.dart';
import '../features/weather_screen.dart';
import '../features/travel_journal_screen.dart';
import '../features/group_trip_planner_screen.dart';
import '../features/rewards_screen.dart';
import '../features/sos_emergency_screen.dart';
import '../features/settings_screen.dart';
import '../features/notifications_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader().animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 24),
              _buildStatsCards().animate().fadeIn(delay: 100.ms, duration: 400.ms),
              const SizedBox(height: 24),
              _buildQuickActions().animate().fadeIn(delay: 200.ms, duration: 400.ms),
              const SizedBox(height: 24),
              _buildSectionTitle('Recent Activity', 'See All'),
              const SizedBox(height: 12),
              _buildActivityFeed().animate().fadeIn(delay: 300.ms, duration: 400.ms),
              const SizedBox(height: 24),
              _buildSectionTitle('Popular Destinations', 'See All'),
              const SizedBox(height: 12),
              _buildPopularDestinations().animate().fadeIn(delay: 400.ms, duration: 400.ms),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              UserData.name[0],
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
              ),
              Text(
                UserData.name,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                UserData.travelStatus,
                style: GoogleFonts.poppins(fontSize: 12, color: AppColors.teal),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            );
          },
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(child: Icon(Icons.notifications_outlined, color: AppColors.primary, size: 24)),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        _buildStatCard(Icons.flight_takeoff, '${UserData.totalTrips}', 'Trips', AppColors.primary),
        const SizedBox(width: 12),
        _buildStatCard(Icons.public, '${UserData.countriesVisited}', 'Countries', AppColors.teal),
        const SizedBox(width: 12),
        _buildStatCard(Icons.people, '${UserData.friendsCount}', 'Friends', AppColors.accent),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildActionButton(Icons.cloud, 'Weather', AppColors.teal, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const WeatherScreen()));
            }),
            const SizedBox(width: 12),
            _buildActionButton(Icons.account_balance_wallet, 'Expenses', AppColors.primary, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseTrackerScreen()));
            }),
            const SizedBox(width: 12),
            _buildActionButton(Icons.chat, 'Chat', AppColors.accent, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen(
                userName: 'Priya Patel',
                avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
                isOnline: true,
              )));
            }),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildActionButton(Icons.book, 'Journal', AppColors.warning, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TravelJournalScreen()));
            }),
            const SizedBox(width: 12),
            _buildActionButton(Icons.group, 'Groups', AppColors.success, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const GroupTripPlannerScreen()));
            }),
            const SizedBox(width: 12),
            _buildActionButton(Icons.emoji_events, 'Rewards', AppColors.orange, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen()));
            }),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildActionButton(Icons.emergency, 'SOS', AppColors.error, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SOSEmergencyScreen()));
            }),
            const SizedBox(width: 12),
            _buildActionButton(Icons.person, 'Matches', AppColors.secondary, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SocialMatchesScreen()));
            }),
            const SizedBox(width: 12),
            _buildActionButton(Icons.temple_buddhist, 'Heritage', AppColors.warning, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const HeritageSitesScreen()));
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
            boxShadow: [BoxShadow(color: color.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (title == 'Recent Activity') {
              _showAllActivitiesSheet();
            }
          },
          child: Text(
            action,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _showAllActivitiesSheet() {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('All Activities', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: DestinationData.recentActivities.length,
                itemBuilder: (context, index) {
                  final activity = DestinationData.recentActivities[index];
                  final color = activity['color'] as Color? ?? AppColors.primary;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: color.withOpacity(0.08), blurRadius: 10)],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                          child: Icon(activity['icon'] as IconData, color: color, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activity['title'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                              if (activity['subtitle'] != null) Text(activity['subtitle'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                              Text(activity['time'] as String, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityFeed() {
    return Column(
      children: DestinationData.recentActivities.map((activity) {
        final color = activity['color'] as Color? ?? AppColors.primary;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(activity['icon'] as IconData, color: color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    if (activity['subtitle'] != null)
                      Text(
                        activity['subtitle'] as String,
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
                      ),
                    Text(
                      activity['time'] as String,
                      style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.arrow_forward_ios, color: color, size: 14),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPopularDestinations() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: DestinationData.popularDestinations.take(5).length,
        itemBuilder: (context, index) {
          final dest = DestinationData.popularDestinations[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DestinationDetailScreen(destination: dest)),
              );
            },
            child: Container(
              width: 180,
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
                      dest['image'] as String,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: Icon(Icons.image, color: AppColors.primary, size: 40),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
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
                          dest['name'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white70, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              dest['country'] as String,
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                        Text(
                          '₹${dest['price']}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.warning,
                          ),
                        ),
                      ],
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
