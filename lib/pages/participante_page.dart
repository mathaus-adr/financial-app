import 'package:financialweb/components/app/app_navbar.dart';
import 'package:financialweb/repositories/participante_repository.dart';
import 'package:flutter/material.dart';

class CreateParticipantePage extends StatefulWidget {
  const CreateParticipantePage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateParticipantePageState();
}

class _CreateParticipantePageState extends State<CreateParticipantePage> {
  final _form = GlobalKey<FormState>();
  final _participanteNome = TextEditingController();
  cadastrar() {
    if (_form.currentState!.validate()) {
      ParticipanteRepository().create(_participanteNome.text);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
        child: Text('Participante adicionado com sucesso!'),
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Cadastrar participante')),
      ),
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
            child: TextFormField(
              controller: _participanteNome,
              style: const TextStyle(
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.people)),
              keyboardType: TextInputType.name,
              
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Digite um nome';
                }
                return null;
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.all(24),
            child: ElevatedButton(
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_alt),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Cadastrar'),
                    )
                  ]),
              onPressed: () {
                cadastrar();
              },
            ),
          )
        ]),
      ),
      bottomNavigationBar: const AppNavBar(),
    );
  }
}
