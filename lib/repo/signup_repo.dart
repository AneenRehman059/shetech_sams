import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:washmen/constants/api_constant.dart';
import 'package:washmen/models/signup_model.dart';

import '../login_screen.dart';

class SignUpRepository {
  Future<Map<String, dynamic>> signUp(SignUpRequestModel model) async {
    final response = await http.post(
      Uri.parse(ApiConstants.signUpUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      Get.offAll(() => LoginScreen());
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to sign up: ${response.body}");
    }
  }
}
