import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/customs/other_app_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bottom_app_bar/bottom_app_bar.dart';
import '../controllers/social_controller.dart';
import '../customs/app_bar.dart';

class SalesCenterScreen extends StatefulWidget {
  final String title;
  const SalesCenterScreen({super.key, required this.title});

  @override
  State<SalesCenterScreen> createState() => _SalesCenterScreenState();
}

class _SalesCenterScreenState extends State<SalesCenterScreen> {
  final SocialController socialController = Get.put(SocialController());

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF8A2B5B);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => MainWrapper());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomAppBar(title: widget.title, showBackButton: true),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                child: Text(
                  'Main Offices',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
              ),

              /// 🔹 Scrollable list below
              Expanded(
                child: Obx(() {
                  if (socialController.isLoading.value) {
                    return Center(
                      child: SpinKitWave(
                        color: AppColors.appColor,
                        size: 50.0,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.01,
                    ),
                    itemCount: socialController.branches.length,
                    itemBuilder: (context, index) {
                      final branch = socialController.branches[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          officeName(
                            title: branch['brn_name'] ?? '',
                            screenWidth: screenWidth,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          officeBlock(
                            themeColor,
                            address: _formatAddress(branch),
                            phone: branch['phone_no'] ?? '',
                            email: branch['email_address'] ?? '',
                            screenWidth: screenWidth,
                          ),
                          SizedBox(height: screenHeight * 0.025),
                        ],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatAddress(Map<String, dynamic> branch) {
    List<String> addressParts = [];
    if (branch['add_1'] != null) addressParts.add(branch['add_1']);
    if (branch['add_2'] != null) addressParts.add(branch['add_2']);
    if (branch['add_3'] != null) addressParts.add(branch['add_3']);
    if (branch['add_4'] != null) addressParts.add(branch['add_4']);

    return addressParts.join('\n');
  }

  Widget officeName({required String title, required double screenWidth}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF8A2B5B),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/building.png',
            height: screenWidth * 0.07,
            width: screenWidth * 0.07,
          ),
          SizedBox(width: screenWidth * 0.025),
          Expanded(
            child: Text(
              title.trim(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget officeBlock(
      Color themeColor, {
        required String address,
        required String phone,
        required String email,
        required double screenWidth,
      }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3FF),
        border: Border.all(color: themeColor),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (address.isNotEmpty)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, size: screenWidth * 0.06),
                SizedBox(width: screenWidth * 0.025),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(fontSize: screenWidth * 0.035),
                  ),
                ),
              ],
            ),
          if (address.isNotEmpty) SizedBox(height: screenWidth * 0.03),
          if (phone.isNotEmpty)
            Row(
              children: [
                Icon(Icons.phone, size: screenWidth * 0.06),
                SizedBox(width: screenWidth * 0.025),
                Text(
                  phone,
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
              ],
            ),
          if (phone.isNotEmpty) SizedBox(height: screenWidth * 0.03),
          if (email.isNotEmpty)
            Row(
              children: [
                Icon(Icons.email, size: screenWidth * 0.06),
                SizedBox(width: screenWidth * 0.025),
                Expanded(
                  child: Text(
                    email,
                    style: TextStyle(fontSize: screenWidth * 0.035),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
