import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:http/http.dart' as http;

class Allemployeepage extends StatefulWidget {
  @override
  State<Allemployeepage> createState() => _AllemployeepageState();
}

class _AllemployeepageState extends State<Allemployeepage> {
  List<String> employees = [];


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
        print(employees);
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branches: $e');
      // Handle error case here
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchemployee();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconst.Mbg,
        title: Text('Employee details'),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(employees[index]),
            // subtitle: Text('Subtitle for List Tile $index'),
            onTap: () {
              // Add your logic here for each ListTile onTap action
              // For example, navigate to a new page or perform an action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Details of ${employees[index]}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}