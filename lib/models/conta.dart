import 'package:financialweb/models/participante.dart';
import 'package:hive/hive.dart';

part 'conta.g.dart';

@HiveType(typeId: 1)
class Conta {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late double preco;
  @HiveField(2)
  late Participante? payedBy;
  Conta({required this.name, required this.preco, this.payedBy});
}
