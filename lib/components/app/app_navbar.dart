import 'package:financialweb/pages/atividade_page.dart';
import 'package:financialweb/pages/conta_page.dart';
import 'package:flutter/material.dart';

import '../../pages/participante_page.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({
    super.key,
  });

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  cadastrarParticipante() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const CreateParticipantePage()));
  }

  cadastrarAtividade() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AtividadePage()));
  }

  exibirValores() {}

  cadastrarConta() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ContaPage()));
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(children: [
        IconButton(
            onPressed: () {
              cadastrarAtividade();
            },
            icon: const Icon(Icons.note_add)),
        IconButton(
            onPressed: () {
              cadastrarConta();
            },
            icon: const Icon(Icons.attach_money)),
        IconButton(
            onPressed: () {
              cadastrarParticipante();
            },
            icon: const Icon(Icons.person_add_alt)),
      ]),
    );
  }
}
