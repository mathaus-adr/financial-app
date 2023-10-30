import 'package:financialweb/controllers/events_controller.dart';
import 'package:financialweb/controllers/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PersonController>();
    return Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: 300,
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
                          const Expanded(child: Text('Nova pessoa')),
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
                            border: UnderlineInputBorder(),
                            focusColor: Colors.indigo),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Informe o nome da pessoa!";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton.tonalIcon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.save(_title.text);
                              if (context.mounted) context.pop(context);
                              
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Center(
                                child: Text('Pessoa adicionada com sucesso!'),
                              )));
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Cadastrar'),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
