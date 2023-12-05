import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../http/http_service.dart';
import '../models/bill.dart';
import '../models/event.dart';
import '../models/person.dart';
import '../repositories/events_repository.dart';

class EventsController extends ChangeNotifier {
  final EventsRepository eventsRepository;
  final HttpService httpService;
  List<Event> events = [];
  bool loading = true;
  EventsController(this.eventsRepository, this.httpService) {
    load();
  }

  Future<List<Event>> load() async {
    loading = true;
    var response = await httpService.get('events');
    List eventsJson = jsonDecode(response.body);

    events = eventsJson.map((e) {
      var personList = e['people']
          .map((person) => Person(id: person['id'], name: person['name']))
          .cast<Person>()
          .toList();
      var billList = e['bills']
          .map((bill) => Bill(
              id: bill['id'],
              name: bill['name'],
              preco: bill['price'].toDouble()))
          .cast<Bill>()
          .toList();
      return Event(
          id: e['id'],
          name: e['name'],
          participantes: personList,
          contas: billList);
    }).toList();
    notifyListeners();
    loading = false;
    return events;
  }

  save(String name) async {
    // final event = Event(name: name, contas: [], participantes: []);

    var response = await httpService.post('events', {"name": name});

    if (response.statusCode == 201) {
      await load();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<Event?> find(int id) async {
    var response = await httpService.get('events/${id.toString()}');
    if (response.statusCode != 200) {
      return Future(() => null);
    }

    Map event = jsonDecode(response.body);

    var personList = event['people']
        .map((person) => Person(id: person['id'], name: person['name']))
        .cast<Person>()
        .toList();
    var billList = event['bills']
        .map((bill) => Bill(
            id: bill['id'],
            name: bill['name'],
            preco: bill['price'].toDouble()))
        .cast<Bill>()
        .toList();

    return Event(
        id: event['id'],
        name: event['name'],
        participantes: personList,
        contas: billList);
  }

  edit(int index, List<Person> people, List<Bill> bills) async {
    var response = await httpService.put(
        'events/' + index.toString(),
        jsonEncode({
          "people": people.map((e) => e.toJson()['id']).cast<int>().toList(),
          "bills": bills.map((e) => e.toJson()['id']).cast<int>().toList(),
        }));

    if (response.statusCode == 200) {
      await load();
      return Future.value(true);
    }

    return Future(() => false);

    // final event = Event(name: name, participantes: people, contas: bills);
    // return await eventsRepository.edit(index, event);
  }

  Future<Event> getEvent(int eventIndex) async {
    var response = await httpService.get('events/' + eventIndex.toString());
    Map event = jsonDecode(response.body);

    var personList = event['people']
        .map((person) => Person(id: person['id'], name: person['name']))
        .cast<Person>()
        .toList();
    var billList = event['bills']
        .map((bill) => Bill(
            id: bill['id'],
            name: bill['name'],
            preco: bill['price'].toDouble()))
        .cast<Bill>()
        .toList();

    return Event(
        id: event['id'],
        name: event['name'],
        participantes: personList,
        contas: billList);
  }
}
