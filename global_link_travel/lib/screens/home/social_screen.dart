import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';
import '../detail/social_matches_screen.dart';
import '../detail/trip_package_detail_screen.dart';
import '../detail/user_profile_screen.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, bool> _likedPosts = {};
  final Map<String, bool> _bookmarkedPosts = {};
  final Map<String, int> _postLikes = {};
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    for (var post in DestinationData.trendingPosts) {
      _likedPosts[post['id']] = post['isLiked'] as bool;
      _bookmarkedPosts[post['id']] = post['isBookmarked'] as bool;
      _postLikes[post['id']] = post['likes'] as int;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _toggleLike(String postId) {
    setState(() {
      _likedPosts[postId] = !(_likedPosts[postId] ?? false);
      if (_likedPosts[postId]!) {
        _postLikes[postId] = (_postLikes[postId] ?? 0) + 1;
      } else {
        _postLikes[postId] = (_postLikes[postId] ?? 0) - 1;
      }
    });
  }

  void _toggleBookmark(String postId) {
    setState(() {
      _bookmarkedPosts[postId] = !(_bookmarkedPosts[postId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        'Social',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        'Connect with travelers',
                        style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium),
                      ),
                    ],
                  ).animate().fadeIn(duration: 400.ms),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SocialMatchesScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.people, color: AppColors.accent, size: 22),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          _showNotificationsSheet();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Icon(Icons.notifications_outlined, color: AppColors.primary, size: 22),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 13),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Trending'),
                  Tab(text: 'Face Connect'),
                  Tab(text: 'Trips'),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTrendingTab(),
                  _buildFaceConnectTab(),
                  _buildTripsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFriendRequests().animate().fadeIn(delay: 150.ms, duration: 400.ms),
          const SizedBox(height: 20),
          ...DestinationData.trendingPosts.map((post) {
            return _buildTrendingPost(post).animate().fadeIn(
                  delay: Duration(milliseconds: 200 + DestinationData.trendingPosts.indexOf(post) * 100),
                  duration: 400.ms,
                );
          }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildFriendRequests() {
    if (DestinationData.friendRequests.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_add, color: Colors.white, size: 22),
              const SizedBox(width: 10),
              Text(
                'Friend Requests',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${DestinationData.friendRequests.length}',
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...DestinationData.friendRequests.map((req) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UserProfileScreen(
                              name: req['name'] as String,
                              handle: req['handle'] as String,
                              avatar: req['avatar'] as String,
                              bio: 'Travel enthusiast',
                              trips: 10,
                              followers: 500,
                              isOnline: false,
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(req['avatar'] as String),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UserProfileScreen(
                                name: req['name'] as String,
                                handle: req['handle'] as String,
                                avatar: req['avatar'] as String,
                                bio: 'Travel enthusiast',
                                trips: 10,
                                followers: 500,
                                isOnline: false,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              req['name'] as String,
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            Text(
                              '${req['mutualFriends']} mutual friends',
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Request accepted!'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Accept', style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Request declined'),
                            backgroundColor: AppColors.textMedium,
                          ),
                        );
                      },
                      icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTrendingPost(Map<String, dynamic> post) {
    final postId = post['id'] as String;
    final isLiked = _likedPosts[postId] ?? false;
    final isBookmarked = _bookmarkedPosts[postId] ?? false;
    final likes = _postLikes[postId] ?? post['likes'] as int;
    final images = post['images'] as List;
    final comments = post['commentList'] as List;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserProfileScreen(
                          name: post['author'] as String,
                          handle: post['handle'] as String,
                          avatar: post['avatar'] as String,
                          bio: 'Travel enthusiast | Explorer',
                          trips: 15,
                          followers: 1200,
                          isOnline: true,
                          interests: ['Mountains', 'Beaches', 'Photography'],
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(post['avatar'] as String),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserProfileScreen(
                            name: post['author'] as String,
                            handle: post['handle'] as String,
                            avatar: post['avatar'] as String,
                            bio: 'Travel enthusiast | Explorer',
                            trips: 15,
                            followers: 1200,
                            isOnline: true,
                            interests: ['Mountains', 'Beaches', 'Photography'],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post['author'] as String,
                              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
                            ),
                            if (post['tripTag'] != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '#${post['tripTag']}',
                                  style: GoogleFonts.poppins(fontSize: 10, color: AppColors.primary),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          '${post['handle']} • ${post['time']}',
                          style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textLight),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showPostOptionsSheet(post),
                  child: Icon(Icons.more_horiz, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              post['content'] as String,
              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textDark, height: 1.5),
            ),
          ),
          const SizedBox(height: 12),
          if (images.isNotEmpty)
            SizedBox(
              height: 220,
              child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        images[index] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.primary.withOpacity(0.1),
                          child: Icon(Icons.image, color: AppColors.primary),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _toggleLike(postId),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isLiked ? AppColors.accent.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? AppColors.accent : AppColors.textMedium,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$likes',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: isLiked ? AppColors.accent : AppColors.textMedium,
                            fontWeight: isLiked ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _showCommentsSheet(post, comments),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, color: AppColors.textMedium, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '${post['comments']}',
                          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Post shared!'), backgroundColor: AppColors.success),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.share_outlined, color: AppColors.textMedium, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '${post['shares']}',
                          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _toggleBookmark(postId),
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked ? AppColors.primary : AppColors.textMedium,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentsSheet(Map<String, dynamic> post, List comments) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Comments (${comments.length})',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            child: Text(
                              (comment['author'] as String)[0],
                              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      comment['author'] as String,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
                                    ),
                                    const Spacer(),
                                    Text(
                                      comment['time'] as String,
                                      style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comment['text'] as String,
                                  style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).viewInsets.bottom + 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        if (_commentController.text.isNotEmpty) {
                          setState(() {
                            comments.add({
                              'author': 'Rahul Sharma',
                              'text': _commentController.text,
                              'time': 'Just now',
                            });
                          });
                          _commentController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send, color: Colors.white, size: 20),
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

  Widget _buildFaceConnectTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.teal, AppColors.teal.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.people_alt, color: Colors.white, size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Face Connect',
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Connect with travelers near you',
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '5 Nearby',
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 20),
          Text(
            'Travelers Near You',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
          const SizedBox(height: 12),
          ...DestinationData.faceConnectUsers.asMap().entries.map((entry) {
            return _buildFaceConnectCard(entry.value).animate().fadeIn(
                  delay: Duration(milliseconds: 150 + entry.key * 80),
                  duration: 400.ms,
                );
          }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildFaceConnectCard(Map<String, dynamic> user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserProfileScreen(
                    name: user['name'] as String,
                    handle: user['handle'] as String,
                    avatar: user['avatar'] as String,
                    bio: user['bio'] as String,
                    trips: user['trips'] as int,
                    followers: user['followers'] as int,
                    isFollowing: user['isFollowing'] as bool,
                    isOnline: user['isOnline'] as bool,
                    interests: ['Mountains', 'Beaches', 'Adventure'],
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user['avatar'] as String),
                ),
                if (user['isOnline'] as bool)
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
          ),
          const SizedBox(width: 14),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserProfileScreen(
                      name: user['name'] as String,
                      handle: user['handle'] as String,
                      avatar: user['avatar'] as String,
                      bio: user['bio'] as String,
                      trips: user['trips'] as int,
                      followers: user['followers'] as int,
                      isFollowing: user['isFollowing'] as bool,
                      isOnline: user['isOnline'] as bool,
                      interests: ['Mountains', 'Beaches', 'Adventure'],
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['name'] as String,
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  Text(
                    user['bio'] as String,
                    style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.flight_takeoff, color: AppColors.primary, size: 14),
                      const SizedBox(width: 4),
                      Text('${user['trips']} trips', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight)),
                      const SizedBox(width: 12),
                      Icon(Icons.people, color: AppColors.primary, size: 14),
                      const SizedBox(width: 4),
                      Text('${user['followers']} followers', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    user['isFollowing'] = !(user['isFollowing'] as bool);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(user['isFollowing'] ? 'Following ${user['name']}' : 'Unfollowed ${user['name']}'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: (user['isFollowing'] as bool) ? AppColors.primary.withOpacity(0.1) : AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                    border: (user['isFollowing'] as bool) ? Border.all(color: AppColors.primary) : null,
                  ),
                  child: Text(
                    (user['isFollowing'] as bool) ? 'Following' : 'Follow',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: (user['isFollowing'] as bool) ? AppColors.primary : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                user['lastActive'] as String,
                style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textLight),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTripsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trip Packages',
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 6),
          Text(
            'Curated itineraries for your next adventure',
            style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
          ).animate().fadeIn(delay: 50.ms, duration: 400.ms),
          const SizedBox(height: 16),
          ...DestinationData.tripPackages.asMap().entries.map((entry) {
            return _buildTripPackageCard(entry.value).animate().fadeIn(
                  delay: Duration(milliseconds: 100 + entry.key * 80),
                  duration: 400.ms,
                );
          }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildTripPackageCard(Map<String, dynamic> pkg) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TripPackageDetailScreen(package: pkg)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                  child: Image.network(
                    pkg['image'] as String,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180,
                      color: AppColors.primary.withOpacity(0.1),
                      child: Icon(Icons.image, color: AppColors.primary, size: 40),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${pkg['rating']}',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      pkg['duration'] as String,
                      style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark),
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
                    pkg['title'] as String,
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pkg['subtitle'] as String,
                    style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: AppColors.textLight, size: 14),
                      const SizedBox(width: 6),
                      Text(pkg['duration'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                      const SizedBox(width: 16),
                      Icon(Icons.people, color: AppColors.textLight, size: 14),
                      const SizedBox(width: 6),
                      Text(pkg['groupSize'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${pkg['price']}',
                        style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'View Details',
                          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
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

  void _showPostOptionsSheet(Map<String, dynamic> post) {
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
            ListTile(
              leading: Icon(Icons.person, color: AppColors.primary),
              title: Text('View Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserProfileScreen(
                      name: post['author'] as String,
                      handle: post['handle'] as String,
                      avatar: post['avatar'] as String,
                      bio: 'Travel enthusiast | Explorer',
                      trips: 15,
                      followers: 1200,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark_border, color: AppColors.primary),
              title: Text('Save Post'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Post saved!'), backgroundColor: AppColors.success),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: AppColors.primary),
              title: Text('Share Post'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Post shared!'), backgroundColor: AppColors.success),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.report_outlined, color: AppColors.error),
              title: Text('Report Post', style: TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Post reported'), backgroundColor: AppColors.error),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationsSheet() {
    final notifications = [
      {'title': 'Priya Patel liked your post', 'time': '2 min ago', 'icon': Icons.favorite, 'color': AppColors.accent},
      {'title': 'New friend request from Amit Kumar', 'time': '1 hour ago', 'icon': Icons.person_add, 'color': AppColors.success},
      {'title': 'Sneha Reddy commented on your photo', 'time': '3 hours ago', 'icon': Icons.comment, 'color': AppColors.primary},
      {'title': 'You earned "Beach Lover" badge!', 'time': 'Yesterday', 'icon': Icons.emoji_events, 'color': AppColors.warning},
      {'title': 'Vikram Singh shared a trip', 'time': '2 days ago', 'icon': Icons.flight_takeoff, 'color': AppColors.teal},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              Text('Notifications', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ...notifications.map((notif) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (notif['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(notif['icon'] as IconData, color: notif['color'] as Color, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notif['title'] as String, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
                          Text(notif['time'] as String, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
