import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:washmen/customs/other_app_bar.dart';
import 'colors.dart';
import 'constants/api_constant.dart';
import 'controllers/get_company_controller.dart';

class SocialMediaLinksScreen extends StatelessWidget {
  final String brnCode;
  final CompanyController _companyController = Get.find<CompanyController>();

  SocialMediaLinksScreen({Key? key, required this.brnCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _companyController.loadCompanyDataFromStorage();

    return Scaffold(
      appBar: OtherAppBar(
        title: 'Social',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/booking_bg.png',
                height: 400,
                fit: BoxFit.contain,
              ),
            ),
          ),

          /// Reactive List
          Obx(() {
            if (_companyController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final filtered = _companyController.socialLinks
                .where((item) => item['brn_code']?.toString() == brnCode)
                .toList();

            if (filtered.isEmpty) {
              return const Center(child: Text('No social links found.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                await _companyController.fetchAndStoreCompanyDetails("SHE");
              },
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final item = filtered[index];
                  final socialId = item['social_Id'] ?? 'No Social Id';
                  final url = item['url'] ?? 'No URL';
                  final docPath = item['doc_path'] ?? '';

                  final fullImageUrl = docPath.isNotEmpty
                      ? '${ApiConstants.baseUrl}$docPath'
                      : '';

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: fullImageUrl.isNotEmpty
                          ? GestureDetector(
                        onTap: () async {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.appColor, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              fullImageUrl,
                              width: 40,
                              height: 40,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      )
                          : const Icon(Icons.image_not_supported),
                      title: Text(socialId),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
