import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/controllers/signup_controller.dart';
import 'package:washmen/models/signup_model.dart';

import 'customs/app_bar.dart';
import 'customs/custom_buttons.dart';
import 'customs/custom_fields.dart';

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
  final addressController = TextEditingController();
  final userNameController = TextEditingController();

  final _signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(showBackButton: false, ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth < 400 ? 16.0 : 24.0,
                vertical: 25,
              ),
              child: Form(
                key: _formKey,
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
                    SizedBox(height: 25),

                    CustomTextField(
                      controller: userNameController,
                      label: 'First Name',
                      hintText: 'Enter your first name',
                      icon: Icons.person_outline,
                      isSignUpStyle: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    CustomTextField(
                      label: 'Last Name',
                      hintText: 'Enter your last name',
                      icon: Icons.person_outline,
                      isSignUpStyle: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    CustomTextField(
                      controller: cnicController,
                      label: 'CNIC',
                      hintText: 'XXXXX-XXXXXXX-X',
                      icon: Icons.credit_card,
                      isSignUpStyle: true,
                      keyboardType: TextInputType.number,
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
                    SizedBox(height: 15),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 48,
                          child: TextFormField(
                            controller: mobileNoController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 12,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/country.jpeg',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              hintText: '923012345678',
                              hintStyle: TextStyle(fontSize: 12),
                              filled: true,
                              fillColor: AppColors.bgColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.appColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (!RegExp(r'^92\d{10}$').hasMatch(value)) {
                                return 'Please enter a valid 12-digit number starting with 92';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    CustomTextField(
                      controller: emailController,
                      label: 'Email',
                      hintText: 'example@domain.com',
                      icon: Icons.email_outlined,
                      isSignUpStyle: true,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    CustomTextField(
                      controller: passwordController,
                      label: 'Password',
                      hintText: 'Create a password',
                      icon: Icons.lock_outline,
                      isSignUpStyle: true,
                      obscureText: true,
                      showVisibilityIcon: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    CustomTextField(
                      controller: confirmPasswordController,
                      label: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      icon: Icons.lock_outline,
                      isSignUpStyle: true,
                      obscureText: true,
                      showVisibilityIcon: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    CustomTextField(
                      label: 'Date of Birth',
                      hintText: 'YYYY-MM-DD',
                      icon: Icons.calendar_today,
                      isSignUpStyle: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your date of birth';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),

                    Obx(() => CustomButton(
                      text: 'SIGN UP',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
                      },
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
                                text: 'Log In',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
