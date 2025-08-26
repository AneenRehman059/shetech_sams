import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // ⬅️ Import spinkit
import 'package:washmen/customs/app_bar.dart';
import '../../colors.dart';
import '../../models/get_events_model.dart';
import '../../constants/api_constant.dart';
import '../../controllers/get_events_controller.dart';

class EventDetailScreen extends StatelessWidget {
  final String eventId;
  final EventsController eventsController = Get.find();

  EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final List<Event> eventImages =
    eventsController.getEventsByEventId(eventId);

    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Events',
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     vertical: screenHeight * 0.015,
            //   ),
            //   child: Center(
            //     child: Text(
            //       "Images",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: screenWidth * 0.055,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20,),
            Expanded(
              child: eventImages.isEmpty
                  ? Center(
                child: Text(
                  "No images found for this event",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
              )
                  : SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.005,
                ),
                child: Column(
                  children: eventImages.map((event) {
                    final imageUrl =
                        "${ApiConstants.baseUrl}${event.imagePath}";
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: screenHeight * 0.015,
                      ),
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return  Center(
                            child: SpinKitFadingCircle(
                              color: AppColors.appColor,
                              size: 50.0,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 80),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
