import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'assets/images/help.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          const Spacer(),
                          const Text(
                            'Help & Support',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Contact Us',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Our helpline is always open to receive any inquiry or feedback...',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      _buildContactInfoCard(
                        icon: Icons.phone,
                        title: 'UAN',
                        details: '021-111-111-160\nToll Free: 0800-00100',
                      ),
                      const SizedBox(height: 12),
                      _buildContactInfoCard(
                        icon: Icons.email,
                        title: 'Email',
                        details: 'info@newmetrocity.com.pk',
                      ),
                      const SizedBox(height: 12),
                      _buildContactInfoCard(
                        icon: Icons.location_on,
                        title: 'Address',
                        details: '56-D Broadway Commercial DHA Phase 8 Lahore',
                      ),
                      const SizedBox(height: 12),
                      _buildContactInfoCard(
                        icon: Icons.access_time,
                        title: 'Timing',
                        details: 'Mon-Fri: 10 AM - 7 PM\nSat: 10 AM - 5 PM',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom Section with Form
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'assets/images/support.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(hint: "BSM DEVELOPERS"),
                      const SizedBox(height: 12),
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(hint: "newmetrocity@example.com"),
                      const SizedBox(height: 12),
                      const Text(
                        'Phone',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(hint: "03212345678"),
                      const SizedBox(height: 12),
                      const Text(
                        'Message',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(
                        hint: "Type your message...",
                        maxLines: 4,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          // Handle send
                        },
                        child: const Text("Send",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoCard({
    required IconData icon,
    required String title,
    required String details,
  }) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.appColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.appColor),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.appColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}