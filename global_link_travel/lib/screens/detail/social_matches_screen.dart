import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';
import 'user_profile_screen.dart';

class SocialMatchesScreen extends StatelessWidget {
  const SocialMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Travel Matches',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'People with similar travel interests',
              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium),
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 20),
            ...DestinationData.socialMatches.asMap().entries.map((entry) {
              final match = entry.value;
              return _buildMatchCard(context, match).animate().fadeIn(
                    delay: Duration(milliseconds: 100 * entry.key),
                    duration: 400.ms,
                  );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, Map<String, dynamic> match) {
    final matchPercent = match['matchPercent'] as int;
    Color matchColor;
    if (matchPercent >= 90) {
      matchColor = AppColors.success;
    } else if (matchPercent >= 80) {
      matchColor = AppColors.primary;
    } else {
      matchColor = AppColors.warning;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserProfileScreen(
                          name: match['name'] as String,
                          handle: match['handle'] as String,
                          avatar: match['avatar'] as String,
                          bio: 'Travel enthusiast',
                          trips: match['trips'] as int,
                          followers: 1500,
                          interests: List<String>.from(match['commonInterests'] as List),
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(match['avatar'] as String),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: matchColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            '$matchPercent%',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserProfileScreen(
                            name: match['name'] as String,
                            handle: match['handle'] as String,
                            avatar: match['avatar'] as String,
                            bio: 'Travel enthusiast',
                            trips: match['trips'] as int,
                            followers: 1500,
                            interests: List<String>.from(match['commonInterests'] as List),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          match['name'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          match['handle'] as String,
                          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.flight_takeoff, color: AppColors.primary, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '${match['trips']} trips',
                              style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: matchColor, width: 3),
                      ),
                      child: Center(
                        child: Text(
                          '$matchPercent%',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: matchColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Match',
                      style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textLight),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Common Interests',
                  style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textLight),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (match['commonInterests'] as List).map((interest) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        interest as String,
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primary),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Connection request sent to ${match['name']}!'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    icon: Icon(Icons.person_add, size: 18, color: AppColors.primary),
                    label: Text('Connect', style: TextStyle(color: AppColors.primary)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening chat with ${match['name']}...'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    },
                    icon: const Icon(Icons.message, size: 18),
                    label: const Text('Message'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
