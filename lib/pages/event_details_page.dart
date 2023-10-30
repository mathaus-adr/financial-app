import 'package:financialweb/components/multi_selects/bill_multi_select.dart';
import 'package:financialweb/controllers/events_controller.dart';
import 'package:financialweb/widget/bill/add_bill_dialog.dart';
import 'package:financialweb/widget/person/add_person_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/multi_selects/person_multi_select.dart';

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
    final billMultiSelectKey = GlobalKey<FormFieldState>();
    double billTotal = 0;

    return Scaffold(
      body: Consumer<EventsController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          int eventIndex = int.parse(pathParam['eventIndex']);
          final event = controller.eventsRepository
              .find(eventIndex);

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
              child: Form(
                  child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    PersonMultiSelect(
                        validateFunction: (personList) {
                          return null;
                        },
                        formKey: peopleMultiSelectKey,
                        initialValue: event!.participantes),
                    ElevatedButton(
                        onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (_) => const AddPerson(),
                            isScrollControlled: true),
                        child: const Icon(Icons.person_add)),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, children: [
                    BillMultiSelect(
                      validateFunction: (billList) {
                        if (billList!.isEmpty) {
                          return 'teste';
                        }
                        return null;
                      },
                      formKey: billMultiSelectKey,
                      initialValue: event!.contas,
                    ),
                    ElevatedButton(
                        onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (_) => const AddBill(),
                            isScrollControlled: true),
                        child: const Icon(Icons.attach_money)),
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size(50, 50))),
                        onPressed: () {
                          controller.edit(eventIndex, event.name, peopleMultiSelectKey.currentState!.value, billMultiSelectKey.currentState!.value);
                        },
                        child: const Text('Salvar'),
                      ),
                    ),
                  ),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
