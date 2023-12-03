import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Functions/functions.dart';
import 'package:gaude_app/Screens/add_work_catagory.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class Newclient extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _NewclientState createState() => _NewclientState();
}

class _NewclientState extends State<Newclient> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController onboardingDateController =TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController proposalNumberController =
      TextEditingController();
  String? selectedWorkingCategory;
  String? selectedClientCategory;
  List<String> categoryNames = [];

 
  Future<void> addClient({
    required String clientName,
    required String refThrough,
    required String onboardingDate,
    required String ncWorkCategory,
    required String ncDescription,
    required String ncPropNumber,
    required String ncCategory,
  }) async {
    var apiUrl =
        'http://${Colorconst.ipaddress}:2000/api/client/add-client'; // Replace with your API endpoint

    // Define the payload
    var payload = {
      'client_name': clientName,
      'ref_through': refThrough,
      'onboarding_date': onboardingDate,
      'nc_work_category': ncWorkCategory,
      'nc_description': ncDescription,
      'nc_prop_number': ncPropNumber,
      'nc_category': ncCategory,
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
        // If addition is successful, perform actions
        print('Client added successfully.');

        // Handle success logic if needed
      } else {
        // Handle any errors in API call
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
    }
  }

  Future<void> getcategory() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/category/get-category'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedcatagorylist = (jsonData['result'] as List)
            .map((categoryJson) => categoryJson['category_name'].toString())
            .toList();
        // List<CategoryResponse> updatedClasssification =
        //     (jsonData['result'] as List)
        //         .map((branchJson) => CategoryResponse.fromJson(branchJson))
        //         .toList();

        setState(() {
          categoryNames.clear(); // Clear the existing list
          categoryNames.addAll(updatedcatagorylist); // Add the updated branches
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
      String clientName = nameController.text;
      String description = descriptionController.text;
      String catagory = selectedWorkingCategory.toString();
      String refrncecode = referenceController.text;
       String onboading = onboardingDateController.text;
      String proposalnumber = proposalNumberController.text;
      String clientvalue = selectedClientCategory.toString();
      // Replace selectedEmployee with the value from the dropdown

      addClient(
          clientName: clientName,
          refThrough: refrncecode,
          onboardingDate: onboading,
          ncWorkCategory: catagory,
          ncDescription: description,
          ncPropNumber: proposalnumber,
          ncCategory: clientvalue);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcategory();
  }

  @override
  Widget build(BuildContext context) {
    List<String> workingCategories = ['work1', 'work2', 'work3', 'work4'];
    List<String> clientCategories = ['Standard', 'VIP', 'Premium'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colorconst.Mbg,
          elevation: 0,
          title: const Text('Add Client'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Client Name',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Client Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: referenceController,
                    decoration: InputDecoration(
                      labelText: 'Reference Through',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Reference Through';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: onboardingDateController,
                    decoration: InputDecoration(
                      labelText: 'Onboarding Date',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Onboarding Date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedWorkingCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedWorkingCategory = newValue;
                      });
                    },
                    items: categoryNames
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Working Category',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select Working Category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
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
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: proposalNumberController,
                    decoration: InputDecoration(
                      labelText: 'Proposal Number',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Proposal Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedClientCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedClientCategory = newValue ?? 'Standard';
                      });
                    },
                    items: clientCategories
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Client Category',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select Client Category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colorconst.But2color,
                        fixedSize: const Size(250, 30)),
                    onPressed: _submitForm,
                    child: const Text(
                      'Submit',
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
