import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DownloadUtils {
  static Future<bool> downloadFile(String url, String fileName) async {
    try {
      final response = await HttpClient().getUrl(Uri.parse(url));
      final result = await response.close();

      // 👇 This gets the actual Downloads folder
      final directory = Directory('/storage/emulated/0/Download');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final file = File('${directory.path}/$fileName.pdf');
      final bytes = await result.fold<List<int>>([], (a, b) => a..addAll(b));
      await file.writeAsBytes(bytes);

      return true;
    } catch (e) {
      print("Download error: $e");
      return false;
    }
  }
}
