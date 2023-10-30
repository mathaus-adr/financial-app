import 'package:financialweb/components/app/app_navbar.dart';
import 'package:financialweb/repositories/bill_repository.dart';
import 'package:financialweb/repositories/person_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/person.dart';

class ContaPage extends StatefulWidget {
  const ContaPage({super.key});

  @override
  State<ContaPage> createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  final _form = GlobalKey<FormState>();
  final _contaNome = TextEditingController();
  final _valorConta = TextEditingController();
  final _searchController = SearchController();
  late List<Participante> _listaParticipantes;
  late List<Participante> _searchableParticipantes;

  @override
  void initState() {
    super.initState();
  }

  loadData() async {
    _listaParticipantes = await ParticipanteRepository().all();
    setState(() {
      _searchableParticipantes = _listaParticipantes;
    });
  }

  @override
  Widget build(BuildContext context) {
    cadastrar() {
      if (_form.currentState!.validate()) {
        ContaRepository().create(
            _contaNome.text,
            double.parse(_valorConta.text),
            Participante(name: _searchController.text));
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(
          child: Text('Conta adicionada com sucesso!'),
        )));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Contas'))),
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                )),
            Form(
                key: _form,
                child: Column(children: [
                  TextFormField(
                    controller: _contaNome,
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
                        return 'Digite a descrição';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 24)),
                  TextFormField(
                    controller: _valorConta,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor',
                      prefixIcon: Icon(Icons.attach_money),
                      prefixText: 'R\$ ',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a descrição';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      if (text.isEmpty) {
                        return;
                      }
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 24)),
                  ValueListenableBuilder(
                      valueListenable: ParticipanteRepository().getListenable(),
                      builder: (context, box, child) {
                        return SearchAnchor(
                          searchController: _searchController,
                          dividerColor: Colors.amber,
                          builder: (BuildContext context,
                              SearchController controller) {
                            loadData();
                            controller.addListener(() {
                              setState(() {
                                _searchableParticipantes = _listaParticipantes
                                    .where((element) => element.name
                                        .toLowerCase()
                                        .contains(
                                            controller.text.toLowerCase()))
                                    .toList();
                              });
                            });
                            return SearchBar(
                              hintText: 'Pagador',
                              hintStyle:
                                  const MaterialStatePropertyAll<TextStyle>(
                                      TextStyle(fontStyle: FontStyle.italic)),
                              controller: controller,
                              padding:
                                  const MaterialStatePropertyAll<EdgeInsets>(
                                      EdgeInsets.symmetric(horizontal: 16)),
                              onTap: () {
                                controller.openView();
                              },
                              onChanged: (_) {
                                controller.openView();
                              },
                              leading: const Icon(Icons.search),
                            );
                          },
                          suggestionsBuilder: (BuildContext context,
                              SearchController controller) {
                            return List<ListTile>.generate(
                                _searchableParticipantes.length, (int index) {
                              return ListTile(
                                title:
                                    Text(_searchableParticipantes[index].name),
                                onTap: () {
                                  setState(() {
                                    controller.closeView(
                                        _searchableParticipantes[index].name);
                                  });
                                },
                              );
                            });
                          },
                        );
                      }),
                ])),
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
                        child: Text('Cadastrar conta'),
                      )
                    ]),
                onPressed: () {
                  cadastrar();
                },
              ),
            )
          ])),
      bottomNavigationBar: const AppNavBar(),
    );
  }
}
