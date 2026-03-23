import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants.dart';

class UserProfileScreen extends StatelessWidget {
  final String name;
  final String handle;
  final String avatar;
  final String bio;
  final int trips;
  final int followers;
  final bool isFollowing;
  final bool isOnline;
  final List<String> interests;

  const UserProfileScreen({
    super.key,
    required this.name,
    required this.handle,
    required this.avatar,
    required this.bio,
    required this.trips,
    required this.followers,
    this.isFollowing = false,
    this.isOnline = false,
    this.interests = const [],
  });

  @override
  Widget build(BuildContext context) {
    final posts = [
      'https://images.unsplash.com/photo-1544735716-392fe2489ffa?w=400',
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
      'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=400',
      'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
      'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400',
      'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=400',
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    avatar,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.primary,
                      child: Center(
                        child: Text(
                          name[0],
                          style: GoogleFonts.poppins(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.arrow_back_ios_new, color: AppColors.textDark, size: 20),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text('Profile shared!'), backgroundColor: AppColors.success),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.share, color: AppColors.textDark, size: 20),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(avatar),
                          ),
                          if (isOnline)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(name, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 6),
                                Icon(Icons.verified, color: AppColors.primary, size: 20),
                              ],
                            ),
                            Text(handle, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(bio, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium, height: 1.5)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildStatItem('$trips', 'Trips', AppColors.primary),
                      const SizedBox(width: 24),
                      _buildStatItem('$followers', 'Followers', AppColors.teal),
                      const SizedBox(width: 24),
                      _buildStatItem('${(followers * 0.3).toInt()}', 'Following', AppColors.accent),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(isFollowing ? 'Unfollowed $name' : 'Following $name'), backgroundColor: AppColors.success),
                            );
                          },
                          icon: Icon(isFollowing ? Icons.person_remove : Icons.person_add, size: 18),
                          label: Text(isFollowing ? 'Unfollow' : 'Follow'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: const Text('Opening chat...'), backgroundColor: AppColors.primary),
                            );
                          },
                          icon: Icon(Icons.message, color: AppColors.primary, size: 18),
                          label: Text('Message', style: TextStyle(color: AppColors.primary)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (interests.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text('Interests', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: interests.map((interest) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(interest, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primary)),
                      )).toList(),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Text('Photos', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        posts[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.primary.withOpacity(0.1),
                          child: Icon(Icons.image, color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
      ],
    );
  }
}
