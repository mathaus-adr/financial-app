import 'package:flutter/foundation.dart';

import '../models/bill.dart';
import '../repositories/bill_repository.dart';

class BillController extends ChangeNotifier {
  final BillRepository repository;
  bool loading = true;
  List<Bill> bills = [];

  BillController(this.repository) {
    load();
  }

  Future<List<Bill>> load() async {
    loading = true;
    notifyListeners();

    bills = await repository.list();
    loading = false;
    notifyListeners();

    return bills;
  }

  save(Bill bill) async {

    final success = await repository.create(bill);

    if (success) {
      bills = await repository.list();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  create(String text) {}
}
