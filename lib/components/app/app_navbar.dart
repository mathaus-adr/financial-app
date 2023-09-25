import 'package:financialweb/pages/atividade_page.dart';
import 'package:financialweb/pages/conta_page.dart';
import 'package:financialweb/pages/initial_page.dart';
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

  home() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const InitialPage()));
  }

  cadastrarConta() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ContaPage()));
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.indigo,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              padding: const EdgeInsets.all(10),
              onPressed: () {
                home();
              },
              icon: const Icon(Icons.home),
              enableFeedback: true,
            ),
            IconButton(
              padding: const EdgeInsets.all(10),
              onPressed: () {
                cadastrarAtividade();
              },
              icon: const Icon(Icons.note_add),
              enableFeedback: true,
            ),
            IconButton(
              padding: const EdgeInsets.all(10),
              onPressed: () {
                cadastrarConta();
              },
              icon: const Icon(Icons.attach_money),
              enableFeedback: true,
            ),
            IconButton(
              padding: const EdgeInsets.all(10),
              onPressed: () {
                cadastrarParticipante();
              },
              icon: const Icon(Icons.person_add_alt),
              enableFeedback: true,
            )
          ])),
    );
  }
}
