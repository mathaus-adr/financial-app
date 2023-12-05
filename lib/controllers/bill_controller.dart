import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../http/http_service.dart';
import '../models/bill.dart';
import '../repositories/bill_repository.dart';

class BillController extends ChangeNotifier {
  final BillRepository repository;
  final HttpService httpService;
  bool loading = true;
  List<Bill> bills = [];

  BillController(this.repository, this.httpService) {
    load();
  }

  Future<List<Bill>> load() async {
    loading = true;
    notifyListeners();
    var response = await httpService.get('bills');

    var billsJson = jsonDecode(response.body);
    print(billsJson);
    bills = billsJson
        .map((e) =>
            Bill(id: e['id'], name: e['name'], preco: e['price'].toDouble()))
        .cast<Bill>()
        .toList();
    loading = false;
    notifyListeners();

    return bills;
  }

  save(Bill bill) async {
    var response = await httpService.post('bills', {
      "name": bill.name,
      "price": bill.preco.toString(),
    });

    if (response.statusCode == 201) {
      await load();
      notifyListeners();
      return Future.value(true);
    }

    return Future.value(false);
  }

  create(String text) {}
}
