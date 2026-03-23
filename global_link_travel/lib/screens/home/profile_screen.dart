import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../auth/login_screen.dart';
import '../features/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildHeader().animate().fadeIn(duration: 400.ms),
                    const SizedBox(height: 20),
                    _buildProfileInfo().animate().fadeIn(delay: 100.ms, duration: 400.ms),
                    const SizedBox(height: 20),
                    _buildStats().animate().fadeIn(delay: 150.ms, duration: 400.ms),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textMedium,
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                    unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 14),
                    tabs: [
                      Tab(text: 'Posts (${UserData.postsCount})'),
                      Tab(text: 'Trips (${UserData.totalTrips})'),
                      Tab(text: 'Achievements'),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildPostsTab(),
              _buildTripsTab(),
              _buildAchievementsTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => _showEditProfileSheet(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                    ],
                  ),
                  child: Icon(Icons.edit, color: AppColors.primary, size: 20),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                    ],
                  ),
                  child: Icon(Icons.settings, color: AppColors.textMedium, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.gradientStart, AppColors.gradientEnd],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        UserData.name[0],
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _showChangePhotoSheet(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          UserData.name,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        Text(
          UserData.handle,
          style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium),
        ),
        const SizedBox(height: 8),
        Text(
          UserData.bio,
          style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.teal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, color: AppColors.teal, size: 16),
              const SizedBox(width: 6),
              Text(
                UserData.travelStatus,
                style: GoogleFonts.poppins(fontSize: 13, color: AppColors.teal, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('${UserData.totalTrips}', 'Trips', AppColors.primary),
          _buildVerticalDivider(),
          _buildStatItem('${UserData.countriesVisited}', 'Countries', AppColors.teal),
          _buildVerticalDivider(),
          _buildStatItem('${UserData.friendsCount}', 'Friends', AppColors.accent),
          _buildVerticalDivider(),
          _buildStatItem('${UserData.postsCount}', 'Posts', AppColors.warning),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.border,
    );
  }

  Widget _buildPostsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final images = DestinationData.popularDestinations.map((d) => d['image'] as String).toList();
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  images[index % images.length],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.image, color: AppColors.primary),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.favorite, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${45 + index * 12}',
                              style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.chat_bubble, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${8 + index * 3}',
                              style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                            ),
                          ],
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
    );
  }

  Widget _buildTripsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: DestinationData.userTrips.length,
      itemBuilder: (context, index) {
        final trip = DestinationData.userTrips[index];
        Color statusColor;
        switch (trip['status']) {
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
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  trip['image'] as String,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 70,
                    height: 70,
                    color: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.image, color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      trip['location'] as String,
                      style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        trip['status'] as String,
                        style: GoogleFonts.poppins(fontSize: 11, color: statusColor, fontWeight: FontWeight.w600),
                      ),
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

  Widget _buildAchievementsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: DestinationData.achievements.length,
      itemBuilder: (context, index) {
        final achievement = DestinationData.achievements[index];
        final earned = achievement['earned'] as bool;
        final color = achievement['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: earned ? color.withOpacity(0.1) : AppColors.border.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  achievement['icon'] as IconData,
                  color: earned ? color : AppColors.textLight,
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: earned ? AppColors.textDark : AppColors.textLight,
                      ),
                    ),
                    Text(
                      earned ? 'Earned!' : 'Keep traveling to unlock',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: earned ? AppColors.success : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              if (earned)
                Icon(Icons.check_circle, color: AppColors.success, size: 28)
              else
                Icon(Icons.lock, color: AppColors.textLight, size: 24),
            ],
          ),
        );
      },
    );
  }

  void _showEditProfileSheet() {
    final nameController = TextEditingController(text: UserData.name);
    final bioController = TextEditingController(text: UserData.bio);

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
            Text('Edit Profile', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: bioController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Bio', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text('Profile updated!'), backgroundColor: AppColors.success),
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

  void _showChangePhotoSheet() {
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
            Text('Change Profile Photo', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.primary),
              title: const Text('Take Photo'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.primary),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.delete, color: AppColors.error),
              title: Text('Remove Photo', style: TextStyle(color: AppColors.error)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              Text('Settings', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.notifications_outlined, color: AppColors.primary),
                title: const Text('Notifications'),
                trailing: Switch(value: true, onChanged: (_) {}, activeColor: AppColors.primary),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.dark_mode_outlined, color: AppColors.primary),
                title: const Text('Dark Mode'),
                trailing: Switch(value: false, onChanged: (_) {}, activeColor: AppColors.primary),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.language, color: AppColors.primary),
                title: const Text('Language'),
                subtitle: const Text('English'),
                trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textLight, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip_outlined, color: AppColors.primary),
                title: const Text('Privacy Policy'),
                trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textLight, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.description_outlined, color: AppColors.primary),
                title: const Text('Terms of Service'),
                trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textLight, size: 16),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info_outline, color: AppColors.primary),
                title: const Text('About'),
                subtitle: const Text('Version 1.0.0'),
                trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textLight, size: 16),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: AppColors.error),
                title: Text('Sign Out', style: TextStyle(color: AppColors.error)),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.background,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
