import 'package:flutter/material.dart';
import '../../helpers/money_format.dart';
import '../../models/conta.dart';

class ContaCheckbox extends StatefulWidget {
  const ContaCheckbox({super.key, required this.conta});
  final Conta conta;
  @override
  State<StatefulWidget> createState() => _ContaCheckBoxState();
}

class _ContaCheckBoxState extends State<ContaCheckbox> {
  late bool checked;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: false,
      onChanged: (value) {
        setState(() {
          checked = value!;
        });
      },
      title: Text(widget.conta.name +
          " " +
          MoneyFormat.real.format(widget.conta.preco)),
    );
  }
}
