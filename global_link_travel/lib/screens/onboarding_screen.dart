import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/constants.dart';
import 'auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Discover Places',
      'description': 'Explore amazing destinations around the world with our curated travel packages.',
      'icon': Icons.explore,
      'color': Color(0xFF1B4D8E),
    },
    {
      'title': 'Book Your Trip',
      'description': 'Easy and secure booking process with flexible payment options.',
      'icon': Icons.book_online,
      'color': Color(0xFF2E86AB),
    },
    {
      'title': 'Travel Happy',
      'description': 'Enjoy your journey with 24/7 support and unforgettable experiences.',
      'icon': Icons.emoji_emotions,
      'color': Color(0xFFFF6B35),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: (page['color'] as Color).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            page['icon'] as IconData,
                            size: 100,
                            color: page['color'] as Color,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          page['title'] as String,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['description'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textMedium,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: _pages.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 3,
                activeDotColor: AppColors.primary,
                dotColor: AppColors.border,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_currentPage != _pages.length - 1)
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: Text(
                  'Skip',
                  style: TextStyle(color: AppColors.textLight, fontSize: 16),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
