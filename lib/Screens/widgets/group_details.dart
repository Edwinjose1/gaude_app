import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';

class GroupDetails extends StatefulWidget {
  final List<String>? selectedEmployees;

// ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  GroupDetails({required this.selectedEmployees});

  @override
  // ignore: library_private_types_in_public_api
  _GroupDetailsState createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  void _showRemoveConfirmation(String employeeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Employee'),
          content: Text('Do you want to remove $employeeName from the group?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                widget.selectedEmployees!.remove(employeeName);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconst.Mbg,
        title: const Text('Group Details'),
      ),
      body: ListView.builder(
        itemCount: widget.selectedEmployees!.length,
        itemBuilder: (context, index) {
          return ListTile(
            subtitle: GestureDetector(
              onTap: () {
                _showRemoveConfirmation(widget.selectedEmployees![index]);
              },
              child: Text(
                widget.selectedEmployees![index],
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
