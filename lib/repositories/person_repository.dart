import 'package:hive_flutter/hive_flutter.dart';

import '../models/person.dart';

class PersonRepository {
  late Box<Person> box;

  Future<bool> create(Person person) async {
    if (!box.isOpen) {
      await openBox();
    }

    box.add(person);

    return Future.value(true);
  }

  Future<List<Person>> all() async {
    return (await Hive.openBox<Person>('Person')).values.toList();
  }

  getListenable() {
    return (Hive.box<Person>('Person')).listenable();
  }

  list() async {
    await openBox();

    return box.values.toList();
  }

  openBox() async {
    await init();
    box = await Hive.openBox<Person>('person');
  }

  init() async {
    await Hive.initFlutter();
  }
}
