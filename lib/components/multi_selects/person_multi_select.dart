import 'package:financialweb/controllers/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

import '../../models/person.dart';

class PersonMultiSelect extends StatefulWidget {
  const PersonMultiSelect(
      {super.key, required this.validateFunction, required this.formKey});
  final String? Function(List<Person>?) validateFunction;
  final GlobalKey<FormFieldState> formKey;
  @override
  State<PersonMultiSelect> createState() => _PersonMultiSelectState();
}

class _PersonMultiSelectState extends State<PersonMultiSelect> {
  List<Person> selectedPeople = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonController>(builder: (context, controller, _) {
      final people = controller.people;
      return MultiSelectDialogField(
        key: widget.formKey,
        title: const Text('Pessoas'),
        items: people.map((e) => MultiSelectItem(e, e.name)).toList(),
        onConfirm: (values) {
          setState(() {
            selectedPeople = values;
          });
        },
        validator: widget.validateFunction,
        searchable: true
      );
    });
  }
}
