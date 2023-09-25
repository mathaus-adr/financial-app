import 'package:hive/hive.dart';

part 'participante.g.dart';

@HiveType(typeId: 2)
class Participante {
  @HiveField(0)
  late String name;

  Participante({required this.name});
}
