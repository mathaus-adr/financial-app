import 'package:financialweb/helpers/money_format.dart';
import 'package:financialweb/pages/atividade_details_page.dart';
import 'package:financialweb/repositories/atividade_repository.dart';
import 'package:flutter/material.dart';

import '../components/app/app_navbar.dart';
import '../models/atividade.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    final atividades = AtividadeRepository().all();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('FinancialApp')),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.money),
              title: Text(atividades[index].name),
              trailing: Text(MoneyFormat.real.format(atividades[index]
                  .contas!
                  .fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue + element.preco))),
              onTap: () => mostrarDetalhes(atividades[index]),
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: atividades.length),
      bottomNavigationBar: const AppNavBar(),
    );
  }

  mostrarDetalhes(Atividade atividade) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => AtividadeDetails(atividade: atividade)));
  }
}
