import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/controllers/signup_controller.dart';
import 'package:washmen/models/signup_model.dart';
import 'package:washmen/customs/app_bar.dart';
import 'package:washmen/customs/custom_buttons.dart';
import 'package:washmen/customs/custom_fields.dart';

class SignUpNScreen extends StatefulWidget {
  SignUpNScreen({super.key});

  @override
  State<SignUpNScreen> createState() => _SignUpNScreenState();
}

class _SignUpNScreenState extends State<SignUpNScreen> {
  final cnicController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final mobileNoController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();

  final _signUpController = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Error messages for each field
  final Map<String, String> _fieldErrors = {
    'firstName': '',
    'lastName': '',
    'cnic': '',
    'phone': '',
    'email': '',
    'password': '',
    'confirmPassword': '',
  };

  // Manual validation methods
  bool _validateFields() {
    bool isValid = true;
    _fieldErrors.clear();

    // First Name validation
    if (userNameController.text.isEmpty) {
      _fieldErrors['firstName'] = 'Please enter your first name';
      isValid = false;
    }

    // Last Name validation
    if (lastNameController.text.isEmpty) {
      _fieldErrors['lastName'] = 'Please enter your last name';
      isValid = false;
    }

    // CNIC validation
    if (cnicController.text.isEmpty) {
      _fieldErrors['cnic'] = 'Please enter your CNIC';
      isValid = false;
    } else if (!RegExp(r'^\d{5}-\d{7}-\d$').hasMatch(cnicController.text)) {
      _fieldErrors['cnic'] = 'Please enter a valid CNIC (XXXXX-XXXXXXX-X)';
      isValid = false;
    }

    // Phone validation
    if (mobileNoController.text.isEmpty) {
      _fieldErrors['phone'] = 'Please enter your phone number';
      isValid = false;
    } else if (!RegExp(r'^92\d{10}$').hasMatch(mobileNoController.text)) {
      _fieldErrors['phone'] = 'Please enter a valid 12-digit number starting with 92';
      isValid = false;
    }

    // Email validation
    if (emailController.text.isEmpty) {
      _fieldErrors['email'] = 'Please enter your email';
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
      _fieldErrors['email'] = 'Please enter a valid email address';
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      _fieldErrors['password'] = 'Please enter a password';
      isValid = false;
    } else if (passwordController.text.length < 8) {
      _fieldErrors['password'] = 'Password must be at least 8 characters';
      isValid = false;
    }

    // Confirm Password validation
    if (confirmPasswordController.text.isEmpty) {
      _fieldErrors['confirmPassword'] = 'Please confirm your password';
      isValid = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      _fieldErrors['confirmPassword'] = 'Passwords do not match';
      isValid = false;
    }

    // Trigger UI update to show errors
    setState(() {});
    return isValid;
  }

  void _submitForm() {
    if (_validateFields()) {
      final signUpData = SignUpRequestModel(
        cnic: cnicController.text,
        password: passwordController.text,
        mobileNo: mobileNoController.text,
        emailAddress: emailController.text,
        address: "lahore",
        userName: userNameController.text,
        otp: "string",
        otpVia: "sms",
        deviceId: "string",
        deviceModel: "string",
        platform: "string",
        osVersion: "string",
        latitude: "string",
        longitude: "string",
        manufacturer: "string",
        operatingSystem: "string",
        webViewVersion: "string",
      );
      _signUpController.signUp(signUpData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(showBackButton: false),

              // Header section (fixed - won't scroll)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width < 400 ? 16.0 : 24.0,
                  vertical: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Create your account to explore your dream place to live across the whole world',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // Scrollable form section
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth < 400 ? 16.0 : 24.0,
                        vertical: 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: userNameController,
                                label: 'First Name*',
                                hintText: 'First Name',
                                imagePath: 'assets/images/person.png',
                              ),

                              if (_fieldErrors['firstName']!.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    _fieldErrors['firstName']!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: lastNameController,
                                label: 'Last Name*',
                                hintText: 'Last Name',
                                imagePath: 'assets/images/person.png',
                              ),
                              if (_fieldErrors['lastName']!.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    _fieldErrors['lastName']!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: cnicController,
                                keyboardType: TextInputType.number,
                                label: 'CNIC*',
                                hintText: 'XXXXX-XXXXXXX-X',
                                imagePath: 'assets/images/cnic.png',
                              ),

                              if (_fieldErrors['cnic']!.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    _fieldErrors['cnic']!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: mobileNoController,
                                keyboardType: TextInputType.phone,
                                label: 'Phone Number*',
                                hintText: '(xxx) xxx-xxxxxxx',
                                imagePath: 'assets/images/world.png',
                              ),

                              if (_fieldErrors['phone']!.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    _fieldErrors['phone']!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: emailController,
                                label: 'Email*',
                                hintText: 'example@domain.com',
                                imagePath: 'assets/images/mail.png',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              if (_fieldErrors['email']!.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    _fieldErrors['email']!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: passwordController,
                                label: 'Password*',
                                hintText: 'XXXXXXXX',
                                imagePath: 'assets/images/password.png',
                                obscureText: true,
                                showVisibilityIcon: true,
                              ),
                              if (_fieldErrors['password']!.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    _fieldErrors['password']!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: confirmPasswordController,
                                label: 'Confirm Password*',
                                hintText: 'XXXXXXXX',
                                imagePath: 'assets/images/password.png',
                                obscureText: true,
                                showVisibilityIcon: true,
                              ),
                              if (_fieldErrors['confirmPassword']!.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    _fieldErrors['confirmPassword']!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 15),
                          CustomTextField(
                            controller: dobController,
                            label: 'Date of Birth',
                            keyboardType: TextInputType.number,
                            hintText: 'YYYY-MM-DD',
                            imagePath: 'assets/images/birthday.png',
                          ),
                          SizedBox(height: 30),
                          Obx(() => CustomButton(
                            text: 'Register',
                            onPressed: _submitForm,
                            isLoading: _signUpController.isLoading.value,
                          )),
                          SizedBox(height: 20),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: 'Sign In',
                                      style: TextStyle(
                                        color: AppColors.appColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}