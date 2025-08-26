import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/api_constant.dart';
import '../models/client_detail_model.dart';

class PayOnlineController extends GetxController {
  var isLoading = false.obs;
  var clientDetailModel = Rx<ClientDetailModel?>(null);
  var errorMessage = ''.obs;

  Future<void> fetchClientDetails({
    required String username,
    required String brnCode,
    required String blockNo,
    required String plotNo,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final uri = Uri.parse(
        "${ApiConstants.getCustomerPortalUrl}"
            "?username=$username"
            "&brn_code=$brnCode"
            "&block_no=$blockNo"
            "&plot_no=$plotNo",
      );

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        clientDetailModel.value = ClientDetailModel.fromJson(data);
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}