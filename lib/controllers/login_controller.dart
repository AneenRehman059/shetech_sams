import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../bottom_app_bar/bottom_app_bar.dart';
import '../login_screen.dart';
import '../models/login_model.dart';
import '../repo/login_repo.dart';
import 'get_company_controller.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final _repo = LoginRepository();
  final _storage = const FlutterSecureStorage();
  final CompanyController companyController = Get.put(CompanyController());

  Future<bool> login({required String username, required String password}) async {
    try {
      isLoading.value = true;

      final model = LoginRequestModel(username: username, password: password);
      final response = await _repo.login(model);

      if (response["StatusCode"] == "200") {
        final obj = response["obj"];

        await _storage.write(key: "user_id", value: obj["user_id"]);
        await _storage.write(key: "user_name", value: obj["user_name"]);
        await _storage.write(key: "email_no1", value: obj["email_no1"]);
        await _storage.write(key: "mobile_no1", value: obj["mobile_no1"]);
        await _storage.write(key: "OTP", value: obj["OTP"]);
        await _storage.write(key: "user_password", value: obj["user_password"]);

        Get.offAll(() => MainWrapper());
        await companyController.fetchAndStoreCompanyDetails("SHET");

        return true;
      } else {
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: "user_id");
    await _storage.delete(key: "user_name");
    await _storage.delete(key: "email_no1");
    await _storage.delete(key: "mobile_no1");
    await _storage.delete(key: "OTP");

    Get.offAll(() => LoginScreen());
  }
}
