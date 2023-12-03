import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Functions/functions.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class NewEmployeeForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _NewEmployeeFormState createState() => _NewEmployeeFormState();
}

class _NewEmployeeFormState extends State<NewEmployeeForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  File? _image;
  final _formKey = GlobalKey<FormState>();

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> addEmployee({
    required String name,
    required String department,
    required String designation,
    required String employeeId,
    required String address,
    required String email,
    required String mobile,
    required File? image,
  }) async {
    var apiUrl =
        'http://${Colorconst.ipaddress}:2000/api/employees/add-employee';

    // Encode the image file, if available
    String base64Image = '';
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }
    print(
        "///////////////////////////////${name}/////////////////////////////////");

    // Define the payload
    var payload = {
      'emp_name': name,
      'emp_department': department,
      'emp_designation': designation,
      'emp_id': employeeId,
      'emp_address': address,
      'emp_email': email,
      'emp_mobile': mobile,
      'emp_image': base64Image, // Assuming image is encoded as base64
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
        // ...
        print(
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        // For example:
        // showAddingSnackbar(context: context, songName: "New Employee", message: "New Employee added");
        // Navigator.pop(context);

        // Implement your logic to handle success
      } else {
        // Handle any errors
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colorconst.Mbg,
          elevation: 0,
          title: const Text('Add Employee'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _getImageFromGallery,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                _image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                Text("Add photo")
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the department';
                      }
                      return null;
                    },
                    controller: departmentController,
                    decoration: InputDecoration(
                      labelText: 'Department',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the designation';
                      }
                      return null;
                    },
                    controller: designationController,
                    decoration: InputDecoration(
                      labelText: 'Designation',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the employee ID';
                      }
                      return null;
                    },
                    controller: employeeIdController,
                    decoration: InputDecoration(
                      labelText: 'Employee ID',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the address';
                      }
                      return null;
                    },
                    controller: addressController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the mobile number';
                      }
                      return null;
                    },
                    controller: mobileController,
                    decoration: InputDecoration(
                      labelText: 'Mobile',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 30),
                        backgroundColor: Colorconst.But2color),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Form is valid, proceed with saving data
                        showAddingSnackbar(
                          context: context,
                          songName: "New Employee",
                          message: "New Employee added",
                        );

                        // Add a delay before popping the screen
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                          addEmployee(
                              name: nameController.text,
                              department: departmentController.text,
                              designation: designationController.text,
                              employeeId: employeeIdController.text,
                              address: addressController.text,
                              email: emailController.text,
                              mobile: mobileController.text,
                              image: _image);
                          print(
                              "${nameController.text},,,,,,,,,,${departmentController.text}'''''''''''''${_image}");
                          // Implement your logic to save the employee here
                        });
                      }
                    },
                    child: const Text(
                      'Save Employee',
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
