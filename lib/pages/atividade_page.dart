import 'package:financialweb/components/app/app_navbar.dart';
import 'package:financialweb/models/atividade.dart';
import 'package:financialweb/repositories/atividade_repository.dart';
import 'package:flutter/material.dart';

import '../models/conta.dart';
import '../repositories/conta_repository.dart';

class AtividadePage extends StatefulWidget {
  const AtividadePage({Key? key}) : super(key: key);

  @override
  State<AtividadePage> createState() => _AtividadePageState();
}

class _AtividadePageState extends State<AtividadePage> {
  List<Conta> selectedAccounts = [];
  final TextEditingController contaController = TextEditingController();
  final TextEditingController atividadeNome = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<Conta>> contas = <DropdownMenuEntry<Conta>>[];
    final List<DropdownMenuItem<Conta>> contass = <DropdownMenuItem<Conta>>[];

    for (final conta in ContaRepository().all()) {
      contas.add(DropdownMenuEntry<Conta>(
          value: conta, label: conta.name, enabled: true));
      contass.add(DropdownMenuItem<Conta>(
        value: conta,
        enabled: true,
        child: Text(conta.name, style: const TextStyle(fontSize: 20)),
      ));
    }

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Atividades'))),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: atividadeNome,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descrição',
                      prefixIcon: Icon(Icons.people),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a descrição da atividade';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 24)),
                  DropdownButtonFormField<Conta>(
                    padding: const EdgeInsets.all(10),
                    items: contass,
                    onChanged: (value) {
                      var account =
                          selectedAccounts.where((element) => element == value);
                      if (account.isEmpty) {
                        setState(() {
                          selectedAccounts.add(value!);
                        });
                      }
                    },
                    validator: (value) {
                      if (selectedAccounts.isEmpty) {
                        return 'Selecione ao menos uma conta';
                      }
                      return null;
                    },
                    enableFeedback: true,
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.all(24),
                      child: ElevatedButton(
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_money),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('Cadastrar atividade'),
                              )
                            ]),
                        onPressed: () {
                          cadastrarAtividade();
                        },
                      )),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const AppNavBar(),
    );
  }

  void cadastrarAtividade() {
    if (_form.currentState!.validate()) {
      AtividadeRepository().create(
          Atividade(name: atividadeNome.text, contas: selectedAccounts));
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
        child: Text('Atividade adicionada com sucesso!'),
      )));
    }
  }
}
