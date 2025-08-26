import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';
import '../../bottom_app_bar/bottom_app_bar.dart';
import '../../controllers/social_controller.dart';
import 'package:washmen/payment_plan_detail_screen.dart';

class OnlinePaymentsScreen extends StatefulWidget {
  @override
  State<OnlinePaymentsScreen> createState() => _OnlinePaymentsScreenState();
}

class _OnlinePaymentsScreenState extends State<OnlinePaymentsScreen> {
  final SocialController controller = Get.put(SocialController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // 🔹 Use MediaQuery instead of isTablet
    final topPadding = screenSize.height * 0.07; // ~7% of height
    final horizontalPadding = screenSize.width * 0.05; // ~5% of width
    final buttonSize = screenSize.width * 0.20; // 20% of width
    final titleFontSize = screenSize.width * 0.05; // responsive title size

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => SafeArea(child: MainWrapper()));
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image with blur
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pay_online_bg_img.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(color: Colors.black.withOpacity(0.1)),
            ),

            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitFadingCircle(
                        color: AppColors.appColor,
                        size: 50.0,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading',
                        style: TextStyle(
                          color: AppColors.appColor,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  // Top bar
                  Padding(
                    padding: EdgeInsets.only(
                      top: topPadding,
                      left: horizontalPadding,
                      right: horizontalPadding,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                          onPressed: () =>
                              Get.offAll(() => SafeArea(child: MainWrapper())),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.appColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            'Pay Online',
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteBg,
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(width: screenSize.width * 0.12),
                      ],
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.05),

                  // Grid of buttons
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: GridView.builder(
                        itemCount: controller.branches.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 items per row
                          crossAxisSpacing: screenSize.width * 0.06,
                          mainAxisSpacing: screenSize.height * 0.04,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final branch = controller.branches[index];
                          return _buildSocialButton(
                            branch['image_url'] ?? '',
                            branch['brn_code'] ?? '',
                            branch['brn_name'] ?? '',
                            buttonSize,
                            context,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(
      String imageUrl, String brnCode, String brnName, double size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SafeArea(
              child: MainWrapper(
                initialIndex: 0,
                child: PayOnlineScreen(brnCode: brnCode, brnName: brnName),
              ),
            ),
          ),
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.whiteBg,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
