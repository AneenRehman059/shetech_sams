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

class SOPsScreen extends StatelessWidget {
  final CompanyController _companyController = Get.find<CompanyController>();

  SOPsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: CustomAppBar(
        title: 'SOPs',
      ),
      body: Obx(() {
        if (_companyController.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitFadingCircle(
                  color: AppColors.appColor,
                  size: 50.0,
                ),
                const SizedBox(height: 20),
                Text(
                  'Loading SOPs...',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        if (_companyController.mobileSOPs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No SOPs available',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _companyController.mobileSOPs.length,
          itemBuilder: (context, index) {
            final sop = _companyController.mobileSOPs[index];
            final imagePath = sop['image_path']?.toString() ?? '';
            final fullUrl = '${ApiConstants.baseUrl}$imagePath';
            final sopName = sop['SOPs_name']?.toString() ?? 'Unnamed SOP';
            final imageName = sop['image_name']?.toString() ?? '';

            return _buildSOPCard(
              context,
              sopName,
              imageName,
              fullUrl,
              index,
            );
          },
        );
      }),
    );
  }

  Widget _buildSOPCard(
      BuildContext context, String title, String subtitle, String url, int index) {
    // Check if the file is a PDF by extension
    final isPdf = url.toLowerCase().endsWith('.pdf');

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.to(() => PDFViewerScreen(
            title: title,
            pdfUrl: url,
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isPdf ? Colors.red.shade100 : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isPdf ? Icons.picture_as_pdf : Icons.description,
                  color: isPdf ? Colors.red.shade700 : Colors.green.shade700,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    Text(
                      isPdf ? 'PDF Document' : 'Document',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  Icons.download,
                  color: isPdf ? Colors.red.shade700 : Colors.green.shade700,
                  size: 28,
                ),
                onPressed: () async {
                  await _downloadSOP(context, url, title);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _downloadSOP(
      BuildContext context, String url, String fileName) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final result = await DownloadUtils.downloadFile(url, fileName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result
              ? 'SOP downloaded successfully'
              : 'Failed to download SOP'),
          backgroundColor: result ? Colors.green : Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission denied'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}