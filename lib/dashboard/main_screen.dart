import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Add this import
import 'package:washmen/colors.dart';
import 'package:washmen/customs/app_bar.dart';
import '../constants/api_constant.dart';
import '../controllers/get_company_controller.dart';
import 'dashboard_menus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CompanyController companyController = Get.put(CompanyController());
  final RxInt currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    companyController.fetchAndStoreCompanyDetails("SHET");
  }

  @override
  Widget build(BuildContext context) {
    final double sliderHeight = MediaQuery.of(context).size.height * 0.25;

    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              showBackButton: false,
            ),
            SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() {
                      return Stack(
                        children: [
                          CarouselSlider(
                            items: _buildSliderItems(context),
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayCurve: Curves.easeInOut,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              height: sliderHeight,
                              onPageChanged: (index, reason) {
                                currentIndex.value = index;
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: _buildIndicatorDots(),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 15),
                    DashboardMenus(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSliderItems(BuildContext context) {
    return companyController.sliders.map((e) {
      final rawPath = e['image_path'] ?? "";
      final url = "${ApiConstants.baseUrl}$rawPath";
      debugPrint("🔗 Slider URL: $url");

      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Image.network(
          url,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SpinKitWave( // Replaced CircularProgressIndicator with SpinKitWave
                color: AppColors.appColor,
                size: 30.0, // You can adjust the size as needed
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            debugPrint("❌ Failed to load: $url -> $error");
            return Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Icon(Icons.broken_image,
                  size: 50, color: Colors.grey),
            );
          },
        ),
      );
    }).toList();
  }

  Widget _buildIndicatorDots() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: companyController.sliders.asMap().entries.map((entry) {
        return Container(
          width: currentIndex.value == entry.key ? 12 : 8,
          height: currentIndex.value == entry.key ? 12 : 8,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex.value == entry.key
                ? AppColors.appColor
                : Colors.white.withOpacity(0.6),
          ),
        );
      }).toList(),
    ));
  }
}