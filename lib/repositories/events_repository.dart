import 'package:hive_flutter/hive_flutter.dart';

import '../models/event.dart';

class EventsRepository {
  late Box<Event> box;

  EventsRepository() {
    initHive();
  }

  initHive() async {
    await Hive.initFlutter();
  }

  create(Event event) async {
    if (!box.isOpen) {
      await openBox();
    }

    box.add(event);

    return Future.value(true);
  }

  openBox() async {
    await initHive();
    box = await Hive.openBox<Event>('events');
  }

  list() async {
    await openBox();

    return box.values.toList();
  }

  Event? find(int id) {
    openBox();

    return box.values.toList().asMap()[id];
  }

  edit(int index, Event event) {
    openBox();
    box.put(index, event);
    return true;
  }
}
