import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/customs/app_bar.dart';
import 'package:washmen/pdf_viewer_screen.dart';
import 'package:washmen/constants/api_constant.dart';
import 'package:washmen/controllers/get_company_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/download_contant.dart';

class SOPsScreen extends StatefulWidget {
  const SOPsScreen({super.key});

  @override
  State<SOPsScreen> createState() => _SOPsScreenState();
}

class _SOPsScreenState extends State<SOPsScreen>
    with TickerProviderStateMixin {
  final CompanyController _companyController = Get.find<CompanyController>();

  /// Track download states per index
  final Map<int, bool> _isDownloading = {};
  final Map<int, bool> _isDownloaded = {};
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation =
        ColorTween(begin: Colors.red, end: Colors.green).animate(_colorController);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  Future<void> _downloadSOP(
      BuildContext context, String url, String fileName, int index) async {
    setState(() {
      _isDownloading[index] = true;
      _isDownloaded[index] = false;
    });

    final status = await Permission.storage.request();
    if (status.isGranted) {
      final result = await DownloadUtils.downloadFile(url, fileName);
      setState(() {
        _isDownloading[index] = false;
        _isDownloaded[index] = result;
      });

      Get.snackbar(
        "Download",
        result ? "SOP downloaded successfully" : "Failed to download SOP",
        backgroundColor: result ? Colors.black45 : Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
      );
    } else {
      setState(() {
        _isDownloading[index] = false;
      });
      print('Permission Denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body:
      SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'SOPs',
              showBackButton: true,
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
                    const Text("Edit Profile",
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: screenHeight * 0.02),

                    /// Name
                    const Text("Name"),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(controller: nameController),

                    SizedBox(height: screenHeight * 0.015),

                    /// Mobile
                    Row(
                      children: const [
                        Text("Mobile No "),
                        Text("*", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(controller: mobileController),

                    SizedBox(height: screenHeight * 0.015),

                    /// Email
                    const Text("Email"),
                    SizedBox(height: screenHeight * 0.005),
                    _buildTextField(controller: emailController),

                    SizedBox(height: screenHeight * 0.015),

                    /// Address (fixed height)
                    const Text("Address"),
                    SizedBox(height: screenHeight * 0.005),
                    SizedBox(
                      height: screenHeight * 0.08,
                      child: _buildTextField(
                        controller: addressController,
                        maxLines: 2,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    /// Profile Picture
                    Row(
                      children: [
                        const Icon(Icons.person, size: 40),
                        SizedBox(width: screenWidth * 0.02),
                        const Text("Profile Picture"),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[700],
                            minimumSize:
                            Size(screenWidth * 0.3, screenHeight * 0.05),
                          ),
                          child: const Text("SELECT IMAGE"),
                        )
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.05),

                    /// Update button
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
                          backgroundColor: Colors.amber[700],
                        ),
                        child: const Text(
                          "UPDATE PROFILE",
                          style: TextStyle(fontSize: 16),
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

  Widget _buildSOPItem(
      BuildContext context, String title, String type, String url, int index) {
    final isDownloading = _isDownloading[index] ?? false;
    final isDownloaded = _isDownloaded[index] ?? false;

    return Column(
      children: [
        ListTile(
          onTap: () {
            Get.to(() => PDFViewerScreen(
              title: title,
              pdfUrl: url,
            ));
          },
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              type == "PDF" ? Icons.picture_as_pdf : Icons.description,
              color: type == "PDF" ? Colors.blue : Colors.green,
              size: 24,
            ),
          ),
          title: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            type,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
          trailing: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) {
              return IconButton(
                icon: Icon(
                  isDownloaded ? Icons.check_circle : Icons.download,
                  color: isDownloading
                      ? _colorAnimation.value
                      : (isDownloaded ? Colors.green : Colors.blue),
                  size: 26,
                ),
                onPressed: isDownloading
                    ? null
                    : () => _downloadSOP(context, url, title, index),
              );
            },
          ),
        ),
        Divider(
          thickness: 0.6,
          color: Colors.black45,
        ),
      ],
    );
  }
}
