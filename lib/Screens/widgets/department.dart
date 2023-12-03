
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Functions/functions.dart';
import 'package:gaude_app/Screens/add_department.dart';
import 'package:gaude_app/Screens/widgets/show_model_sheet.dart';
import 'package:http/http.dart' as http;

class AddDepartments extends StatefulWidget {
  @override
  _AddDepartmentsState createState() => _AddDepartmentsState();
}

class _AddDepartmentsState extends State<AddDepartments> {
  List<String> branches = [];
  List<String> selectedBranches = [];
  TextEditingController departmentNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call getBranch method when the widget initializes
    fetchBranches();
  }

  Future<void> fetchBranches() async {
    try {
      final response = await http.get(
        Uri.parse('http://${Colorconst.ipaddress}:2000/api/branch/get-branch'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedBranches = (jsonData['result'] as List)
            .map((branchJson) => branchJson['branch_name'].toString())
            .toList();

        setState(() {
          branches.clear();
          branches.addAll(updatedBranches);
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branches: $e');
      // Handle error case here
    }
  }

  Future<void> addDepartment() async {
    final departmentName = departmentNameController.text;
    final List<Map<String, int>> branchList = selectedBranches
        .map((branchName) => {
              'branch_id': branches.indexOf(branchName) + 1
            }) // Replace this logic to fetch branch ID appropriately
        .toList();
    print("reslt vannu");
    final data = {
      'department_name': departmentName,
      'branches': branchList,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'http://${Colorconst.ipaddress}:2000/api/department/add-department'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Department added successfully
        print('Department added successfully');
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error adding department: $e');
      // Handle error case here
    }
    // setState(() {

    // });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Department()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AddEntity(
      title: 'Select branches for the new departments',
      items: branches,
      selectedItems: selectedBranches,
      textEditingController: departmentNameController,
      onSelectionChanged: (values) {
        setState(() {
          selectedBranches = values.cast<String>();
        });
      },
      onSubmit: (context) {
        addDepartment();
        // Call the function to add the department
        showAddingSnackbar(
          context: context,
          songName: "New Department added",
          message: "New department",
        );
        Navigator.pop(context);
      },
    );
  }
}
