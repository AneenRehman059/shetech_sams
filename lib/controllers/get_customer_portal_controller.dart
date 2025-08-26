import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../repo/customer_portal_repo.dart';
import '../models/customer_portal_model.dart';

class CustomerPortalController extends GetxController {
  final _repo = CustomerPortalRepository();
  final _storage = const FlutterSecureStorage();

  var isLoading = false.obs;
  var customerObj = Rxn<CustomerPortalObj>();

  @override
  void onInit() {
    super.onInit();
    fetchCustomerData();
  }

  Future<void> fetchCustomerData() async {
    try {
      isLoading.value = true;

      String? userId = await _storage.read(key: "user_id");
      if (userId == null || userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      final data = await _repo.getCustomerPortalData(username: userId);

      if (data.statusCode == "201") {
        customerObj.value = data.obj;
      } else {
        Get.snackbar("Error", data.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
