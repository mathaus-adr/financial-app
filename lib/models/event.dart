import 'package:hive/hive.dart';

import 'conta.dart';
import 'participante.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class Event {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late List<Participante>? participantes = [];
  @HiveField(2)
  late List<Conta>? contas = [];
  Event({required this.name, this.participantes, this.contas});
}
