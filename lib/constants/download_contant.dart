import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadUtils {
  static Future<bool> downloadFile(String url, String fileName) async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        return false;
      }

      // Get the download directory
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        return false;
      }

      // Create downloads folder if it doesn't exist
      final downloadDir = Directory('${directory.path}/Download');
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      // Download the file
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        return false;
      }

      // Save the file
      final file = File('${downloadDir.path}/$fileName.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return true;
    } catch (e) {
      print('Download error: $e');
      return false;
    }
  }
}