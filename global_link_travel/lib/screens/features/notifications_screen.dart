import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'trip',
      'title': 'Trip Reminder',
      'message': 'Your trip to Goa starts in 3 days! Don\'t forget to pack.',
      'time': '2 hours ago',
      'icon': Icons.flight_takeoff,
      'color': AppColors.primary,
      'isRead': false,
    },
    {
      'type': 'friend',
      'title': 'New Friend Request',
      'message': 'Priya Patel wants to connect with you.',
      'time': '3 hours ago',
      'icon': Icons.person_add,
      'color': AppColors.success,
      'isRead': false,
    },
    {
      'type': 'like',
      'title': 'Post Liked',
      'message': 'Amit Kumar liked your photo from Manali.',
      'time': '5 hours ago',
      'icon': Icons.favorite,
      'color': AppColors.accent,
      'isRead': false,
    },
    {
      'type': 'comment',
      'title': 'New Comment',
      'message': 'Sneha Reddy commented: "Amazing views!"',
      'time': '8 hours ago',
      'icon': Icons.comment,
      'color': AppColors.teal,
      'isRead': true,
    },
    {
      'type': 'achievement',
      'title': 'Badge Earned!',
      'message': 'Congratulations! You earned the "Beach Lover" badge.',
      'time': '1 day ago',
      'icon': Icons.emoji_events,
      'color': AppColors.warning,
      'isRead': true,
    },
    {
      'type': 'booking',
      'title': 'Booking Confirmed',
      'message': 'Your Kerala Backwaters trip has been confirmed.',
      'time': '2 days ago',
      'icon': Icons.book_online,
      'color': AppColors.success,
      'isRead': true,
    },
    {
      'type': 'offer',
      'title': 'Special Offer',
      'message': 'Get 20% off on Rajasthan packages this weekend!',
      'time': '3 days ago',
      'icon': Icons.local_offer,
      'color': AppColors.primary,
      'isRead': true,
    },
  ];

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notif in _notifications) {
        notif['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('All notifications marked as read'), backgroundColor: AppColors.success),
    );
  }

  int get _unreadCount => _notifications.where((n) => n['isRead'] == false).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            if (_unreadCount > 0)
              Text('$_unreadCount unread', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.accent)),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _unreadCount > 0 ? _markAllAsRead : null,
            child: Text(
              'Mark all read',
              style: GoogleFonts.poppins(
                color: _unreadCount > 0 ? AppColors.primary : AppColors.textLight,
              ),
            ),
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off, size: 60, color: AppColors.textLight),
                  const SizedBox(height: 16),
                  Text('No notifications', style: GoogleFonts.poppins(fontSize: 18, color: AppColors.textMedium)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notif = _notifications[index];
                final isRead = notif['isRead'] as bool;
                final color = notif['color'] as Color;

                return Dismissible(
                  key: Key('$index'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      _notifications.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Notification deleted'), backgroundColor: AppColors.error),
                    );
                  },
                  child: GestureDetector(
                    onTap: () => _markAsRead(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isRead ? Colors.white : AppColors.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(14),
                        border: isRead
                            ? Border.all(color: AppColors.border)
                            : Border.all(color: AppColors.primary.withOpacity(0.2), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: isRead ? Colors.black.withOpacity(0.02) : AppColors.primary.withOpacity(0.1),
                            blurRadius: isRead ? 5 : 10,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(notif['icon'] as IconData, color: color, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notif['title'] as String,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ),
                                    if (!isRead)
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary.withOpacity(0.3),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notif['message'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: isRead ? AppColors.textMedium : AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 12, color: AppColors.textLight),
                                    const SizedBox(width: 4),
                                    Text(
                                      notif['time'] as String,
                                      style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight),
                                    ),
                                    if (!isRead) ...[
                                      const SizedBox(width: 12),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'NEW',
                                          style: GoogleFonts.poppins(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
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
                    ),
                  ),
                );
              },
            ),
    );
  }
}
