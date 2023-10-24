import 'package:financialweb/models/person.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/bill.dart';

class ContaRepository {
  void create(String text, double value, Person participante) async {
    var box = Hive.box<Bill>('bill');
    box.add(Bill(name: text, preco: value, payedBy: participante));
  }

  List<Bill> all() {
    return (Hive.box<Bill>('bill')).values.toList();
  }

  getListenable() {
    return (Hive.box<Bill>('bill')).listenable();
  }
}
