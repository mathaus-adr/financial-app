import 'package:financialweb/controllers/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

import '../../models/person.dart';

class PersonMultiSelect extends StatefulWidget {
  PersonMultiSelect(
      {super.key,
      required this.validateFunction,
      required this.formKey,
      required this.initialValue});
  final String? Function(List<Person>?) validateFunction;
  final GlobalKey<FormFieldState> formKey;
  List<Person> initialValue;

  @override
  State<PersonMultiSelect> createState() => _PersonMultiSelectState();
}

class _PersonMultiSelectState extends State<PersonMultiSelect> {
  List<Person> selectedPeople = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonController>(builder: (context, controller, _) {
      final people = controller.people;
      return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.35),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2)),
          child: MultiSelectDialogField(
            key: widget.formKey,
            title: const Text('Pessoas'),
            items: people.map((e) => MultiSelectItem(e, e.name)).toList(),
            onConfirm: (values) {
              setState(() {
                selectedPeople = values;
              });
            },
            listType: MultiSelectListType.CHIP,
            validator: widget.validateFunction,
            searchable: true,
            buttonText: const Text('Selecione'),
            buttonIcon: const Icon(Icons.search),
            selectedColor: Colors.blueAccent,
            selectedItemsTextStyle: const TextStyle(
              color: Colors.white
            ),
            initialValue: widget.initialValue,
          ));
    });
  }
}
