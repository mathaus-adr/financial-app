import 'package:financialweb/repositories/conta_repository.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contas = ContaRepository.contas;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('FinancialWeb')),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int conta) {
            return ListTile(
              leading: const Icon(
                Icons.show_chart
              ),
              title: Text(contas[conta].name),
              trailing: Text(contas[conta].preco.toString()),
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: contas.length),
    );
  }
}
