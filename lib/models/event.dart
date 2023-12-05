import 'package:hive/hive.dart';

import 'bill.dart';
import 'person.dart';
import 'user.dart';


@HiveType(typeId: 0)
class Event {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late List<Person> participantes = [];
  @HiveField(2)
  late List<Bill> contas = [];
  @HiveField(3)
  late int id;

  Event(
      {required this.name, required this.participantes, required this.contas, required this.id});

  Event.fromJson(Map<String, dynamic> json) {}
}
