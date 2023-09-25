import 'package:hive/hive.dart';

import 'conta.dart';
import 'participante.dart';

part 'atividade.g.dart';

@HiveType(typeId: 0)
class Atividade {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late List<Participante>? participantes = [];
  @HiveField(2)
  late List<Conta>? contas = [];
  Atividade({required this.name, this.participantes, this.contas});
}
