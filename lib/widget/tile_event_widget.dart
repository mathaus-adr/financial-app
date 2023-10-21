import 'dart:math';

import 'package:financialweb/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TileEventWidget extends StatelessWidget {
  const TileEventWidget(
      {super.key,
      required this.event,
      required this.selected,
      required this.toogleEvent});
  final Event event;
  final bool selected;
  final Function toogleEvent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(20),
      leading: Checkbox(
        onChanged: (value) => toogleEvent(value),
        value: selected,
      ),
      title: Text(event.name),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => editEvent(event),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () {
        //EVENT DETAILS PAGE AQUI
      },
    );
  }  
  editEvent(Event event) {}
}
