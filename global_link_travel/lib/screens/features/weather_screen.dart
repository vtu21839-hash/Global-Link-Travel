import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _selectedCity = 'Goa';

  final Map<String, Map<String, dynamic>> _weatherData = {
    'Goa': {
      'temp': 32,
      'condition': 'Sunny',
      'humidity': 65,
      'wind': 12,
      'uv': 8,
      'icon': Icons.wb_sunny,
      'forecast': [
        {'day': 'Mon', 'temp': 32, 'icon': Icons.wb_sunny},
        {'day': 'Tue', 'temp': 30, 'icon': Icons.cloud},
        {'day': 'Wed', 'temp': 29, 'icon': Icons.thunderstorm},
        {'day': 'Thu', 'temp': 31, 'icon': Icons.wb_sunny},
        {'day': 'Fri', 'temp': 33, 'icon': Icons.wb_sunny},
        {'day': 'Sat', 'temp': 32, 'icon': Icons.cloud},
        {'day': 'Sun', 'temp': 30, 'icon': Icons.wb_sunny},
      ],
      'bestTime': 'Oct - Mar',
      'tip': 'Perfect beach weather! Don\'t forget sunscreen.',
    },
    'Manali': {
      'temp': 8,
      'condition': 'Snowy',
      'humidity': 80,
      'wind': 18,
      'uv': 3,
      'icon': Icons.ac_unit,
      'forecast': [
        {'day': 'Mon', 'temp': 8, 'icon': Icons.ac_unit},
        {'day': 'Tue', 'temp': 6, 'icon': Icons.ac_unit},
        {'day': 'Wed', 'temp': 5, 'icon': Icons.ac_unit},
        {'day': 'Thu', 'temp': 7, 'icon': Icons.cloud},
        {'day': 'Fri', 'temp': 9, 'icon': Icons.wb_sunny},
        {'day': 'Sat', 'temp': 10, 'icon': Icons.wb_sunny},
        {'day': 'Sun', 'temp': 8, 'icon': Icons.cloud},
      ],
      'bestTime': 'Mar - Jun, Dec - Feb',
      'tip': 'Carry warm clothes. Snow expected this week!',
    },
    'Jaipur': {
      'temp': 38,
      'condition': 'Hot',
      'humidity': 25,
      'wind': 8,
      'uv': 10,
      'icon': Icons.wb_sunny,
      'forecast': [
        {'day': 'Mon', 'temp': 38, 'icon': Icons.wb_sunny},
        {'day': 'Tue', 'temp': 39, 'icon': Icons.wb_sunny},
        {'day': 'Wed', 'temp': 40, 'icon': Icons.wb_sunny},
        {'day': 'Thu', 'temp': 38, 'icon': Icons.wb_sunny},
        {'day': 'Fri', 'temp': 37, 'icon': Icons.cloud},
        {'day': 'Sat', 'temp': 36, 'icon': Icons.thunderstorm},
        {'day': 'Sun', 'temp': 35, 'icon': Icons.cloud},
      ],
      'bestTime': 'Oct - Mar',
      'tip': 'Stay hydrated. Avoid outdoor activities 12-4 PM.',
    },
    'Kerala': {
      'temp': 28,
      'condition': 'Rainy',
      'humidity': 90,
      'wind': 15,
      'uv': 4,
      'icon': Icons.water_drop,
      'forecast': [
        {'day': 'Mon', 'temp': 28, 'icon': Icons.water_drop},
        {'day': 'Tue', 'temp': 27, 'icon': Icons.thunderstorm},
        {'day': 'Wed', 'temp': 28, 'icon': Icons.water_drop},
        {'day': 'Thu', 'temp': 29, 'icon': Icons.cloud},
        {'day': 'Fri', 'temp': 30, 'icon': Icons.wb_sunny},
        {'day': 'Sat', 'temp': 29, 'icon': Icons.cloud},
        {'day': 'Sun', 'temp': 28, 'icon': Icons.water_drop},
      ],
      'bestTime': 'Sep - Mar',
      'tip': 'Monsoon season! Carry umbrella and rain gear.',
    },
  };

  @override
  Widget build(BuildContext context) {
    final weather = _weatherData[_selectedCity]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCitySelector().animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 20),
            _buildMainWeather(weather).animate().fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 20),
            _buildWeatherDetails(weather).animate().fadeIn(delay: 150.ms, duration: 400.ms),
            const SizedBox(height: 20),
            _buildForecast(weather).animate().fadeIn(delay: 200.ms, duration: 400.ms),
            const SizedBox(height: 20),
            _buildTravelTip(weather).animate().fadeIn(delay: 250.ms, duration: 400.ms),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCitySelector() {
    return SizedBox(
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _weatherData.keys.map((city) {
          final isSelected = _selectedCity == city;
          return GestureDetector(
            onTap: () => setState(() => _selectedCity = city),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
              ),
              child: Text(
                city,
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : AppColors.textMedium,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMainWeather(Map<String, dynamic> weather) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_selectedCity, India',
                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    weather['condition'] as String,
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
              Icon(weather['icon'] as IconData, color: Colors.white, size: 50),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${weather['temp']}',
                style: GoogleFonts.poppins(fontSize: 72, fontWeight: FontWeight.w300, color: Colors.white, height: 1),
              ),
              Text('°C', style: GoogleFonts.poppins(fontSize: 24, color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Best time to visit: ${weather['bestTime']}',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(Map<String, dynamic> weather) {
    return Row(
      children: [
        _buildDetailCard(Icons.water_drop, '${weather['humidity']}%', 'Humidity', AppColors.teal),
        const SizedBox(width: 12),
        _buildDetailCard(Icons.air, '${weather['wind']} km/h', 'Wind', AppColors.primary),
        const SizedBox(width: 12),
        _buildDetailCard(Icons.wb_sunny, '${weather['uv']}', 'UV Index', AppColors.warning),
      ],
    );
  }

  Widget _buildDetailCard(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10)],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMedium)),
          ],
        ),
      ),
    );
  }

  Widget _buildForecast(Map<String, dynamic> weather) {
    final forecast = weather['forecast'] as List;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('7-Day Forecast', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          ...forecast.map((day) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(day['day'] as String, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium)),
                    ),
                    Icon(day['icon'] as IconData, color: AppColors.primary, size: 24),
                    Text('${day['temp']}°C', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTravelTip(Map<String, dynamic> weather) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.tips_and_updates, color: AppColors.success, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Travel Tip', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.success)),
                Text(weather['tip'] as String, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
