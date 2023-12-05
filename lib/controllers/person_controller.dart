import 'dart:convert';

import 'package:financialweb/repositories/person_repository.dart';
import 'package:flutter/foundation.dart';

import '../http/http_service.dart';
import '../models/person.dart';

class PersonController extends ChangeNotifier {
  final PersonRepository repository;
  final HttpService httpService;
  bool loading = true;
  List<Person> people = [];

  PersonController(this.repository, this.httpService) {
    load();
  }

  Future<List<Person>> load() async {
    loading = true;
    notifyListeners();
    var response = await httpService.get('people');

    List peopleJson = jsonDecode(response.body);
    people =
        peopleJson.map((e) => Person(name: e['name'], id: e['id'])).cast<Person>().toList();
    loading = false;
    notifyListeners();

    return people;
  }

  save(String text) async {
    var response = await httpService.post('people', {
      "name": text,
    });

    if (response.statusCode == 201) {
      await load();
      notifyListeners();
      return Future.value(true);
    }

    return Future.value(false);
  }
}
