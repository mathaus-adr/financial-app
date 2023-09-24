import 'package:financialweb/models/participante.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/conta.dart';

class ContaRepository {
  static List<Conta> contas = [Conta(name: 'Restaurante', preco: 100.00)];

  void create(String text, double value, Participante participante) async {
    var box = await Hive.openBox<Conta>('conta');
    box.add(Conta(name: text, preco: value, payedBy: participante));
  }

  Future<List<Conta>> all() async {
    return (await Hive.openBox<Conta>('conta')).values.toList();
  }
}
