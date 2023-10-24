import 'package:flutter/foundation.dart';

import '../models/event.dart';
import '../repositories/events_repository.dart';

class EventsController extends ChangeNotifier {
  final EventsRepository eventsRepository;
  List<Event> events = [];
  bool loading = true;
  EventsController(this.eventsRepository) {
    load();
  }

  Future<List<Event>> load() async {
    loading = true;
    notifyListeners();

    events = await eventsRepository.list();
    loading = false;
    notifyListeners();

    return events;
  }

  save(String name) async {
    final event = Event(name: name, contas: [], participantes: []);

    final success = await eventsRepository.create(event);

    if (success) {
      events = await eventsRepository.list();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  Event? find(int id) {
    return eventsRepository.find(id);
  }
}
