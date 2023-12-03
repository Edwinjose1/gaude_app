import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class AddEntity extends StatefulWidget {
  final String title;
  final List<dynamic> items;
  final List<dynamic> selectedItems;
  final TextEditingController textEditingController;
  final void Function(List<dynamic>) onSelectionChanged;
  final void Function(BuildContext) onSubmit;

  const AddEntity({
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.textEditingController,
    required this.onSelectionChanged,
    required this.onSubmit,
  });

  @override
  _AddEntityState createState() => _AddEntityState();
}

class _AddEntityState extends State<AddEntity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: widget.textEditingController,
                decoration: const InputDecoration(
                  hintText: "Enter title here......",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: MultiSelectDialogField(
                title: Text('Select ${widget.title}'),
                backgroundColor: Colors.white,
                items: widget.items
                    .map((item) =>
                        MultiSelectItem<dynamic>(item, item.toString()))
                    .toList(),
                listType: MultiSelectListType.LIST,
                dialogHeight: 300,
                onConfirm: (values) {
                  setState(() {
                    widget.onSelectionChanged(values.cast<dynamic>());
                  });
                },
                buttonText: const Text('Select'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                chipDisplay: MultiSelectChipDisplay(
                  chipColor: Colors.green,
                  textStyle: const TextStyle(color: Colors.white),
                  onTap: (value) {
                    // Handle chip tap
                  },
                ),
                itemsTextStyle: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                selectedItemsTextStyle: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
              child: ElevatedButton(
                onPressed: () {
                  widget.onSubmit(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colorconst.Mbg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
