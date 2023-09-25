import 'package:financialweb/repositories/conta_repository.dart';
import 'package:flutter/material.dart';

import '../models/conta.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  final TextEditingController contaController = TextEditingController();
  Conta? selected;
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<Conta>> contas = <DropdownMenuEntry<Conta>>[];

    for (final conta in ContaRepository().all()) {
      contas.add(DropdownMenuEntry<Conta>(
          value: conta, label: conta.name, trailingIcon: Icon(Icons.search)));
    }
    return Padding(
        padding: const EdgeInsets.all(24),
        child: DropdownMenu<Conta>(
          dropdownMenuEntries: contas,
          controller: contaController,
          onSelected: (value) {
            setState(() {
              selected = value;
            });
          },
        ));
  }
}
