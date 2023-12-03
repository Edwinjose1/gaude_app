import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Functions/functions.dart';
import 'package:gaude_app/Screens/add_designation.dart';
import 'package:gaude_app/Screens/widgets/show_model_sheet.dart';
import 'package:http/http.dart' as http;

class AddDesignations extends StatefulWidget {
  @override
  _AddDesignationsState createState() => _AddDesignationsState();
}

class _AddDesignationsState extends State<AddDesignations> {
  List<String> departments = [];
  List<String> selectedDepartments = [];
  TextEditingController designationNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Call getBranch method when the widget initializes
    fetchDepartment();
  }

  Future<void> fetchDepartment() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://${Colorconst.ipaddress}:2000/api/department/get-department'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedepartment = (jsonData['result'] as List)
            .map((departmentJson) =>
                departmentJson['department_name'].toString())
            .toList();

        setState(() {
          departments.clear();
          departments.addAll(updatedepartment);
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branches: $e');
      // Handle error case here
    }
  }

  Future<void> addDesignation() async {
    final designationName = designationNameController.text;
    print("000000000000${designationName}");
    final List<Map<String, int>> departmentList = selectedDepartments
        .map((departmentName) => {
              'department_id': departments.indexOf(departmentName) + 1
            }) // Replace this logic to fetch branch ID appropriately
        .toList();
    print(departmentList);
    final data = {
      'designation_name': designationName,
      'departments': departmentList,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'http://${Colorconst.ipaddress}:2000/api/designation/add-designation'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Department added successfully
        print('Designation added successfully');
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error adding designation: $e');
      // Handle error case here
    }
    // setState(() {

    // });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Designation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AddEntity(
      title: 'Select departments for the new designations',
      items: departments,
      selectedItems: selectedDepartments,
      textEditingController: designationNameController,
      onSelectionChanged: (values) {
        setState(() {
          selectedDepartments = values.cast<String>();
        });
      },
      onSubmit: (context) {
        addDesignation();
        showAddingSnackbar(
            context: context,
            songName: "New Designation added",
            message: "New Designation");
        Navigator.pop(context);
      },
    );
  }
}
