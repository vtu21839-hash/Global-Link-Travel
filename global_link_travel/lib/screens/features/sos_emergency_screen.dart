import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/constants.dart';

class SOSEmergencyScreen extends StatefulWidget {
  const SOSEmergencyScreen({super.key});

  @override
  State<SOSEmergencyScreen> createState() => _SOSEmergencyScreenState();
}

class _SOSEmergencyScreenState extends State<SOSEmergencyScreen> with SingleTickerProviderStateMixin {
  bool _sosActive = false;
  bool _locationShared = false;
  late AnimationController _pulseController;

  final List<Map<String, dynamic>> _emergencyContacts = [
    {'name': 'Police', 'number': '100', 'icon': Icons.local_police, 'color': Color(0xFF1B4D8E)},
    {'name': 'Ambulance', 'number': '108', 'icon': Icons.medical_services, 'color': Color(0xFFE74C3C)},
    {'name': 'Fire Brigade', 'number': '101', 'icon': Icons.local_fire_department, 'color': Color(0xFFFF6B35)},
    {'name': 'Women Helpline', 'number': '1091', 'icon': Icons.female, 'color': Color(0xFFE91E63)},
    {'name': 'Disaster Management', 'number': '108', 'icon': Icons.warning, 'color': Color(0xFFFFC107)},
    {'name': 'Tourist Helpline', 'number': '1363', 'icon': Icons.travel_explore, 'color': Color(0xFF00BCD4)},
    {'name': 'Road Accident', 'number': '1073', 'icon': Icons.car_crash, 'color': Color(0xFF795548)},
    {'name': 'Child Helpline', 'number': '1098', 'icon': Icons.child_care, 'color': Color(0xFF9C27B0)},
  ];

  final List<Map<String, dynamic>> _myEmergencyContacts = [
    {'name': 'Mom', 'number': '+91 98765 43210', 'relation': 'Family', 'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100'},
    {'name': 'Dad', 'number': '+91 98765 43211', 'relation': 'Family', 'avatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100'},
    {'name': 'Priya Patel', 'number': '+91 87654 32109', 'relation': 'Travel Buddy', 'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100'},
  ];

  final Map<String, dynamic> _medicalInfo = {
    'bloodGroup': 'O+',
    'allergies': 'None',
    'medications': 'None',
    'emergencyContact': '+91 98765 43210',
    'insuranceProvider': 'Star Health',
    'policyNumber': 'SH123456789',
  };

  final List<Map<String, dynamic>> _nearbyPlaces = [
    {'name': 'Manipal Hospital', 'type': 'Hospital', 'distance': '2.3 km', 'icon': Icons.local_hospital, 'address': 'Dona Paula, Goa'},
    {'name': 'Goa Medical College', 'type': 'Hospital', 'distance': '4.1 km', 'icon': Icons.local_hospital, 'address': 'Bambolim, Goa'},
    {'name': 'Panjim Police Station', 'type': 'Police', 'distance': '1.8 km', 'icon': Icons.local_police, 'address': 'Panjim, Goa'},
    {'name': 'Fire Station Panjim', 'type': 'Fire', 'distance': '3.2 km', 'icon': Icons.local_fire_department, 'address': 'Panjim, Goa'},
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _triggerSOS() {
    setState(() {
      _sosActive = !_sosActive;
    });
    if (_sosActive) {
      _pulseController.repeat(reverse: true);
      _showSOSConfirmation();
    } else {
      _pulseController.reset();
    }
  }

  void _showSOSConfirmation() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.emergency, color: AppColors.error, size: 36),
            ),
            const SizedBox(height: 16),
            Text(
              'SOS Alert Sent!',
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 8),
            Text(
              'Your emergency contacts have been notified with your current location.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium),
            ),
            const SizedBox(height: 20),
            _buildConfirmationItem(Icons.location_on, 'Location shared with all contacts'),
            _buildConfirmationItem(Icons.call, 'Auto-calling emergency contact in 10 seconds'),
            _buildConfirmationItem(Icons.message, 'SMS sent to 3 emergency contacts'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => _sosActive = false);
                      _pulseController.reset();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Cancel SOS', style: TextStyle(color: AppColors.error)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Call Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.success, size: 20),
          const SizedBox(width: 10),
          Text(text, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMedium)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Emergency', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () => _showMedicalInfoSheet(),
            icon: const Icon(Icons.medical_information),
            tooltip: 'Medical Info',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSOSButton().animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 24),
            _buildEmergencyNumbers().animate().fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 24),
            _buildMyContacts().animate().fadeIn(delay: 150.ms, duration: 400.ms),
            const SizedBox(height: 24),
            _buildNearbyPlaces().animate().fadeIn(delay: 200.ms, duration: 400.ms),
            const SizedBox(height: 24),
            _buildMedicalInfoCard().animate().fadeIn(delay: 250.ms, duration: 400.ms),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: _sosActive
            ? LinearGradient(colors: [AppColors.error, AppColors.error.withOpacity(0.7)])
            : LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientEnd]),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (_sosActive ? AppColors.error : AppColors.primary).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
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
                    _sosActive ? 'SOS ACTIVE' : 'Emergency SOS',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _sosActive ? 'Help is on the way' : 'Press and hold for 3 seconds',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
              if (_sosActive)
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(_pulseController.value),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onLongPress: _triggerSOS,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Press and hold for 3 seconds to activate SOS'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: _sosActive ? Colors.white : Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: _sosActive
                    ? [BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 30, spreadRadius: 10)]
                    : [],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _sosActive ? Icons.emergency : Icons.sos,
                      color: _sosActive ? AppColors.error : Colors.white,
                      size: 40,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SOS',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _sosActive ? AppColors.error : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildQuickAction(Icons.share_location, 'Share Location', () {
                setState(() => _locationShared = !_locationShared);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_locationShared ? 'Location shared with emergency contacts' : 'Location sharing stopped'),
                    backgroundColor: _locationShared ? AppColors.success : AppColors.textMedium,
                  ),
                );
              }),
              const SizedBox(width: 24),
              _buildQuickAction(Icons.call, 'Call 100', () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Calling Police - 100'),
                    backgroundColor: AppColors.error,
                    action: SnackBarAction(label: 'Cancel', textColor: Colors.white, onPressed: () {}),
                  ),
                );
              }),
              const SizedBox(width: 24),
              _buildQuickAction(Icons.message, 'Send Alert', () {
                _triggerSOS();
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label, style: GoogleFonts.poppins(fontSize: 10, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildEmergencyNumbers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Emergency Numbers', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemCount: _emergencyContacts.length,
          itemBuilder: (context, index) {
            final contact = _emergencyContacts[index];
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Calling ${contact['name']} - ${contact['number']}'),
                    backgroundColor: contact['color'] as Color,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: (contact['color'] as Color).withOpacity(0.1), blurRadius: 10)],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (contact['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(contact['icon'] as IconData, color: contact['color'] as Color, size: 22),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      contact['number'] as String,
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark),
                    ),
                    Text(
                      contact['name'] as String,
                      style: GoogleFonts.poppins(fontSize: 9, color: AppColors.textMedium),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMyContacts() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Emergency Contacts', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: Text('+ Add', style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ..._myEmergencyContacts.map((contact) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(contact['avatar'] as String),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(contact['name'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                          Text(contact['number'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.call, color: AppColors.success, size: 20),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.message, color: AppColors.primary, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildNearbyPlaces() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nearby Emergency Services', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ..._nearbyPlaces.map((place) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(place['icon'] as IconData, color: AppColors.error, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(place['name'] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                        Text(place['address'] as String, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(place['distance'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('Navigate', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.primary)),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildMedicalInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
        border: Border.all(color: AppColors.error.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medical_information, color: AppColors.error, size: 22),
              const SizedBox(width: 10),
              Text('Medical Information', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(
                onPressed: () => _showMedicalInfoSheet(),
                child: Text('Edit', style: GoogleFonts.poppins(color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildMedicalItem('Blood Group', _medicalInfo['bloodGroup'] as String, Icons.bloodtype),
              const SizedBox(width: 16),
              _buildMedicalItem('Allergies', _medicalInfo['allergies'] as String, Icons.dangerous),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildMedicalItem('Insurance', _medicalInfo['insuranceProvider'] as String, Icons.shield),
              const SizedBox(width: 16),
              _buildMedicalItem('Policy #', _medicalInfo['policyNumber'] as String, Icons.description),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalItem(String label, String value, IconData icon) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: AppColors.textLight, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight)),
              Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  void _showMedicalInfoSheet() {
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
            Text('Medical Information', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _medicalInfo['bloodGroup'] as String),
              decoration: InputDecoration(labelText: 'Blood Group', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: _medicalInfo['allergies'] as String),
              decoration: InputDecoration(labelText: 'Allergies', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: _medicalInfo['medications'] as String),
              decoration: InputDecoration(labelText: 'Current Medications', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: _medicalInfo['insuranceProvider'] as String),
              decoration: InputDecoration(labelText: 'Insurance Provider', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: _medicalInfo['policyNumber'] as String),
              decoration: InputDecoration(labelText: 'Policy Number', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                child: const Text('Save Medical Info'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
