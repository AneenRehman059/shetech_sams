import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/customs/app_bar.dart';
import '../../controllers/get_events_controller.dart';
import '../../constants/api_constant.dart';
import '../../models/get_events_model.dart';

class DevelopmentProgressDetailScreen extends StatelessWidget {
  final String eventId;
  final EventsController eventsController = Get.put(EventsController());

  DevelopmentProgressDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final List<DevelopmentProgress> devImages =
    eventsController.getDevelopmentByEventId(eventId);

    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Development Progress',
        ),
      ),
      body: SafeArea(
        top: false,
        child: devImages.isEmpty
            ? const Center(
          child: Text(
            "No images found",
            style: TextStyle(color: Colors.white),
          ),
        )
            : GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: devImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // 🔹 One item per row
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2, // Adjust height/width ratio
          ),
          itemBuilder: (context, index) {
            final dev = devImages[index];
            final imageUrl = "${ApiConstants.baseUrl}${dev.imagePath}";

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stack) =>
                const Icon(Icons.broken_image, size: 80),
              ),
            );
          },
        ),
      ),
    );
  }
}
