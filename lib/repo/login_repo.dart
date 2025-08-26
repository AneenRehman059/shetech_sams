import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:washmen/bottom_app_bar/bottom_app_bar.dart';

import '../constants/api_constant.dart';
import '../models/login_model.dart';

class LoginRepository {
  Future<Map<String, dynamic>> login(LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse(ApiConstants.loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }
}
