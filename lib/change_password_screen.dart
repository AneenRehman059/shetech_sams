import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/constants/image_constant.dart';
import 'package:washmen/customs/custom_fields.dart';
import 'package:washmen/customs/app_bar.dart';
import '../controllers/update_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  final UpdatePasswordController _controller =
  Get.put(UpdatePasswordController());
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Password validation regex
  final RegExp passwordRegex =
  RegExp(r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Method to clear all text fields
  void _clearFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> _handleUpdate() async {
    if (_controller.isLoading.value) return;

    final savedPassword = await _storage.read(key: "user_password") ?? "";

    if (oldPasswordController.text.trim() != savedPassword) {
      Get.snackbar(
        "Warning",
        "Old password does not match!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      _clearFields(); // Clear fields on validation error
      return;
    }

    // Validate new password format
    if (!passwordRegex.hasMatch(newPasswordController.text.trim())) {
      Get.snackbar(
        "Warning",
        "New password must contain at least:\n• 8 characters\n• 1 capital letter\n• 1 special character",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      _clearFields(); // Clear fields on validation error
      return;
    }

    if (newPasswordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      Get.snackbar(
        "Warning",
        "New Password & Confirm Password do not match!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      _clearFields(); // Clear fields on validation error
      return;
    }

    bool success = await _controller.updatePassword(
      oldPasswordController.text.trim(),
      newPasswordController.text.trim(),
      context,
    );

    if (success) {
      // Wait a moment for the snackbar to show, then navigate back
      await Future.delayed(const Duration(milliseconds: 1600));
      Navigator.of(context).pop();
    } else {
      // Clear fields if the API call failed
      _clearFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          SizedBox(height: size.height * 0.040),
          CustomAppBar(
            title: "Change Password",
            showBackButton: true,
            onBackPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
              ),
              child: ListView(
                children: [
                  /// Logo
                  Center(
                    child: Image.asset(
                      ImageConstant.logo,
                      height: size.height * 0.12,
                    ),
                  ),

                  CustomTextField(
                    label: "Old Password",
                    hintText: "Enter old password",
                    icon: Icons.vpn_key,
                    controller: oldPasswordController,
                    obscureText: true,
                    showVisibilityIcon: true,
                  ),
                  SizedBox(height: size.height * 0.025),

                  CustomTextField(
                    label: "New Password",
                    hintText: "Enter new password",
                    icon: Icons.vpn_key,
                    controller: newPasswordController,
                    obscureText: true,
                    showVisibilityIcon: true,
                  ),
                  SizedBox(height: size.height * 0.025),

                  CustomTextField(
                    label: "Confirm Password",
                    hintText: "Re-enter new password",
                    icon: Icons.vpn_key,
                    controller: confirmPasswordController,
                    obscureText: true,
                    showVisibilityIcon: true,
                  ),
                  SizedBox(height: size.height * 0.04),

                  // Update button
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.06,
                    child: Obx(() => ElevatedButton(
                      onPressed: _controller.isLoading.value
                          ? null
                          : _handleUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _controller.isLoading.value
                            ? AppColors.appColor.withOpacity(0.7)
                            : AppColors.appColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _controller.isLoading.value
                          ? SpinKitWave(
                        color: Colors.white,
                        size: 24.0,
                      )
                          : Text(
                        "UPDATE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    )),
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}