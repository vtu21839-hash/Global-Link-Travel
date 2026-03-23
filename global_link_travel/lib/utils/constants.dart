import 'package:flutter/material.dart';

class AppColors {
  static Color primary = const Color(0xFF6C5CE7);
  static Color secondary = const Color(0xFFA29BFE);
  static Color accent = const Color(0xFFFF6B6B);
  static Color background = const Color(0xFFF8F9FD);
  static Color surface = Colors.white;
  static Color textDark = const Color(0xFF2D3436);
  static Color textMedium = const Color(0xFF636E72);
  static Color textLight = const Color(0xFFB2BEC3);
  static Color border = const Color(0xFFDFE6E9);
  static Color success = const Color(0xFF00B894);
  static Color warning = const Color(0xFFFDCB6E);
  static Color error = const Color(0xFFE17055);
  static Color cardShadow = const Color(0x1A000000);
  static Color gradientStart = const Color(0xFF6C5CE7);
  static Color gradientEnd = const Color(0xFFA29BFE);
  static Color teal = const Color(0xFF00CEC9);
  static Color orange = const Color(0xFFE17055);
}

class AppConstants {
  static const String appName = 'Global Link Travel';
  static const double defaultPadding = 20.0;
  static const double borderRadius = 16.0;
}

class AppAssets {
  static const String logo = 'assets/images/logo.png';
}

class UserData {
  static const String name = 'Rahul Sharma';
  static const String handle = '@rahulsharma';
  static const String bio = 'Wanderlust | Explorer | Adventure Seeker';
  static const String avatar = 'https://randomuser.me/api/portraits/men/32.jpg';
  static const int totalTrips = 24;
  static const int countriesVisited = 12;
  static const int friendsCount = 156;
  static const int postsCount = 48;
  static const String travelStatus = 'Currently in Goa 🏖️';
}

class DestinationData {
  static List<Map<String, dynamic>> popularDestinations = [
    {
      'name': 'Goa',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400',
      'price': 15999,
      'rating': 4.8,
      'description': 'Beach Paradise',
      'category': 'Beaches',
    },
    {
      'name': 'Manali',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
      'price': 12499,
      'rating': 4.9,
      'description': 'Mountain Retreat',
      'category': 'Mountains',
    },
    {
      'name': 'Mumbai',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=400',
      'price': 9999,
      'rating': 4.6,
      'description': 'City of Dreams',
      'category': 'Cities',
    },
    {
      'name': 'Jaipur',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=400',
      'price': 8499,
      'rating': 4.7,
      'description': 'Pink City',
      'category': 'Cities',
    },
    {
      'name': 'Shimla',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
      'price': 10999,
      'rating': 4.5,
      'description': 'Queen of Hills',
      'category': 'Mountains',
    },
    {
      'name': 'Kerala',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=400',
      'price': 18999,
      'rating': 4.9,
      'description': 'God\'s Own Country',
      'category': 'Beaches',
    },
    {
      'name': 'Varanasi',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?w=400',
      'price': 7499,
      'rating': 4.8,
      'description': 'Spiritual Capital',
      'category': 'Cities',
    },
    {
      'name': 'Rishikesh',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1545389336-cf090694435e?w=400',
      'price': 8999,
      'rating': 4.7,
      'description': 'Yoga Capital',
      'category': 'Mountains',
    },
    {
      'name': 'Andaman',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=400',
      'price': 24999,
      'rating': 4.9,
      'description': 'Island Paradise',
      'category': 'Beaches',
    },
    {
      'name': 'Delhi',
      'country': 'India',
      'image': 'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=400',
      'price': 6999,
      'rating': 4.5,
      'description': 'Capital City',
      'category': 'Cities',
    },
  ];

  static List<Map<String, dynamic>> categories = [
    {'name': 'Beaches', 'icon': Icons.beach_access, 'color': Color(0xFF00CEC9)},
    {'name': 'Mountains', 'icon': Icons.landscape, 'color': Color(0xFF6C5CE7)},
    {'name': 'Cities', 'icon': Icons.location_city, 'color': Color(0xFFE17055)},
    {'name': 'Deserts', 'icon': Icons.wb_sunny, 'color': Color(0xFFFDCB6E)},
  ];

  static List<Map<String, dynamic>> travelPackages = [
    {
      'title': 'Golden Triangle',
      'destinations': ['Delhi', 'Agra', 'Jaipur'],
      'duration': '7 Days',
      'price': 35999,
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=400',
    },
    {
      'title': 'Kerala Backwaters',
      'destinations': ['Kochi', 'Munnar', 'Alleppey'],
      'duration': '6 Days',
      'price': 28999,
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=400',
    },
    {
      'title': 'Himalayan Adventure',
      'destinations': ['Manali', 'Leh', 'Ladakh'],
      'duration': '10 Days',
      'price': 54999,
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
    },
    {
      'title': 'Goa Beach Party',
      'destinations': ['North Goa', 'South Goa', 'Dudhsagar'],
      'duration': '5 Days',
      'price': 19999,
      'rating': 4.6,
      'image': 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400',
    },
  ];

  static List<Map<String, dynamic>> trendingTrips = [
    {
      'title': 'Solo Trip to Rishikesh',
      'author': 'Priya Patel',
      'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
      'likes': 234,
      'comments': 45,
      'image': 'https://images.unsplash.com/photo-1545389336-cf090694435e?w=400',
      'duration': '4 Days',
    },
    {
      'title': 'Road Trip to Ladakh',
      'author': 'Amit Kumar',
      'avatar': 'https://randomuser.me/api/portraits/men/22.jpg',
      'likes': 567,
      'comments': 89,
      'image': 'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
      'duration': '12 Days',
    },
    {
      'title': 'Backpacking Rajasthan',
      'author': 'Sneha Reddy',
      'avatar': 'https://randomuser.me/api/portraits/women/68.jpg',
      'likes': 345,
      'comments': 67,
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=400',
      'duration': '8 Days',
    },
  ];

  static List<Map<String, dynamic>> recentActivities = [
    {
      'type': 'trip',
      'title': 'Upcoming trip to Goa',
      'subtitle': 'Apr 15-20, 2026',
      'time': 'In 3 days',
      'icon': Icons.flight_takeoff,
      'color': Color(0xFF6C5CE7),
    },
    {
      'type': 'friend',
      'title': 'New friend: Priya Patel',
      'subtitle': 'You are now connected',
      'time': '2 hours ago',
      'icon': Icons.person_add,
      'color': Color(0xFF00B894),
    },
    {
      'type': 'achievement',
      'title': 'Earned "Beach Lover" badge',
      'subtitle': '+100 points earned',
      'time': 'Yesterday',
      'icon': Icons.emoji_events,
      'color': Color(0xFFFDCB6E),
    },
    {
      'type': 'post',
      'title': 'Shared photos from Manali',
      'subtitle': '12 likes, 5 comments',
      'time': '2 days ago',
      'icon': Icons.photo_library,
      'color': Color(0xFFFF6B6B),
    },
    {
      'type': 'booking',
      'title': 'Booked Kerala Backwaters trip',
      'subtitle': '₹32,999 confirmed',
      'time': '3 days ago',
      'icon': Icons.book_online,
      'color': Color(0xFF00CEC9),
    },
    {
      'type': 'review',
      'title': 'Reviewed Darjeeling trip',
      'subtitle': 'Rated 5 stars',
      'time': '4 days ago',
      'icon': Icons.star,
      'color': Color(0xFFFDCB6E),
    },
  ];

  static List<Map<String, dynamic>> socialPosts = [
    {
      'author': 'Priya Patel',
      'handle': '@priyapatel',
      'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
      'content': 'Just reached Manali! The snow-capped mountains are breathtaking! 🏔️',
      'image': 'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
      'likes': 124,
      'comments': 23,
      'time': '3h ago',
    },
    {
      'author': 'Amit Kumar',
      'handle': '@amitkumar',
      'avatar': 'https://randomuser.me/api/portraits/men/22.jpg',
      'content': 'Sunset at Marina Beach, Chennai. Nothing beats this view! 🌅',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
      'likes': 256,
      'comments': 45,
      'time': '5h ago',
    },
    {
      'author': 'Sneha Reddy',
      'handle': '@snehareddy',
      'avatar': 'https://randomuser.me/api/portraits/women/68.jpg',
      'content': 'Exploring the streets of Jaipur. The Pink City never disappoints! 🏰',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=400',
      'likes': 189,
      'comments': 34,
      'time': '8h ago',
    },
  ];

  static List<Map<String, dynamic>> socialMatches = [
    {
      'name': 'Priya Patel',
      'handle': '@priyapatel',
      'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
      'matchPercent': 92,
      'commonInterests': ['Mountains', 'Photography', 'Solo Travel'],
      'trips': 18,
    },
    {
      'name': 'Amit Kumar',
      'handle': '@amitkumar',
      'avatar': 'https://randomuser.me/api/portraits/men/22.jpg',
      'matchPercent': 87,
      'commonInterests': ['Beaches', 'Adventure', 'Road Trips'],
      'trips': 22,
    },
    {
      'name': 'Sneha Reddy',
      'handle': '@snehareddy',
      'avatar': 'https://randomuser.me/api/portraits/women/68.jpg',
      'matchPercent': 85,
      'commonInterests': ['Heritage', 'Food', 'Culture'],
      'trips': 15,
    },
    {
      'name': 'Vikram Singh',
      'handle': '@vikramsingh',
      'avatar': 'https://randomuser.me/api/portraits/men/52.jpg',
      'matchPercent': 79,
      'commonInterests': ['Trekking', 'Nature', 'Camping'],
      'trips': 31,
    },
  ];

  static List<Map<String, dynamic>> achievements = [
    {'title': 'Beach Lover', 'icon': Icons.beach_access, 'color': Color(0xFF00CEC9), 'earned': true, 'points': 100, 'date': 'Jan 2025'},
    {'title': 'Mountain Climber', 'icon': Icons.landscape, 'color': Color(0xFF6C5CE7), 'earned': true, 'points': 200, 'date': 'Feb 2025'},
    {'title': 'City Explorer', 'icon': Icons.location_city, 'color': Color(0xFFE17055), 'earned': true, 'points': 150, 'date': 'Mar 2025'},
    {'title': 'Globetrotter', 'icon': Icons.public, 'color': Color(0xFFFDCB6E), 'earned': true, 'points': 500, 'date': 'Apr 2025'},
    {'title': 'Social Butterfly', 'icon': Icons.people, 'color': Color(0xFF00B894), 'earned': true, 'points': 300, 'date': 'May 2025'},
    {'title': 'Photographer', 'icon': Icons.camera_alt, 'color': Color(0xFFFF6B6B), 'earned': true, 'points': 250, 'date': 'Jun 2025'},
    {'title': 'Foodie', 'icon': Icons.restaurant, 'color': Color(0xFFE17055), 'earned': true, 'points': 200, 'date': 'Jul 2025'},
    {'title': 'Adventurer', 'icon': Icons.terrain, 'color': Color(0xFF00CEC9), 'earned': true, 'points': 350, 'date': 'Aug 2025'},
    {'title': 'Night Owl', 'icon': Icons.nightlife, 'color': Color(0xFF6C5CE7), 'earned': true, 'points': 150, 'date': 'Sep 2025'},
    {'title': 'Early Bird', 'icon': Icons.wb_sunny, 'color': Color(0xFFFDCB6E), 'earned': true, 'points': 150, 'date': 'Oct 2025'},
    {'title': 'Solo Traveler', 'icon': Icons.person, 'color': Color(0xFFFF6B6B), 'earned': true, 'points': 400, 'date': 'Nov 2025'},
    {'title': 'Legend', 'icon': Icons.emoji_events, 'color': Color(0xFFFDCB6E), 'earned': true, 'points': 1000, 'date': 'Dec 2025'},
  ];

  static List<Map<String, dynamic>> userTrips = [
    {
      'title': 'Goa Beach Vacation',
      'status': 'Ongoing',
      'dates': 'Mar 20 - Mar 25, 2026',
      'image': 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400',
      'location': 'Goa, India',
    },
    {
      'title': 'Manali Adventure',
      'status': 'Past',
      'dates': 'Feb 10 - Feb 15, 2026',
      'image': 'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
      'location': 'Manali, India',
    },
    {
      'title': 'Jaipur Heritage Tour',
      'status': 'Planned',
      'dates': 'Apr 5 - Apr 10, 2026',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=400',
      'location': 'Jaipur, India',
    },
    {
      'title': 'Kerala Backwaters',
      'status': 'Planned',
      'dates': 'May 1 - May 7, 2026',
      'image': 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=400',
      'location': 'Kerala, India',
    },
    {
      'title': 'Ladakh Bike Trip',
      'status': 'Past',
      'dates': 'Jan 5 - Jan 15, 2026',
      'image': 'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
      'location': 'Ladakh, India',
    },
  ];

  static List<Map<String, dynamic>> friendRequests = [
    {
      'name': 'Neha Gupta',
      'handle': '@nehagupta',
      'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      'mutualFriends': 5,
      'status': 'pending',
    },
    {
      'name': 'Rohan Mehta',
      'handle': '@rohanmehta',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'mutualFriends': 3,
      'status': 'pending',
    },
    {
      'name': 'Ananya Singh',
      'handle': '@ananyasingh',
      'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      'mutualFriends': 8,
      'status': 'pending',
    },
  ];

  static List<Map<String, dynamic>> tripPackages = [
    {
      'id': 'darjeeling-6day',
      'title': '6-Day Darjeeling: Tea Gardens, Views & Himalayan Charm',
      'subtitle': 'Queen of the Hills',
      'image': 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?w=800',
      'price': 24999,
      'duration': '6 Days / 5 Nights',
      'rating': 4.8,
      'reviews': 234,
      'groupSize': '2-12',
      'difficulty': 'Easy',
      'highlights': [
        'Tiger Hill Sunrise',
        'Batasia Loop & War Memorial',
        'Happy Valley Tea Estate',
        'Darjeeling Himalayan Railway',
        'Peace Pagoda',
        'Himalayan Mountaineering Institute',
      ],
      'itinerary': [
        {
          'day': 1,
          'title': 'Arrival in Darjeeling',
          'description': 'Arrive at NJP/Bagdogra. Transfer to Darjeeling. Evening Mall Road walk.',
          'meals': ['Dinner'],
        },
        {
          'day': 2,
          'title': 'Tiger Hill & Local Sightseeing',
          'description': 'Early morning Tiger Hill sunrise. Visit Batasia Loop, Peace Pagoda, Japanese Temple.',
          'meals': ['Breakfast', 'Dinner'],
        },
        {
          'day': 3,
          'title': 'Tea Gardens & Heritage',
          'description': 'Visit Happy Valley Tea Estate. Explore HMI & Zoo. Ride the Toy Train.',
          'meals': ['Breakfast', 'Dinner'],
        },
        {
          'day': 4,
          'title': 'Mirik Excursion',
          'description': 'Day trip to Mirik Lake. Visit Pashupati Market (Nepal border). Boating.',
          'meals': ['Breakfast', 'Lunch', 'Dinner'],
        },
        {
          'day': 5,
          'title': 'Rock Garden & Exploration',
          'description': 'Visit Rock Garden, Ganga Maya Park. Free time for shopping.',
          'meals': ['Breakfast', 'Dinner'],
        },
        {
          'day': 6,
          'title': 'Departure',
          'description': 'Morning at leisure. Transfer to NJP/Bagdogra for departure.',
          'meals': ['Breakfast'],
        },
      ],
      'inclusions': [
        '5 Nights accommodation in 3-star hotel',
        'Daily breakfast as per itinerary',
        'All transfers by private vehicle',
        'Sightseeing as per itinerary',
        'Driver allowance & parking',
      ],
      'exclusions': [
        'Airfare/Train fare',
        'Personal expenses',
        'Camera fees at monuments',
        'Travel insurance',
        'Anything not mentioned in inclusions',
      ],
    },
    {
      'id': 'kerala-7day',
      'title': '7-Day Kerala: Backwaters, Hills & Beaches',
      'subtitle': 'God\'s Own Country',
      'image': 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800',
      'price': 32999,
      'duration': '7 Days / 6 Nights',
      'rating': 4.9,
      'reviews': 456,
      'groupSize': '2-15',
      'difficulty': 'Easy',
      'highlights': [
        'Munnar Tea Plantations',
        'Alleppey Houseboat',
        'Kovalam Beach',
        'Periyar Wildlife Sanctuary',
        'Kathakali Performance',
        'Spice Garden Tour',
      ],
      'itinerary': [
        {'day': 1, 'title': 'Arrival Kochi', 'description': 'Arrive at Kochi. Fort Kochi exploration.', 'meals': ['Dinner']},
        {'day': 2, 'title': 'Kochi to Munnar', 'description': 'Drive to Munnar. Visit spice plantations en route.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 3, 'title': 'Munnar Exploration', 'description': 'Tea Museum, Eravikulam National Park, Mattupetty Dam.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 4, 'title': 'Munnar to Thekkady', 'description': 'Drive to Thekkady. Periyar boat ride.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 5, 'title': 'Thekkady to Alleppey', 'description': 'Drive to Alleppey. Board houseboat.', 'meals': ['Breakfast', 'Lunch', 'Dinner']},
        {'day': 6, 'title': 'Alleppey to Kovalam', 'description': 'Drive to Kovalam. Beach time.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 7, 'title': 'Departure', 'description': 'Transfer to Trivandrum airport.', 'meals': ['Breakfast']},
      ],
      'inclusions': ['6 Nights accommodation', 'All meals on houseboat', 'AC vehicle for transfers', 'Sightseeing'],
      'exclusions': ['Airfare', 'Lunch & dinner (except houseboat)', 'Entry fees', 'Personal expenses'],
    },
    {
      'id': 'rajasthan-8day',
      'title': '8-Day Rajasthan: Royal Palaces & Desert Safari',
      'subtitle': 'Land of Kings',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=800',
      'price': 38999,
      'duration': '8 Days / 7 Nights',
      'rating': 4.7,
      'reviews': 312,
      'groupSize': '2-20',
      'difficulty': 'Moderate',
      'highlights': [
        'Jaipur City Palace',
        'Jaisalmer Desert Safari',
        'Udaipur Lake Palace',
        'Jodhpur Mehrangarh Fort',
        'Pushkar Camel Fair',
        'Traditional Rajasthani Cuisine',
      ],
      'itinerary': [
        {'day': 1, 'title': 'Arrival Jaipur', 'description': 'Arrive in Jaipur. Evening visit to Chokhi Dhani.', 'meals': ['Dinner']},
        {'day': 2, 'title': 'Jaipur Sightseeing', 'description': 'Amber Fort, City Palace, Hawa Mahal, Jantar Mantar.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 3, 'title': 'Jaipur to Jodhpur', 'description': 'Drive to Jodhpur. Visit Mehrangarh Fort.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 4, 'title': 'Jodhpur to Jaisalmer', 'description': 'Drive to Jaisalmer. Evening at Gadisar Lake.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 5, 'title': 'Jaisalmer Desert Safari', 'description': 'Sam Sand Dunes. Camel safari & cultural program.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 6, 'title': 'Jaisalmer to Udaipur', 'description': 'Drive to Udaipur via Ranakpur Jain Temples.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 7, 'title': 'Udaipur Exploration', 'description': 'City Palace, Lake Pichola boat ride, Jag Mandir.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 8, 'title': 'Departure', 'description': 'Transfer to airport/station.', 'meals': ['Breakfast']},
      ],
      'inclusions': ['7 Nights in heritage hotels', 'Daily breakfast & dinner', 'Desert safari with dinner', 'AC vehicle'],
      'exclusions': ['Airfare', 'Lunch', 'Camera fees', 'Personal expenses'],
    },
    {
      'id': 'ladakh-10day',
      'title': '10-Day Ladakh: High Altitude Adventure',
      'subtitle': 'Land of High Passes',
      'image': 'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=800',
      'price': 54999,
      'duration': '10 Days / 9 Nights',
      'rating': 4.9,
      'reviews': 189,
      'groupSize': '4-12',
      'difficulty': 'Challenging',
      'highlights': [
        'Pangong Lake',
        'Khardung La Pass',
        'Nubra Valley',
        'Magnetic Hill',
        'Monastery Visits',
        'Bike Trip Option',
      ],
      'itinerary': [
        {'day': 1, 'title': 'Arrival Leh', 'description': 'Arrive in Leh. Acclimatization day.', 'meals': ['Dinner']},
        {'day': 2, 'title': 'Leh Local', 'description': 'Leh Palace, Shanti Stupa, Leh Market.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 3, 'title': 'Leh to Nubra Valley', 'description': 'Drive via Khardung La (18,380 ft).', 'meals': ['Breakfast', 'Dinner']},
        {'day': 4, 'title': 'Nubra Valley', 'description': 'Diskit Monastery, Hunder sand dunes, camel ride.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 5, 'title': 'Nubra to Pangong', 'description': 'Drive to Pangong Lake via Shyok Valley.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 6, 'title': 'Pangong to Leh', 'description': 'Sunrise at Pangong. Return via Chang La.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 7, 'title': 'Leh to Alchi', 'description': 'Visit Magnetic Hill, Gurudwara, Alchi Monastery.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 8, 'title': 'Alchi to Lamayuru', 'description': 'Moonland landscape, Lamayuru Monastery.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 9, 'title': 'Lamayuru to Leh', 'description': 'Return to Leh. Free time for shopping.', 'meals': ['Breakfast', 'Dinner']},
        {'day': 10, 'title': 'Departure', 'description': 'Transfer to airport.', 'meals': ['Breakfast']},
      ],
      'inclusions': ['9 Nights accommodation', 'Breakfast & dinner', 'Oxygen cylinder', 'Inner line permits'],
      'exclusions': ['Airfare', 'Lunch', 'Bike rental', 'Personal expenses'],
    },
  ];

  static List<Map<String, dynamic>> trendingPosts = [
    {
      'id': 'post1',
      'author': 'Priya Patel',
      'handle': '@priyapatel',
      'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      'content': 'Just completed the 6-Day Darjeeling itinerary! The sunrise at Tiger Hill was absolutely magical. The tea gardens are a must-visit! 🍵⛰️ #Darjeeling #TravelIndia',
      'images': [
        'https://images.unsplash.com/photo-1544735716-392fe2489ffa?w=400',
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
      ],
      'likes': 456,
      'comments': 67,
      'shares': 23,
      'isLiked': false,
      'isBookmarked': false,
      'time': '2h ago',
      'tripTag': 'Darjeeling',
      'commentList': [
        {'author': 'Amit Kumar', 'text': 'Looks amazing! How was the toy train ride?', 'time': '1h ago'},
        {'author': 'Sneha Reddy', 'text': 'Adding this to my bucket list! 🙌', 'time': '45m ago'},
      ],
    },
    {
      'id': 'post2',
      'author': 'Vikram Singh',
      'handle': '@vikramsingh',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'content': 'Road trip to Ladakh was life-changing! Passed through Khardung La at 18,380 ft. The views from Pangong Lake are unreal! 🏍️🏔️ #Ladakh #RoadTrip',
      'images': [
        'https://images.unsplash.com/photo-1597074866923-dc0589150358?w=400',
      ],
      'likes': 789,
      'comments': 134,
      'shares': 56,
      'isLiked': true,
      'isBookmarked': false,
      'time': '5h ago',
      'tripTag': 'Ladakh',
      'commentList': [
        {'author': 'Rahul Sharma', 'text': 'Bro, which bike did you rent?', 'time': '4h ago'},
        {'author': 'Neha Gupta', 'text': 'Pangong is on my list! Which month did you go?', 'time': '3h ago'},
      ],
    },
    {
      'id': 'post3',
      'author': 'Ananya Singh',
      'handle': '@ananyasingh',
      'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      'content': 'Kerala backwaters are pure bliss! 🌴 The houseboat experience was unforgettable. God\'s Own Country indeed! #Kerala #Backwaters',
      'images': [
        'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=400',
      ],
      'likes': 345,
      'comments': 45,
      'shares': 18,
      'isLiked': false,
      'isBookmarked': true,
      'time': '8h ago',
      'tripTag': 'Kerala',
      'commentList': [
        {'author': 'Priya Patel', 'text': 'The houseboats are the best! Did you try the local fish curry?', 'time': '7h ago'},
      ],
    },
  ];

  static List<Map<String, dynamic>> faceConnectUsers = [
    {
      'name': 'Priya Patel',
      'handle': '@priyapatel',
      'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      'bio': 'Mountain lover | Solo traveler | Photographer',
      'trips': 18,
      'followers': 1234,
      'isFollowing': false,
      'isOnline': true,
      'lastActive': 'Now',
    },
    {
      'name': 'Vikram Singh',
      'handle': '@vikramsingh',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'bio': 'Biker | Adventure seeker | Ladakh enthusiast',
      'trips': 31,
      'followers': 2456,
      'isFollowing': true,
      'isOnline': true,
      'lastActive': 'Now',
    },
    {
      'name': 'Ananya Singh',
      'handle': '@ananyasingh',
      'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      'bio': 'Backpacker | Foodie | Culture explorer',
      'trips': 24,
      'followers': 3567,
      'isFollowing': false,
      'isOnline': false,
      'lastActive': '2h ago',
    },
    {
      'name': 'Rohan Mehta',
      'handle': '@rohanmehta',
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      'bio': 'Beach lover | Diver | Sunset chaser',
      'trips': 15,
      'followers': 890,
      'isFollowing': false,
      'isOnline': true,
      'lastActive': 'Now',
    },
    {
      'name': 'Sneha Reddy',
      'handle': '@snehareddy',
      'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
      'bio': 'Heritage lover | History buff | Art enthusiast',
      'trips': 22,
      'followers': 1678,
      'isFollowing': true,
      'isOnline': false,
      'lastActive': '1h ago',
    },
  ];

  static List<Map<String, dynamic>> heritageSites = [
    {
      'name': 'Taj Mahal',
      'location': 'Agra, Uttar Pradesh',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=400',
      'description': 'One of the Seven Wonders of the World, built by Mughal Emperor Shah Jahan.',
      'timing': '6:00 AM - 6:30 PM',
      'entryFee': 1100,
      'rating': 4.9,
      'bestTime': 'Oct - Mar',
    },
    {
      'name': 'Mysore Palace',
      'location': 'Mysore, Karnataka',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1600100397608-e1f1f5a0c8a3?w=400',
      'description': 'Historical palace and the royal residence of the Wadiyar dynasty.',
      'timing': '10:00 AM - 5:30 PM',
      'entryFee': 70,
      'rating': 4.8,
      'bestTime': 'Sep - Feb',
    },
    {
      'name': 'Hawa Mahal',
      'location': 'Jaipur, Rajasthan',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=400',
      'description': 'Palace of Winds with 953 windows, built for royal women.',
      'timing': '9:00 AM - 5:00 PM',
      'entryFee': 50,
      'rating': 4.7,
      'bestTime': 'Oct - Mar',
    },
    {
      'name': 'Golden Temple',
      'location': 'Amritsar, Punjab',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1514222134-b57cbb8ce073?w=400',
      'description': 'Holiest Sikh shrine, known for its golden dome and community kitchen.',
      'timing': '4:00 AM - 10:00 PM',
      'entryFee': 0,
      'rating': 4.9,
      'bestTime': 'Nov - Mar',
    },
    {
      'name': 'Tirupati Balaji',
      'location': 'Tirupati, Andhra Pradesh',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=400',
      'description': 'One of the richest and most visited temples in the world.',
      'timing': '3:00 AM - 12:00 AM',
      'entryFee': 300,
      'rating': 4.8,
      'bestTime': 'Sep - Feb',
    },
    {
      'name': 'Meenakshi Temple',
      'location': 'Madurai, Tamil Nadu',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1584464491033-06628f3a6b7b?w=400',
      'description': 'Ancient Hindu temple with stunning Dravidian architecture.',
      'timing': '5:00 AM - 12:30 PM, 4:00 PM - 10:00 PM',
      'entryFee': 50,
      'rating': 4.7,
      'bestTime': 'Oct - Mar',
    },
    {
      'name': 'Khajuraho Temples',
      'location': 'Khajuraho, Madhya Pradesh',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1590766940554-634d89247b81?w=400',
      'description': 'UNESCO World Heritage temples known for stunning sculptures.',
      'timing': '6:00 AM - 6:00 PM',
      'entryFee': 40,
      'rating': 4.6,
      'bestTime': 'Oct - Feb',
    },
    {
      'name': 'Qutub Minar',
      'location': 'New Delhi',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=400',
      'description': 'Tallest brick minaret in the world, UNESCO World Heritage Site.',
      'timing': '7:00 AM - 5:00 PM',
      'entryFee': 600,
      'rating': 4.5,
      'bestTime': 'Oct - Mar',
    },
    {
      'name': 'Konark Sun Temple',
      'location': 'Konark, Odisha',
      'type': 'Temple',
      'image': 'https://images.unsplash.com/photo-1621427528262-83ca8ce01e70?w=400',
      'description': '13th-century temple designed as a massive chariot with intricate carvings.',
      'timing': '6:00 AM - 8:00 PM',
      'entryFee': 40,
      'rating': 4.7,
      'bestTime': 'Oct - Mar',
    },
    {
      'name': 'Amber Fort',
      'location': 'Jaipur, Rajasthan',
      'type': 'Kingdom',
      'image': 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=400',
      'description': 'Majestic fort showcasing Rajput architecture with stunning views.',
      'timing': '8:00 AM - 5:30 PM',
      'entryFee': 200,
      'rating': 4.8,
      'bestTime': 'Oct - Mar',
    },
  ];
}
