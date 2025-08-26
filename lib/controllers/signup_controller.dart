import 'package:get/get.dart';
import 'package:washmen/models/signup_model.dart';
import 'package:washmen/repo/signup_repo.dart';

import '../login_screen.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  final _repo = SignUpRepository();

  Future<void> signUp(SignUpRequestModel model) async {
    try {
      isLoading.value = true;
      final response = await _repo.signUp(model);
      Get.snackbar("Success", response["Message"] ?? "Signed up successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
