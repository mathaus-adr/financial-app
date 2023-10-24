import 'package:financialweb/controllers/events_controller.dart';
import 'package:financialweb/widget/person/add_person_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:provider/provider.dart';

import '../components/multi_selects/person_multi_select.dart';
import '../models/person.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pathParam = GoRouterState.of(context).params;
    final peopleMultiSelectKey = GlobalKey<FormFieldState>();

    return Scaffold(
      body: Consumer<EventsController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final event = controller.eventsRepository
              .find(int.parse(pathParam['eventIndex']));

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                  child: Column(
                children: [
                  Row(children: [
                    PersonMultiSelect(
                        validateFunction: (personList) {
                          if (personList!.isEmpty) {
                            return 'teste';
                          }
                          return null;
                        },
                        formKey: peopleMultiSelectKey),
                    ElevatedButton(
                        onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (_) => const AddPerson(),
                            isScrollControlled: true),
                        child: const Text('Cadastrar pessoas'))
                  ])
                ],
              )
                  //Valor,
                  //select pessoas,
                  //select contas
                  ),
            ),
          );
        },
      ),
    );
  }
}
