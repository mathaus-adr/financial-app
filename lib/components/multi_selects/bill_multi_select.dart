import 'package:financialweb/controllers/person_controller.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

import '../../controllers/bill_controller.dart';
import '../../models/bill.dart';

// ignore: must_be_immutable
class BillMultiSelect extends StatefulWidget {
  BillMultiSelect(
      {super.key,
      required this.validateFunction,
      required this.formKey,
      this.selectionFunction,
      required this.initialValue});
  final String? Function(List<Bill>?) validateFunction;
  final Function(List<Bill>?)? selectionFunction;
  final GlobalKey<FormFieldState> formKey;
  List<Bill> initialValue;

  @override
  State<BillMultiSelect> createState() => _BillMultiSelectState();
}

class _BillMultiSelectState extends State<BillMultiSelect> {
  List<Bill> selectedPeople = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<BillController>(builder: (context, controller, _) {
      final bills = controller.bills;
      return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.35),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2)),
          child: MultiSelectDialogField(
            key: widget.formKey,
            title: const Text('Contas'),
            items: bills.map((e) => MultiSelectItem(e, e.name)).toList(),
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
            searchHint: 'Procure',
            onSelectionChanged: widget.selectionFunction,
            initialValue: widget.initialValue,
            selectedColor: Colors.blueAccent,
            selectedItemsTextStyle: const TextStyle(
              color: Colors.white
            ),
          ));
    });
  }
}
