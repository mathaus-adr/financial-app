import 'package:hive_flutter/hive_flutter.dart';
import '../models/bill.dart';

class BillRepository {
  late Box<Bill> box;

  BillRepository() {
    initHive();
  }

  openBox() async {
    await initHive();
    box = await Hive.openBox<Bill>('bill');
  }

  initHive() async {
    await Hive.initFlutter();
  }

  create(Bill bill) async {
    if (!box.isOpen) {
      await openBox();
    }

    box.add(bill);

    return Future.value(true);
  }

  list() async {
    await openBox();

    return box.values.toList();
  }
}
