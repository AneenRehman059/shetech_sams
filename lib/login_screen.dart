import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/signup_screen.dart';

import 'bottom_app_bar/bottom_app_bar.dart';
import 'controllers/login_controller.dart';
import 'customs/app_bar.dart';
import 'customs/custom_buttons.dart';
import 'customs/custom_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginController = Get.put(LoginController());

  bool _isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      bool isSuccess = await loginController.login(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });

      if (isSuccess) {
        Get.offAll(() => MainWrapper());
      } else {
        Get.snackbar(
          "Login Failed",
          "Invalid CNIC or password",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(showBackButton: false, ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Log In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Log in to your account to explore your dream place to live across the whole world',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                CustomTextField(
                  controller: usernameController,
                  keyboardType: TextInputType.number,
                  label: 'CNIC',
                  hintText: 'XXXXX-XXXXXXX-X',
                  imagePath: 'assets/images/cnic.png',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your CNIC';
                    }
                    if (!RegExp(r'^\d{5}-\d{7}-\d$').hasMatch(value)) {
                      return 'Please enter a valid CNIC (XXXXX-XXXXXXX-X)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  hintText: 'XXXXXXXXXX',
                  imagePath: 'assets/images/password.png',
                  obscureText: true,
                  showVisibilityIcon: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter password'
                      : null,
                ),
                const SizedBox(height: 30),

                CustomButton(
                  text: 'Log In',
                  onPressed: _submitLogin,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 100),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(SignUpNScreen());
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.bgColor,
                      side: BorderSide(color: AppColors.appColor),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: AppColors.appColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
