import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:washmen/colors.dart';
import '../../controllers/social_controller.dart';
import '../../social_media_links_screen.dart';

class SocialScreen extends StatelessWidget {
  final SocialController controller = Get.put(SocialController());

  SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background image
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/social1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Column(
            children: [
              /// Top bar
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      'Social',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Divider(color: AppColors.appColor, thickness: 1),
              Obx(() {
                if (controller.isLoading.value && controller.branches.isEmpty) {
                  // show loader only if list is empty
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SpinKitFadingCircle(
                            color: AppColors.appColor,
                            size: 50.0,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Loading',
                            style: TextStyle(color: AppColors.appColor),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 30,
                      childAspectRatio: 1,
                      children: controller.branches.map((branch) {
                        return _buildSocialButton(
                          branch['image_url'] ?? '',
                          branch['brn_code'] ?? '',
                          context,
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
            ],
          ),

          /// Bottom overlay image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/social2.png',
                height: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String imageUrl, String brnCode, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SocialMediaLinksScreen(brnCode: brnCode));
        print(brnCode);
      },
      child: Container(
        width: 50,
        height: 50,
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
