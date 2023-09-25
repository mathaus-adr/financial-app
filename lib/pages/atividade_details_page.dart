import 'package:financialweb/components/conta/conta_list.dart';
import 'package:flutter/material.dart';

import '../components/app/app_navbar.dart';
import '../components/conta/conta_checkbox.dart';
import '../models/atividade.dart';

class AtividadeDetails extends StatefulWidget {
  const AtividadeDetails({super.key, required this.atividade});
  final Atividade atividade;
  @override
  State<AtividadeDetails> createState() => _AtividadeDetailsState();
}
class _AtividadeDetailsState extends State<AtividadeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('FinancialApp')),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ContaCheckbox(conta: widget.atividade.contas![index]);
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: widget.atividade.contas!.length)
          ],
        ),
      ),
      bottomNavigationBar: const AppNavBar(),
    );
  }
}
