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

class DocumentsScreen extends StatelessWidget {
  final CompanyController _companyController = Get.find<CompanyController>();

  DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: CustomAppBar(
        title: 'Downloads',
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
                SizedBox(height: 16),
                Text(
                  'Loading documents...',
                  style: TextStyle(color: AppColors.appColor),
                ),
              ],
            ),
          );
        }

        if (_companyController.mobileDocuments.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_open, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No documents available',
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
          itemCount: _companyController.mobileDocuments.length,
          itemBuilder: (context, index) {
            final document = _companyController.mobileDocuments[index];
            final path = document['path']?.toString() ?? '';
            final fullUrl = '${ApiConstants.baseUrl}$path';
            final fileName =
                document['file_name']?.toString() ?? 'Unnamed Document';
            final fileType = document['doc_type']?.toString() ?? 'PDF';

            return _buildDocumentCard(
              context,
              fileName,
              fileType,
              fullUrl,
              index,
            );
          },
        );
      }),
    );
  }

  Widget _buildDocumentCard(
      BuildContext context, String title, String type, String url, int index) {
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
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.description,
                  color: Colors.blue.shade700,
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
                    Text(
                      type.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
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
                  color: Colors.blue.shade700,
                  size: 28,
                ),
                onPressed: () async {
                  await _downloadDocument(context, url, title);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _downloadDocument(
      BuildContext context, String url, String fileName) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final result = await DownloadUtils.downloadFile(url, fileName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result
              ? 'Document downloaded successfully'
              : 'Failed to download document'),
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
