import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../controllers/get_events_controller.dart';
import '../../constants/api_constant.dart';
import 'dashboard/develope_progress_det_screen.dart';
import '../../colors.dart';
import '../../customs/app_bar.dart';

class GetDevelopmentProgressScreen extends StatelessWidget {
  final EventsController eventsController = Get.put(EventsController());

  GetDevelopmentProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomAppBar(
          title: 'Development Progress',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 12),

            Expanded(
              child: Obx(() {
                if (eventsController.isLoading.value) {
                  return const Center(
                    child: SpinKitWave(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                }

                if (eventsController.uniqueDevelopment.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Development Progress found",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: eventsController.uniqueDevelopment.length,
                  itemBuilder: (context, index) {
                    final dev = eventsController.uniqueDevelopment[index];
                    final imageUrl = "${ApiConstants.baseUrl}${dev.imagePath}";

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DevelopmentProgressDetailScreen(
                            eventId: dev.eventId));
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              imageUrl,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stack) =>
                              const Icon(Icons.broken_image,
                                  size: 60, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            dev.eventName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
