import 'package:financialweb/models/participante.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/conta.dart';

class ContaRepository {
  void create(String text, double value, Participante participante) async {
    var box = Hive.box<Conta>('conta');
    box.add(Conta(name: text, preco: value, payedBy: participante));
  }

  List<Conta> all() {
    return (Hive.box<Conta>('conta')).values.toList();
  }

  getListenable() {
    return (Hive.box<Conta>('conta')).listenable();
  }
}
