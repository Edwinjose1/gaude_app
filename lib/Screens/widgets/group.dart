import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Functions/functions.dart';
import 'package:gaude_app/Screens/add_group.dart';
import 'package:gaude_app/Screens/widgets/show_model_sheet.dart';
import 'package:gaude_app/employee_response/employee_response.dart';
import 'package:http/http.dart' as http;

class AddGroups extends StatefulWidget {
  @override
  _AddGroupsState createState() => _AddGroupsState();
}

class _AddGroupsState extends State<AddGroups> {
  List<String> employees = [];
  List<String> selectedEmployees = [];
   List<EmployeeResponse> employee1 = [];
  List<String> employeeNamesOnly = [];
  TextEditingController groupNameController = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchemployee();
  }



  Future<void> fetchemployee () async {
    try {
      final response = await http.get(
        Uri.parse('http://${Colorconst.ipaddress}:2000/api/employees/get-employee'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedBranches = (jsonData['result'] as List)
            .map((branchJson) => branchJson['emp_name'].toString())
            .toList();

        setState(() {
          employees.clear();
          employees.addAll(updatedBranches);
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branches: $e');
      // Handle error case here
    }
  }
    Future<void> addgroup() async {
    final groupName = groupNameController.text;
    final List<Map<String, int>> emoloyeeList = selectedEmployees
        .map((emoloyeeName) => {
              'employee_id': employees.indexOf(emoloyeeName) + 1
            }) // Replace this logic to fetch branch ID appropriately
        .toList();
    print("reslt vannu");
    final data = {
      'group_name': groupName,
      'employees':emoloyeeList ,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'http://${Colorconst.ipaddress}:2000/api/group/add-group'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Department added successfully
        print('group added successfully');
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error adding group: $e');
      // Handle error case here
    }
    // setState(() {

    // });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Group()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return AddEntity(
      title: 'Select employees for the new group',
      items: employees,
      selectedItems: selectedEmployees,
      textEditingController: groupNameController,
      onSelectionChanged: (values) {
        setState(() {
          selectedEmployees = values.cast<String>();
        });
      },
      onSubmit: (context) {
        addgroup();
        Navigator.pop(context);
        showAddingSnackbar(
            context: context,
            message: "New Group Created",
            songName: "Group 1");
      },
    );
  }
}
