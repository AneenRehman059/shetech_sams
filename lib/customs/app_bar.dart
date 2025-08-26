import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washmen/bottom_app_bar/bottom_app_bar.dart';
import 'package:washmen/colors.dart';
import '../constants/image_constant.dart';
import '../controllers/login_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool showBackButton;
  final bool showLogoutButton;
  final String? title;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    this.height = 90,
    this.showBackButton = true,
    this.showLogoutButton = false,
    this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Container(
      color: AppColors.whiteBg,
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBackButton)
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: onBackPressed ??
                          () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainWrapper()),
                        );
                      },
                )
              else
                const SizedBox(width: 48),

              // If title is provided, show text. Otherwise, show logo
              Expanded(
                child: Center(
                  child: title != null
                      ? Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                      : Image.asset(
                    ImageConstant.logo,
                    height: height * 0.6,
                  ),
                ),
              ),

              if (showLogoutButton)
                IconButton(
                  icon: Image.asset(
                    ImageConstant.logout,
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {
                    // logout logic
                  },
                )
              else
                const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 4),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.appColor,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
