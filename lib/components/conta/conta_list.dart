import 'package:financialweb/repositories/conta_repository.dart';
import 'package:flutter/material.dart';

import '../../models/conta.dart';
import 'conta_checkbox.dart';

class ContaList extends StatefulWidget {
  const ContaList({super.key});

  @override
  State<ContaList> createState() => _ContaListState();
}

class _ContaListState extends State<ContaList> {
  late List<Conta>? _contas;

  @override
  void initState() {
    setState(() {
      _contas = ContaRepository().all();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ContaRepository().getListenable(),
        builder: (context, value, child) {
          return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ContaCheckbox(conta: _contas![index]);
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: _contas!.length);
        });
  }
}
