import 'package:financialweb/repositories/person_repository.dart';
import 'package:flutter/foundation.dart';

import '../models/person.dart';

class PersonController extends ChangeNotifier {
  final PersonRepository repository;
  bool loading = true;
  List<Person> people = [];

  PersonController(this.repository) {
    load();
  }

  Future<List<Person>> load() async {
    loading = true;
    notifyListeners();

    people = await repository.list();
    loading = false;
    notifyListeners();

    return people;
  }

  save(String text) async {
    final Person person = Person(name: text);
    final success = await repository.create(person);

    if (success) {
      people = await repository.list();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }
}
