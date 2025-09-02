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

class DocumentsScreen extends StatefulWidget {
  DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen>
    with TickerProviderStateMixin {
  final CompanyController _companyController = Get.find<CompanyController>();

  /// keep track of downloading states per index
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
        ColorTween(begin: Colors.blue, end: Colors.green).animate(_colorController);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  Future<void> _downloadDocument(
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
        result ? "Document downloaded successfully" : "Failed to download document",
        snackPosition: SnackPosition.TOP,
        backgroundColor: result ? Colors.black45 : Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
    } else {
      setState(() {
        _isDownloading[index] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Downloads',
              showBackButton: true,
            ),
            Expanded(
              child: Obx(() {
                if (_companyController.isLoading.value) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: AppColors.appColor,
                      size: 50.0,
                    ),
                  );
                }

                if (_companyController.mobileDocuments.isEmpty) {
                  return Center(
                    child: Text(
                      'No documents available',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  );
                }

                return ListView.builder(

                  itemCount: _companyController.mobileDocuments.length,
                  itemBuilder: (context, index) {
                    final document = _companyController.mobileDocuments[index];
                    final path = document['path']?.toString() ?? '';
                    final fullUrl = '${ApiConstants.baseUrl}$path';
                    final fileName =
                        document['file_name']?.toString() ?? 'Unnamed Document';
                    final fileType =
                        document['doc_type']?.toString() ?? 'PDF';

                    return _buildDocumentItem(
                      context,
                      fileName,
                      fileType,
                      fullUrl,
                      index,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentItem(
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
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.description, color: Colors.blue, size: 24),
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
            type.toUpperCase(),
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
                    : () => _downloadDocument(context, url, title, index),
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
