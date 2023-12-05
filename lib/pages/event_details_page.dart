import 'dart:math';

import 'package:financialweb/components/multi_selects/bill_multi_select.dart';
import 'package:financialweb/controllers/events_controller.dart';
import 'package:financialweb/helpers/money_format.dart';
import 'package:financialweb/models/event.dart';
import 'package:financialweb/widget/bill/add_bill_dialog.dart';
import 'package:financialweb/widget/person/add_person_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/multi_selects/person_multi_select.dart';
import '../models/bill.dart';
import '../models/person.dart';

class EventDetailsPage extends StatefulWidget {
  final int id;

  const EventDetailsPage({super.key, required this.id});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  Event? event;
  List<Person> people = [];
  List<Bill> contas = [];
  double totalValue = 0.0;
  double dividedValue = 0.0;
  final peopleMultiSelectKey = GlobalKey<FormFieldState>();
  final billMultiSelectKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    _loadEvent();

    super.initState();
  }

  @override
  build(BuildContext context) {
    Map<String, dynamic> pathParam = GoRouterState.of(context).params;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Evento',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Total do evento'),
                      readOnly: true,
                      initialValue: MoneyFormat.real.format(totalValue)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Total por participante do evento'),
                      readOnly: true,
                      initialValue: MoneyFormat.real.format(dividedValue)),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                              style: const ButtonStyle(
                                minimumSize:
                                    MaterialStatePropertyAll(Size(50, 50)),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.indigo),
                              ),
                              onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (_) => const AddPerson(),
                                  isScrollControlled: true),
                              label: const Text(
                                'Adicionar participante',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(Icons.person_add,
                                  color: Colors.white)),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          PersonMultiSelect(
                              validateFunction: (personList) {
                                return null;
                              },
                              formKey: peopleMultiSelectKey,
                              initialValue: people),
                        ])),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(children: [
                      ElevatedButton.icon(
                          style: const ButtonStyle(
                            minimumSize: MaterialStatePropertyAll(Size(50, 50)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.indigo),
                          ),
                          onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (_) => const AddBill(),
                              isScrollControlled: true),
                          label: const Text(
                            'Cadastrar conta',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.attach_money,
                            color: Colors.white,
                          )),
                      const Padding(padding: EdgeInsets.only(top: 12)),
                      BillMultiSelect(
                        validateFunction: (billList) {
                          return null;
                        },
                        formKey: billMultiSelectKey,
                        initialValue: contas,
                      ),
                    ])),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(50, 50)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.greenAccent),
                      ),
                      onPressed: () {
                        EventsController controller =
                            Provider.of<EventsController>(context,
                                listen: false);
                        controller.edit(
                            widget.id,
                            peopleMultiSelectKey.currentState!.value,
                            billMultiSelectKey.currentState!.value);
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Evento atualizado com sucesso!')),
                        );
                      },
                      child: const Text('Salvar',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ));
  }

  _loadEvent() async {
    Event eventObject =
        await Provider.of<EventsController>(context, listen: false)
            .getEvent(widget.id);

    setState(() {
      event = eventObject;
      contas = eventObject!.contas;
      var totalBill = 0.0;
      totalValue = eventObject!.contas
          .fold(totalBill, (totalBill, bill) => totalBill + bill.preco);
      dividedValue = eventObject!.participantes.isNotEmpty
          ? totalValue / eventObject!.participantes.length
          : 0;
      people = eventObject!.participantes;
      
    });
  }
}
