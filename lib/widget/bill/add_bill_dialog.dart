import 'package:financialweb/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../controllers/bill_controller.dart';
import '../../controllers/person_controller.dart';
import '../../models/person.dart';

class AddBill extends StatefulWidget {
  const AddBill({super.key});

  @override
  State<AddBill> createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _valorConta = TextEditingController();
  final peopleMultiSelectKey = GlobalKey<FormFieldState>();
  Person? _personSelected;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BillController>();
    return Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: 500,
          padding: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          const Expanded(child: Text('Nova conta')),
                          IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close))
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 6),
                      child: TextFormField(
                        controller: _title,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome da conta',
                            focusColor: Colors.indigo),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Informe o nome da conta!";
                          }
                          return null;
                        },
                      ),
                    ),
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
                    Consumer<PersonController>(
                        builder: (context, controller, _) {
                      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        DropdownButton<Person>(
                          items: controller.people.map((Person person) {
                            return DropdownMenuItem<Person>(
                              value: person,
                              child: Text(person.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _personSelected = value;
                            });
                          },
                        )
                      ]);
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton.tonalIcon(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.indigo)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final Bill bill = Bill(
                                  name: _title.text,
                                  preco: double.parse(_valorConta.text),
                                  payedBy: _personSelected);
                              await controller.save(bill);
                              if (context.mounted) context.pop(context);
                            }
                          },
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text('Cadastrar', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
