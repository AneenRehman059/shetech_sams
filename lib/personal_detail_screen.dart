import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';
import 'customs/app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _storage = const FlutterSecureStorage();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController(text: "House # 1 Street # 4 Kashmir Park Shahdara Lahore House # 1 Street # 4 Kashmir Park Shahdara Lahore",);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await _storage.read(key: "user_name") ?? "";
    final mobile = await _storage.read(key: "mobile_no1") ?? "";
    final email = await _storage.read(key: "email_no1") ?? "";
    setState(() {
      nameController.text = name;
      mobileController.text = mobile;
      emailController.text = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body:    SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Edit Profile',
              showBackButton: true,
              onBackPressed: Get.back,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                     Text("Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(controller: nameController),
                    SizedBox(height: screenHeight * 0.015),
                    Row(
                      children: [
                        Text("Mobile No",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(controller: mobileController),
                    SizedBox(height: screenHeight * 0.015),
                     Text("Email",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(controller: emailController),
                    SizedBox(height: screenHeight * 0.015),
                     Text("Address",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: screenHeight * 0.005),
                    SizedBox(
                      height: screenHeight * 0.08,
                      child: _buildTextField(
                        controller: addressController,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 40),
                        SizedBox(width: screenWidth * 0.02),
                        const Text("Profile Picture"),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor,
                            minimumSize:
                            Size(screenWidth * 0.3, screenHeight * 0.05),
                          ),
                          child:  Text("SELECT IMAGE",style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.snackbar("Success", "Profile Updated Successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black54,
                              colorText: Colors.white);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appColor,
                        ),
                        child: Text(
                          "UPDATE PROFILE",
                          style: TextStyle(fontSize: 16,color: Colors.white),
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

  Widget _buildTextField(
      {required TextEditingController controller, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xfff5f9ff),
        contentPadding:
        EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.appColor),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mediumGrey, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

