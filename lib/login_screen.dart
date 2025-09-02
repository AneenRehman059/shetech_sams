import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/signup_screen.dart';
import 'package:washmen/bottom_app_bar/bottom_app_bar.dart';
import 'package:washmen/controllers/login_controller.dart';
import 'package:washmen/customs/app_bar.dart';
import 'package:washmen/customs/custom_buttons.dart';
import 'package:washmen/customs/custom_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginController = Get.put(LoginController());

  bool _isLoading = false;
  final Map<String, String> _fieldErrors = {
    'cnic': '',
    'password': '',
  };

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    bool isValid = true;

    // Clear previous errors
    setState(() {
      _fieldErrors['cnic'] = '';
      _fieldErrors['password'] = '';
    });

    // CNIC validation
    if (usernameController.text.isEmpty) {
      setState(() {
        _fieldErrors['cnic'] = 'Please enter your CNIC';
      });
      isValid = false;
    } else if (!RegExp(r'^\d{5}-\d{7}-\d$').hasMatch(usernameController.text)) {
      setState(() {
        _fieldErrors['cnic'] = 'Please enter a valid CNIC (XXXXX-XXXXXXX-X)';
      });
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      setState(() {
        _fieldErrors['password'] = 'Please enter password';
      });
      isValid = false;
    }

    return isValid;
  }

  void _showTopSnackBar(BuildContext context, String title, String message, Color backgroundColor) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    overlay.insert(overlayEntry);

    // Remove the overlay entry after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  Future<void> _submitLogin() async {
    if (_validateFields()) {
      setState(() {
        _isLoading = true;
      });

      try {
        bool isSuccess = await loginController.login(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (isSuccess) {
          Get.offAll(() => MainWrapper());
        } else {
          // Show error message using a more reliable approach
          _showTopSnackBar(
            context,
            "Login Failed",
            "Invalid CNIC or password",
            Colors.black45,
          );
        }
      } catch (e) {
        // Handle any unexpected errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.black45,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleLoginPress() {
    if (!_isLoading) {
      _submitLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              showBackButton: false,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Sign in to your account to explore your dream place to live across the whole world',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: usernameController,
                          keyboardType: TextInputType.number,
                          label: 'CNIC',
                          hintText: 'XXXXX-XXXXXXX-X',
                          imagePath: 'assets/images/cnic.png',
                        ),
                        if (_fieldErrors['cnic']?.isNotEmpty ?? false)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child: Text(
                              _fieldErrors['cnic']!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          hintText: 'XXXXXXXXXX',
                          imagePath: 'assets/images/password.png',
                          obscureText: true,
                          showVisibilityIcon: true,
                        ),
                        if (_fieldErrors['password']?.isNotEmpty ?? false)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child: Text(
                              _fieldErrors['password']!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    CustomButton(
                      text: 'Log In',
                      onPressed: _isLoading ? () {} : _handleLoginPress,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 100),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: _isLoading ? null : () {
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
                        onPressed: _isLoading ? null : () {},
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
          ],
        ),
      ),
    );
  }
}