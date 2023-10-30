import 'package:hive/hive.dart';

import 'bill.dart';
import 'person.dart';
import 'user.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class Event {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late List<Person> participantes = [];
  @HiveField(2)
  late List<Bill> contas = [];

  Event(
      {required this.name, required this.participantes, required this.contas});
}
