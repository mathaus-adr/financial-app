import 'package:financialweb/models/event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TileEventWidget extends StatelessWidget {
  const TileEventWidget(
      {super.key,
      required this.event,
      required this.selected,
      required this.toogleEvent,
      required this.id});
  final Event event;
  final bool selected;
  final Function toogleEvent;
  final int id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(20),
      leading: Checkbox(
        onChanged: (value) => toogleEvent(value),
        value: selected,
      ),
      title: Text(event.name),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () {
        context.goNamed('event-details', params: {
          'eventIndex': event.id.toString(),
        });
      },
    );
  }
}
