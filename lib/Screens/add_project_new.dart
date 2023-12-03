import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Functions/functions.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class NewProjectForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _NewProjectFormState createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {

  // String selectedclientname = 'Clients';
  String? selectedGroup ;
  String? selectedEmployee ;
  String? selectedClassification;
  String? selectedclientname;
  
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> workClassifications = ['Work 1', 'Work 2', 'Work 3'];
    List<String> groups = ['Group 1', 'Group 2', 'Group 3'];
    List<String> employees = ['Employee 1', 'Employee 2', 'Employee 3'];
    List<String> employeeName=[];
  List<String> clientNames=[];
List<String> classificationNames=[];
List<String> groupNames=[];




 Future<void> getclient() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/client/get-client'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedclientlist = (jsonData['result'] as List)
            .map((categoryJson) => categoryJson['client_name'].toString())
            .toList();
        // List<CategoryResponse> updatedClasssification =
        //     (jsonData['result'] as List)
        //         .map((branchJson) => CategoryResponse.fromJson(branchJson))
        //         .toList();

        setState(() {
          clientNames.clear(); // Clear the existing list
          clientNames
              .addAll(updatedclientlist); // Add the updated branches
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }
   Future<void> getclassification() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/classification/get-classification'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedclassificationlist = (jsonData['result'] as List)
            .map((categoryJson) => categoryJson['classification_name'].toString())
            .toList();
        // List<CategoryResponse> updatedClasssification =
        //     (jsonData['result'] as List)
        //         .map((branchJson) => CategoryResponse.fromJson(branchJson))
        //         .toList();

        setState(() {
          classificationNames.clear(); // Clear the existing list
          classificationNames
              .addAll(updatedclassificationlist); // Add the updated branches
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }
   Future<void> getgroup() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/group/get-group'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedgrouplist = (jsonData['result'] as List)
            .map((categoryJson) => categoryJson['group_name'].toString())
            .toList();
        // List<CategoryResponse> updatedClasssification =
        //     (jsonData['result'] as List)
        //         .map((branchJson) => CategoryResponse.fromJson(branchJson))
        //         .toList();

        setState(() {
          groupNames.clear(); // Clear the existing list
          groupNames
              .addAll(updatedgrouplist); // Add the updated branches
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }
   Future<void> getemployeee() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/employees/get-employee'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedemployeelist = (jsonData['result'] as List)
            .map((categoryJson) => categoryJson['emp_name'].toString())
            .toList();
        // List<CategoryResponse> updatedClasssification =
        //     (jsonData['result'] as List)
        //         .map((branchJson) => CategoryResponse.fromJson(branchJson))
        //         .toList();

        setState(() {
          employeeName.clear(); // Clear the existing list
          employeeName
              .addAll(updatedemployeelist); // Add the updated branches
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }
void _submitForm() {
  if (_formKey.currentState?.validate() ?? false) {
    // Form is valid, proceed with saving data
    String clientName = selectedclientname.toString();
    String classification = selectedClassification.toString(); // Replace selectedClassification with the value from the dropdown
    String description = descriptionController.text;
    String assignedGroup = selectedGroup.toString(); // Replace selectedGroup with the value from the dropdown
    String assignedEmployee = selectedEmployee.toString(); // Replace selectedEmployee with the value from the dropdown

    addProject(
      clientName: clientName,
      classification: classification,
      description: description,
      assignedGroup: assignedGroup,
      assignedEmployee: assignedEmployee,
    );

    // Show a snackbar or perform any other action
    showAddingSnackbar(
      context: context,
      songName: "New Project",
      message: "New Project Created",
    );

    // Add a delay before popping the screen
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}

  Future<void> addProject({
  required String clientName,
  required String classification,
  required String description,
  required String assignedGroup,
  required String assignedEmployee,
}) async {
  var apiUrl = 'http://${Colorconst.ipaddress}:2000/api/project/add-project';

  // Define the payload
  var payload = {
    'project_client_name': clientName,
    'project_classification': classification,
    'project_description': description,
    'project_assigned_group': assignedGroup,
    'project_assigned_employee': assignedEmployee,
  };

  // Encode the payload as JSON
  var body = json.encode(payload);

  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      // If addition is successful, perform actions (e.g., navigate, clear fields)
  
      try {
       

        // After successful insertion, you can perform additional actions if needed
        print('Project added to the MySQL database.');

      } catch (mysqlError) {
        // Handle MySQL insertion errors
        print('Error inserting data into MySQL: $mysqlError');
      }

      // Implement your logic to handle success
    } else {
      // Handle any errors in API call
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    // Handle exceptions
    print('Error: $error');
  }
}

@override
  void initState() {
    // TODO: implement initState
    getclient();
    getclassification();
    getgroup();
    getemployeee();
    
  }
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colorconst.Mbg,
          elevation: 0,
          title: const Text('ADD PROJECT'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedclientname,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedclientname = newValue;
                      });
                    },
                    items: clientNames
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Client Names',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select Work Classification';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),




                  DropdownButtonFormField<String>(
                    value: selectedClassification,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedClassification = newValue;
                      });
                    },
                    items: classificationNames
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Work Classification',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select Work Classification';
                      }
                      return null;
                    },
                  ),









                  const SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedGroup,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGroup = newValue;
                      });
                    },
                    items: groupNames
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Assign to Groups',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select Assign to Groups';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedEmployee,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEmployee = newValue;
                      });
                    },
                    items: employeeName
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Assign to Employees',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select Assign to Employees';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colorconst.But2color,
                        fixedSize: const Size(250, 30)),
                    onPressed: _submitForm,
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
