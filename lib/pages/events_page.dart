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
        title: const Center(
            child: Text(
          'Eventos',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.indigo,
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Card(
                  child: TileEventWidget(
                    id: index,
                    event: events[index],
                    selected: isEventSelected(events[index]),
                    toogleEvent: (value) {
                      handleSelectedEvent(value, events[index]);
                    },
                  ),
                );
              }),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => const AddEventDialog(),
            isScrollControlled: true),
        label: const Text('Adicionar', style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  isEventSelected(Event event) {
    return _selectedEvents
        .where((element) => element.id == event.id)
        .isNotEmpty;
  }

  handleSelectedEvent(bool value, Event event) {
    if (!value) {
      setState(() {
        _selectedEvents = _selectedEvents
            .where((element) => element.id != event.id)
            .toList();
      });

      return;
    }

    if (!isEventSelected(event)) {
      setState(() {
        _selectedEvents.add(event);
      });
    }
  }
}
