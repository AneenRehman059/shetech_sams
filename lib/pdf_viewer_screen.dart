import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';

import 'constants/download_contant.dart';
import 'customs/toast_message.dart';

class PDFViewerScreen extends StatefulWidget {
  final String title;
  final String pdfUrl;

  const PDFViewerScreen({
    super.key,
    required this.title,
    required this.pdfUrl,
  });

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localFilePath;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}: Failed to download PDF');
      }

      final bytes = response.bodyBytes;

      if (bytes.isEmpty) {
        throw Exception('Downloaded PDF is empty');
      }

      final dir = await getApplicationDocumentsDirectory();
      final file = File(
          '${dir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.pdf');

      await file.writeAsBytes(bytes);

      if (!await file.exists()) {
        throw Exception('Failed to create local PDF file');
      }

      setState(() {
        localFilePath = file.path;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });

      showTopSnackBar(
        context,
        "Error",
        "Failed to load PDF: $e",
        Colors.red.shade600,
      );
    }
  }

  Future<void> _downloadPdf() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final result =
      await DownloadUtils.downloadFile(widget.pdfUrl, widget.title);


      showTopSnackBar(
        context,
        "Download",
        result ? "PDF downloaded successfully" : "Failed to download PDF",
        result ? Colors.black45 : Colors.red,
      );
    } else {

      showTopSnackBar(
        context,
        "Permission Denied",
        "Storage permission is required to download files",
        Colors.orange.shade700,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: AppColors.whiteBg),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteBg),
        backgroundColor: AppColors.appColor,
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: AppColors.whiteBg),
            onPressed: _downloadPdf,
            tooltip: 'Download PDF',
          ),
        ],
      ),
      body: isLoading
          ? Center(
        child: SpinKitWave(
          color: AppColors.appColor,
          size: 50.0,
        ),
      )
          : localFilePath != null
          ? PDFView(
        filePath: localFilePath!,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onError: (error) {
          // Use showTopSnackBar instead of Get.snackbar
          showTopSnackBar(
            context,
            "Error",
            "Error loading PDF: $error",
            Colors.red.shade600,
          );
        },
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Failed to load PDF'),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: $errorMessage',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ElevatedButton(
              onPressed: loadPdf,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}