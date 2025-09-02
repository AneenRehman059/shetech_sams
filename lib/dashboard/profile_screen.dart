import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:washmen/change_password_screen.dart';
import 'package:washmen/controllers/login_controller.dart';
import 'package:washmen/feedback_screen.dart';
import '../bottom_app_bar/bottom_app_bar.dart';
import '../customs/app_bar.dart';
import '../personal_detail_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String title;
  const ProfileScreen({super.key, required this.title});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final loginController = Get.find<LoginController>();
  final Color menuBackgroundColor = const Color(0xFF8A3E59);
  final storage = const FlutterSecureStorage();
  String? userName;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? name = await storage.read(key: "user_name");
    String? mail = await storage.read(key: "email_no1");
    setState(() {
      userName = name ?? "Guest User";
      email = mail ?? "Not available";
    });
  }

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
              Image.asset('assets/images/logout.png', height: 50, width: 50),
              const SizedBox(height: 12),
              const Text(
                "Logout",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        body: Column(
          children: [
            CustomAppBar(title: widget.title, showBackButton: true),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                            AssetImage('assets/images/logo.png'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            userName ?? "Loading...",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            email ?? "Loading...",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 20),

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
                            onTap: () {
                              Get.to(EditProfileScreen());
                            },
                            imagePath: 'assets/images/detail.png',
                            title: 'Personal Details',
                          ),
                          _buildMenuTile(
                            onTap: () {},
                            imagePath: 'assets/images/supp.png',
                            title: 'Help & Support',
                          ),
                          _buildMenuTile(
                            onTap: () {
                              Get.to(FeedbackScreen());
                            },
                            imagePath: 'assets/images/feedback.png',
                            title: 'Feedback',
                          ),
                          _buildMenuTile(
                            onTap: () {},
                            imagePath: 'assets/images/faqs.png',
                            title: 'FAQs',
                          ),
                          _buildMenuTile(
                            onTap: () {
                              Get.to(ChangePasswordScreen());
                            },
                            imagePath: 'assets/images/password.png',
                            title: 'Change Password',
                          ),
                          _buildMenuTile(
                            onTap: () {},
                            imagePath: 'assets/images/biometric.png',
                            title: 'Enable Biometric Login',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

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
                            onTap: () {},
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
          ],
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
            SizedBox(width: 16),
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
                Icon(Icons.arrow_forward_ios,
                    color: Colors.black, size: 20),
          ],
        ),
      ),
    );
  }
}
