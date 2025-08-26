import 'package:get/get.dart';
import '../models/get_events_model.dart';
import '../repo/events_repo.dart';

class EventsController extends GetxController {
  final _repo = EventsRepository();

  var isLoading = false.obs;
  var eventsObj = Rxn<EventsObj>();

  var uniqueEvents = <Event>[].obs;
  var uniqueDevelopment = <DevelopmentProgress>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEventsData();
  }

  Future<void> fetchEventsData() async {
    try {
      isLoading.value = true;

      final data = await _repo.getEventsData(comp: "SHET");

      if (data.statusCode == "200") {
        eventsObj.value = data.obj;

        uniqueEvents.value = _getUniqueByEventId(data.obj.events);
        uniqueDevelopment.value =
            _getUniqueDevByEventId(data.obj.developmentProgress);
      } else {
        Get.snackbar("Error", data.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  List<Event> _getUniqueByEventId(List<Event> events) {
    final Map<String, Event> uniqueMap = {};
    for (var event in events) {
      if (!uniqueMap.containsKey(event.eventId)) {
        uniqueMap[event.eventId] = event;
      }
    }
    return uniqueMap.values.toList();
  }

  List<DevelopmentProgress> _getUniqueDevByEventId(
      List<DevelopmentProgress> devs) {
    final Map<String, DevelopmentProgress> uniqueMap = {};
    for (var dev in devs) {
      if (!uniqueMap.containsKey(dev.eventId)) {
        uniqueMap[dev.eventId] = dev;
      }
    }
    return uniqueMap.values.toList();
  }

  List<Event> getEventsByEventId(String eventId) {
    if (eventsObj.value == null) return [];
    return eventsObj.value!.events.where((e) => e.eventId == eventId).toList();
  }

  List<DevelopmentProgress> getDevelopmentByEventId(String eventId) {
    if (eventsObj.value == null) return [];
    return eventsObj.value!.developmentProgress
        .where((e) => e.eventId == eventId)
        .toList();
  }
}
