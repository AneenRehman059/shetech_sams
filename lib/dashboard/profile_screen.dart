import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washmen/controllers/login_controller.dart';

import '../bottom_app_bar/bottom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  final String title;
  const ProfileScreen({super.key, required this.title});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final loginController = Get.find<LoginController>();
  final Color menuBackgroundColor = const Color(0xFF8A3E59);

  void _showLogoutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logout.png',
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 12),
              const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Are you sure you want to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        Get.back();
                        await loginController.logout();
                      },
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => MainWrapper());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          centerTitle: true,
          title: Column(
            children: const [
              Text(
                'Profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Gwadar Golf City',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 20,
              ),
            )
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              color: Color(0xFF8A2B5B),
              height: 2.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Picture and Info
              Center(
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Manzoor Ahmad',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'manzoor.mfs@gmail.com',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                color: menuBackgroundColor,
                child: Column(
                  children: [
                    _buildMenuTile(
                      onTap: () {},
                      imagePath: 'assets/images/mode.png',
                      title: 'Dark Mode',
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: true,
                          onChanged: (value) {},
                          activeColor: Colors.white,
                        ),
                      ),
                    ),
                    _buildMenuTile(
                      onTap: (){},
                      imagePath: 'assets/images/detail.png',
                      title: 'Personal Details',
                    ),
                    _buildMenuTile(
                      onTap: (){},
                      imagePath: 'assets/images/supp.png',
                      title: 'Help & Support',
                    ),
                    _buildMenuTile(
                      onTap: (){},
                      imagePath: 'assets/images/feedback.png',
                      title: 'Feedback',
                    ),
                    _buildMenuTile(
                      onTap: (){},
                      imagePath: 'assets/images/faqs.png',
                      title: 'FAQs',
                    ),
                    _buildMenuTile(
                      onTap: (){},
                      imagePath: 'assets/images/password.png',
                      title: 'Change Password',
                    ),
                    _buildMenuTile(
                      onTap: (){},
                      imagePath: 'assets/images/biometric.png',
                      title: 'Enable Biometric Login',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    _buildMenuTile(
                      onTap: _showLogoutDialog,
                      imagePath: 'assets/images/logout.png',
                      title: 'Logout',
                      textColor: Colors.black,
                    ),
                    _buildMenuTile(
                      onTap: (){},
                      imagePath: 'assets/images/delete.png',
                      title: 'Delete Account',
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    String? imagePath,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
    Color textColor = Colors.white,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Image.asset(
                imagePath!,
                height: 22,
                width: 22,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            trailing ??
                const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
          ],
        ),
      ),
    );
  }
}