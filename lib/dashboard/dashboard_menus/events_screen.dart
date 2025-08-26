import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:washmen/customs/app_bar.dart';
import '../../colors.dart';
import '../../constants/api_constant.dart';
import '../../controllers/get_events_controller.dart';
import '../../models/get_events_model.dart';
import 'get_events_detail_screen.dart' show EventDetailScreen;

class GetEventsScreen extends StatelessWidget {
  final EventsController eventsController = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(
          title: 'Events',
        ),
      ),
      body: Obx(() {
        if (eventsController.isLoading.value) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.whiteBg,
              size: screenWidth * 0.12,
            ),
          );
        } else if (eventsController.uniqueEvents.isEmpty) {
          return Center(
            child: Text(
              'No events available',
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: EdgeInsets.fromLTRB(
              //       screenWidth * 0.04,
              //       screenHeight * 0.02,
              //       screenWidth * 0.04,
              //       screenHeight * 0.02),
              //   child: Text(
              //     'Events',
              //     style: TextStyle(
              //       fontSize: screenWidth * 0.06, // responsive heading
              //       fontWeight: FontWeight.bold,
              //       color: AppColors.whiteBg,
              //     ),
              //   ),
              // ),
              SizedBox(height: 20,),
              Expanded(
                child: EventsGrid(
                  events: eventsController.uniqueEvents,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  eventsController: eventsController,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class EventsGrid extends StatelessWidget {
  final List<Event> events;
  final double screenWidth;
  final double screenHeight;
  final EventsController eventsController;

  EventsGrid({
    required this.events,
    required this.screenWidth,
    required this.screenHeight,
    required this.eventsController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth > 600 ? 3 : 2,
          crossAxisSpacing: screenWidth * 0.05,
          mainAxisSpacing: screenHeight * 0.02,
          childAspectRatio: 0.9,
        ),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventItem(
            event: events[index],
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            eventsController: eventsController,
          );
        },
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final Event event;
  final double screenWidth;
  final double screenHeight;
  final EventsController eventsController;

  EventItem({
    required this.event,
    required this.screenWidth,
    required this.screenHeight,
    required this.eventsController,
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl = '${ApiConstants.baseUrl}${event.imagePath}';

    return GestureDetector(
      onTap: () {
        final allEvents = eventsController.getEventsByEventId(event.eventId);
        Get.to(() => EventDetailScreen(eventId: event.eventId));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.18,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.error,
                      color: Colors.grey[600],
                      size: screenWidth * 0.1,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SpinKitFadingCircle(
                      color: AppColors.appColor,
                      size: screenWidth * 0.08,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            event.eventName,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteBg,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
