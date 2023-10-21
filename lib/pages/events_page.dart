import 'package:financialweb/models/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/events_controller.dart';
import '../widget/add_event_dialog.dart';
import '../widget/tile_event_widget.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<Event> _selectedEvents = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Eventos')),
      ),
      body: Consumer<EventsController>(builder: (context, controller, _) {
        final events = controller.events;
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (events.isEmpty) {
          return const Center(
            child: Text('Nenhum evento cadastrado'),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Card(
                  child: TileEventWidget(
                    event: events[index],
                    selected: isEventSelected(events[index]),
                    toogleEvent: (value) {
                      print(_selectedEvents);
                      handleSelectedEvent(value, events[index]);
                      controller.notifyListeners();
                    },
                  ),
                );
              }),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => const AddEventDialog(),
            isScrollControlled: true),
        label: const Text('Adicionar'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  isEventSelected(Event event) {
    return _selectedEvents
        .where((element) => element.name == event.name)
        .isNotEmpty;
  }

  handleSelectedEvent(bool value, Event event) {
    if (!value) {
      _selectedEvents = _selectedEvents
          .where((element) => element.name != event.name)
          .toList();
      return;
    }

    if (!isEventSelected(event)) {
      _selectedEvents.add(event);
    }
  }
}
