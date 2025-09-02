import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPortraitLayout(context),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.03),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Get.back();
                },
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Help & Support',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.055,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),

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
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Our helpline is always open to receive any inquiry or feedback...',
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      _buildContactInfoCard(
                        context,
                        icon: Icons.phone,
                        title: 'UAN',
                        details: '021-111-111-160\nToll Free: 0800-00100',
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      _buildContactInfoCard(
                        context,
                        icon: Icons.email,
                        title: 'Email',
                        details: 'info@newmetrocity.com.pk',
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      _buildContactInfoCard(
                        context,
                        icon: Icons.location_on,
                        title: 'Address',
                        details: '56-D Broadway Commercial DHA Phase 8 Lahore',
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      _buildContactInfoCard(
                        context,
                        icon: Icons.access_time,
                        title: 'Timing',
                        details: 'Mon-Fri: 10 AM - 7 PM\nSat: 10 AM - 5 PM',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Bottom Section with Form - Scrollable
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
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                ),
                child: ListView(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(context, hint: "BSM DEVELOPERS"),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(context, hint: "newmetrocity@example.com"),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Phone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(context, hint: "03212345678"),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Message',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(
                      context,
                      hint: "Type your message...",
                      maxLines: 4,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          minimumSize: Size(double.infinity, screenHeight * 0.06),
                        ),
                        onPressed: () {
                          // Handle send
                        },
                        child: Text("Send",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String details,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.appColor, size: screenWidth * 0.06),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  details,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context, {
        required String hint,
        int maxLines = 1,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: screenWidth * 0.035,
        ),
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
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenWidth * 0.03,
        ),
      ),
      style: TextStyle(fontSize: screenWidth * 0.035),
    );
  }
}