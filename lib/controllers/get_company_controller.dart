import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../repo/company_repo.dart';

class CompanyController extends GetxController {
  final CompanyRepository _companyRepo = CompanyRepository();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  var socialLinks = <Map<String, dynamic>>[].obs;
  var mobileSOPs = <Map<String, dynamic>>[].obs;
  var mobileDocuments = <Map<String, dynamic>>[].obs;
  var sliders = <Map<String, dynamic>>[].obs; // ✅ NEW
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCompanyDataFromStorage();
  }

  Future<void> fetchAndStoreCompanyDetails(String compCode) async {
    try {
      isLoading.value = true;

      final companyData = await _companyRepo.fetchCompanyDetails(compCode);

      if (companyData["StatusCode"] == "200") {
        final companyObj = companyData["obj"];

        // Save everything to storage
        await _storage.write(key: "company_data", value: jsonEncode(companyObj));
        await _storage.write(
          key: "social_Links",
          value: jsonEncode(companyObj["social_Links"] ?? []),
        );
        await _storage.write(
          key: "mobile_payment_plan",
          value: jsonEncode(companyObj["mobile_payment_plan"] ?? []),
        );
        await _storage.write(
          key: "mobile_SOPs",
          value: jsonEncode(companyObj["mobile_SOPs"] ?? []),
        );
        await _storage.write(
          key: "mobile_Documents",
          value: jsonEncode(companyObj["mobile_Documents"] ?? []),
        );
        await _storage.write(
          key: "sliders",
          value: jsonEncode(companyObj["sliders"] ?? []),
        );

        // Update observable lists
        socialLinks.value = List<Map<String, dynamic>>.from(companyObj["social_Links"] ?? []);
        mobileSOPs.value = List<Map<String, dynamic>>.from(companyObj["mobile_SOPs"] ?? []);
        mobileDocuments.value = List<Map<String, dynamic>>.from(companyObj["mobile_Documents"] ?? []);
        sliders.value = List<Map<String, dynamic>>.from(companyObj["sliders"] ?? []);

        isLoading.value = false;
      }
    } catch (e) {
      debugPrint("Error storing company details: $e");
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> loadCompanyDataFromStorage() async {
    final socialLinksJson = await _storage.read(key: 'social_Links');
    final sopsJson = await _storage.read(key: 'mobile_SOPs');
    final documentsJson = await _storage.read(key: 'mobile_Documents');
    final slidersJson = await _storage.read(key: 'sliders');

    if (socialLinksJson != null) {
      socialLinks.value = List<Map<String, dynamic>>.from(jsonDecode(socialLinksJson));
    }

    if (sopsJson != null) {
      mobileSOPs.value = List<Map<String, dynamic>>.from(jsonDecode(sopsJson));
    }

    if (documentsJson != null) {
      mobileDocuments.value = List<Map<String, dynamic>>.from(jsonDecode(documentsJson));
    }

    if (slidersJson != null) {
      sliders.value = List<Map<String, dynamic>>.from(jsonDecode(slidersJson));
    }

    isLoading.value = false;
  }
}
