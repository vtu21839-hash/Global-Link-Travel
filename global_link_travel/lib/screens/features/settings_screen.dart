import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _locationSharing = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'INR (₹)';

  final List<String> _languages = ['English', 'Hindi', 'Spanish', 'French', 'German', 'Japanese'];
  final List<String> _currencies = ['INR (₹)', 'USD (\$)', 'EUR (€)', 'GBP (£)', 'JPY (¥)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
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
            _buildSection('Account', [
              _buildListTile(Icons.person_outline, 'Edit Profile', 'Update your profile info', () => _showEditProfileSheet()),
              _buildListTile(Icons.lock_outline, 'Change Password', 'Update your password', () => _showChangePasswordSheet()),
              _buildListTile(Icons.email_outlined, 'Email Settings', 'rahul.sharma@email.com', () => _showEmailSheet()),
              _buildListTile(Icons.phone_outlined, 'Phone Number', '+91 98765 43210', () => _showPhoneSheet()),
            ]),
            const SizedBox(height: 20),
            _buildSection('Preferences', [
              _buildSwitchTile(Icons.notifications_outlined, 'Notifications', 'Get notified about trips & friends', _notifications, (val) {
                setState(() => _notifications = val);
                _showSnackBar(val ? 'Notifications enabled' : 'Notifications disabled');
              }),
              _buildSwitchTile(Icons.dark_mode_outlined, 'Dark Mode', 'Switch to dark theme', _darkMode, (val) {
                setState(() => _darkMode = val);
                _showSnackBar(val ? 'Dark mode enabled' : 'Light mode enabled');
              }),
              _buildSwitchTile(Icons.location_on_outlined, 'Location Sharing', 'Share location with friends', _locationSharing, (val) {
                setState(() => _locationSharing = val);
                _showSnackBar(val ? 'Location sharing on' : 'Location sharing off');
              }),
              _buildListTile(Icons.language, 'Language', _selectedLanguage, () => _showLanguageSheet()),
              _buildListTile(Icons.currency_rupee, 'Currency', _selectedCurrency, () => _showCurrencySheet()),
            ]),
            const SizedBox(height: 20),
            _buildSection('Privacy & Security', [
              _buildListTile(Icons.privacy_tip_outlined, 'Privacy Policy', 'Read our privacy policy', () => _showInfoSheet('Privacy Policy', _privacyPolicy)),
              _buildListTile(Icons.description_outlined, 'Terms of Service', 'Read terms & conditions', () => _showInfoSheet('Terms of Service', _termsOfService)),
              _buildListTile(Icons.shield_outlined, 'Data Protection', 'How we protect your data', () => _showInfoSheet('Data Protection', _dataProtection)),
              _buildListTile(Icons.block, 'Blocked Users', '2 users blocked', () => _showBlockedUsersSheet()),
            ]),
            const SizedBox(height: 20),
            _buildSection('Support', [
              _buildListTile(Icons.help_outline, 'Help Center', 'FAQs & guides', () => _showHelpCenterSheet()),
              _buildListTile(Icons.feedback_outlined, 'Send Feedback', 'Share your thoughts', () => _showFeedbackSheet()),
              _buildListTile(Icons.bug_report_outlined, 'Report a Bug', 'Help us improve', () => _showReportBugSheet()),
              _buildListTile(Icons.info_outline, 'About', 'App information', () => _showAboutSheet()),
            ]),
            const SizedBox(height: 20),
            _buildSection('Danger Zone', [
              _buildListTile(Icons.delete_forever, 'Delete Account', 'Permanently delete your account', () => _showDeleteAccountDialog()),
            ]),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(),
                icon: Icon(Icons.logout, color: AppColors.error),
                label: Text(
                  'Sign Out',
                  style: GoogleFonts.poppins(color: AppColors.error, fontWeight: FontWeight.w600, fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text('Global Link Travel © 2026', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textLight)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight)),
      trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textLight, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textLight)),
      trailing: Switch(value: value, onChanged: onChanged, activeColor: AppColors.primary),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.success, duration: const Duration(seconds: 1)),
    );
  }

  // Edit Profile Sheet
  void _showEditProfileSheet() {
    final nameController = TextEditingController(text: 'Rahul Sharma');
    final bioController = TextEditingController(text: 'Wanderlust | Explorer | Adventure Seeker');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Edit Profile', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Stack(
              children: [
                CircleAvatar(radius: 50, backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200')),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            TextField(controller: bioController, maxLines: 3, decoration: InputDecoration(labelText: 'Bio', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: () { Navigator.pop(context); _showSnackBar('Profile updated!'); },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Change Password Sheet
  void _showChangePasswordSheet() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Change Password', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: currentPasswordController, obscureText: true, decoration: InputDecoration(labelText: 'Current Password', prefixIcon: const Icon(Icons.lock), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            TextField(controller: newPasswordController, obscureText: true, decoration: InputDecoration(labelText: 'New Password', prefixIcon: const Icon(Icons.lock_outline), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            TextField(controller: confirmPasswordController, obscureText: true, decoration: InputDecoration(labelText: 'Confirm New Password', prefixIcon: const Icon(Icons.lock_outline), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: () { Navigator.pop(context); _showSnackBar('Password changed successfully!'); },
                child: const Text('Update Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Email Sheet
  void _showEmailSheet() {
    final emailController = TextEditingController(text: 'rahul.sharma@email.com');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Email Settings', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: emailController, keyboardType: TextInputType.emailAddress, decoration: InputDecoration(labelText: 'Email Address', prefixIcon: const Icon(Icons.email), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            Text('A verification email will be sent to your new email address.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: () { Navigator.pop(context); _showSnackBar('Verification email sent!'); },
                child: const Text('Update Email'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Phone Sheet
  void _showPhoneSheet() {
    final phoneController = TextEditingController(text: '+91 98765 43210');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Phone Number', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: phoneController, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'Phone Number', prefixIcon: const Icon(Icons.phone), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            Text('An OTP will be sent to verify your new number.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: () { Navigator.pop(context); _showSnackBar('OTP sent to your phone!'); },
                child: const Text('Send OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Language Selection Sheet
  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Select Language', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._languages.map((lang) => ListTile(
              leading: Icon(_selectedLanguage == lang ? Icons.check_circle : Icons.circle_outlined, color: _selectedLanguage == lang ? AppColors.primary : AppColors.textLight),
              title: Text(lang),
              onTap: () { setState(() => _selectedLanguage = lang); Navigator.pop(context); _showSnackBar('Language set to $lang'); },
            )),
          ],
        ),
      ),
    );
  }

  // Currency Selection Sheet
  void _showCurrencySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Select Currency', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._currencies.map((curr) => ListTile(
              leading: Icon(_selectedCurrency == curr ? Icons.check_circle : Icons.circle_outlined, color: _selectedCurrency == curr ? AppColors.primary : AppColors.textLight),
              title: Text(curr),
              onTap: () { setState(() => _selectedCurrency = curr); Navigator.pop(context); _showSnackBar('Currency set to $curr'); },
            )),
          ],
        ),
      ),
    );
  }

  // Info Sheet (Privacy, Terms, Data Protection)
  void _showInfoSheet(String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text(title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(content, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium, height: 1.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Blocked Users Sheet
  void _showBlockedUsersSheet() {
    final blockedUsers = [
      {'name': 'John Doe', 'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100'},
      {'name': 'Jane Smith', 'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Blocked Users (${blockedUsers.length})', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...blockedUsers.map((user) => ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(user['avatar'] as String)),
              title: Text(user['name'] as String),
              trailing: TextButton(
                onPressed: () { Navigator.pop(context); _showSnackBar('${user['name']} unblocked'); },
                child: Text('Unblock', style: TextStyle(color: AppColors.primary)),
              ),
            )),
          ],
        ),
      ),
    );
  }

  // Help Center Sheet
  void _showHelpCenterSheet() {
    final faqs = [
      {'q': 'How do I book a trip?', 'a': 'Go to Explorer, select a destination, and tap Book Now.'},
      {'q': 'How do I cancel a booking?', 'a': 'Go to My Trips, find your booking, and tap Cancel.'},
      {'q': 'How do I connect with travelers?', 'a': 'Go to Social tab and use Face Connect feature.'},
      {'q': 'How do I earn badges?', 'a': 'Complete trips, share posts, and engage with the community.'},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Help Center', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: faqs.length,
                itemBuilder: (context, index) => ExpansionTile(
                  title: Text(faqs[index]['q']!, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  children: [Padding(padding: const EdgeInsets.all(16), child: Text(faqs[index]['a']!, style: GoogleFonts.poppins(color: AppColors.textMedium)))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Feedback Sheet
  void _showFeedbackSheet() {
    final feedbackController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Send Feedback', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('We\'d love to hear your thoughts!', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium)),
            const SizedBox(height: 16),
            Text('How would you rate your experience?', style: GoogleFonts.poppins(fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => IconButton(
                onPressed: () {},
                icon: Icon(Icons.star, color: AppColors.warning, size: 32),
              )),
            ),
            const SizedBox(height: 12),
            TextField(controller: feedbackController, maxLines: 4, decoration: InputDecoration(labelText: 'Your feedback', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: () { Navigator.pop(context); _showSnackBar('Thank you for your feedback!'); },
                child: const Text('Submit Feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Report Bug Sheet
  void _showReportBugSheet() {
    final bugController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Report a Bug', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Help us improve by reporting issues', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textMedium)),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Bug Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            TextField(controller: bugController, maxLines: 4, decoration: InputDecoration(labelText: 'Describe the bug', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 12),
            OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.image), label: const Text('Add Screenshot')),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: () { Navigator.pop(context); _showSnackBar('Bug report submitted!'); },
                child: const Text('Submit Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // About Sheet
  void _showAboutSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientEnd]), borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.flight_takeoff, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 16),
            Text('Global Link Travel', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Version 1.0.0', style: GoogleFonts.poppins(color: AppColors.textMedium)),
            const SizedBox(height: 16),
            Text('Explore the world with Global Link Travel. Connect with travelers, plan trips, and create unforgettable memories.', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: AppColors.textMedium)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAboutItem(Icons.star, '4.8', 'Rating'),
                _buildAboutItem(Icons.download, '10K+', 'Downloads'),
                _buildAboutItem(Icons.people, '50K+', 'Users'),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMedium)),
      ],
    );
  }

  // Delete Account Dialog
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning, color: AppColors.error),
            const SizedBox(width: 10),
            Text('Delete Account', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text('This action is permanent. All your data will be deleted. Are you sure?', style: GoogleFonts.poppins(color: AppColors.textMedium)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: AppColors.textMedium))),
          ElevatedButton(
            onPressed: () { Navigator.pop(context); _showSnackBar('Account deletion requested'); },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Logout Dialog
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(children: [Icon(Icons.logout, color: AppColors.error), const SizedBox(width: 10), Text('Sign Out', style: GoogleFonts.poppins(fontWeight: FontWeight.bold))]),
        content: Text('Are you sure you want to sign out?', style: GoogleFonts.poppins(color: AppColors.textMedium)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: AppColors.textMedium))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  static const String _privacyPolicy = '''Privacy Policy

At Global Link Travel, we take your privacy seriously. This policy describes what personal information we collect and how we use it.

Information We Collect:
• Name, email, and phone number
• Profile photos
• Trip preferences and booking history
• Location data (when enabled)

How We Use Your Information:
• To provide travel services
• To connect you with other travelers
• To improve our app experience
• To send trip updates and notifications

Your Rights:
• Access your personal data
• Request data deletion
• Opt-out of marketing communications

Contact us at privacy@globallinktravel.com for any questions.''';

  static const String _termsOfService = '''Terms of Service

By using Global Link Travel, you agree to these terms:

1. Account Responsibility
You are responsible for maintaining the security of your account.

2. Acceptable Use
Use the app for lawful purposes only. Do not harass other users.

3. Bookings & Payments
All bookings are subject to availability and cancellation policies.

4. User Content
You retain rights to content you share, but grant us license to display it.

5. Limitation of Liability
We are not liable for travel disruptions or third-party services.

6. Changes to Terms
We may update these terms. Continued use constitutes acceptance.''';

  static const String _dataProtection = '''Data Protection

We implement industry-standard security measures to protect your data:

Security Measures:
• End-to-end encryption for sensitive data
• Secure servers with regular backups
• Two-factor authentication option
• Regular security audits

Data Storage:
• Data stored in encrypted databases
• Automatic data purging after account deletion
• No sharing with third parties without consent

Your Controls:
• Download your data anytime
• Delete specific information
• Control visibility settings
• Manage connected apps''';
}
