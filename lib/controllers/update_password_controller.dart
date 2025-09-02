import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../repo/update_password_repo.dart';

class UpdatePasswordController extends GetxController {
  final _repo = UpdatePasswordRepository();
  final _storage = const FlutterSecureStorage();
  var isLoading = false.obs;


  void _showTopSnackBar(BuildContext context, String title, String message, Color backgroundColor) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    overlay.insert(overlayEntry);

    // Remove the overlay entry after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  // Then use it in your controller like this:
  Future<bool> updatePassword(String oldPassword, String newPassword, BuildContext context) async {
    try {
      isLoading.value = true;

      final userId = await _storage.read(key: "user_id") ?? "";

      final body = {
        "username": userId,
        "password": oldPassword,
        "new_password": newPassword,
        "deviceId": "string",
        "deviceModel": "string",
        "platform": "string",
        "osVersion": "string",
        "latitude": "string",
        "longitude": "string",
        "manufacturer": "string",
        "operatingSystem": "string",
        "webViewVersion": "string"
      };

      bool success = await _repo.updatePassword(body);

      if (success) {
        // Update local storage
        await _storage.write(key: "user_password", value: newPassword);

        // Show success message at the top with header
        _showTopSnackBar(context, "Success", "Password updated successfully!", Colors.black45);

        return true;
      } else {
        _showTopSnackBar(context, "Warning", "Password update failed. Please try again.", Colors.black45);
        return false;
      }

    } catch (e) {
      _showTopSnackBar(context, "Warning", "An unexpected error occurred. Please try again.", Colors.black45);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}