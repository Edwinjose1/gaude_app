import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:http/http.dart' as http;

class AllProjects extends StatefulWidget {
  @override
  State<AllProjects> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
  List<String> projects = [];


  Future<void> fetchproject () async {
    try {
      final response = await http.get(
        Uri.parse('http://${Colorconst.ipaddress}:2000/api/project/get-project'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedBranches = (jsonData['result'] as List)
            .map((branchJson) => branchJson['project_client_name'].toString())
            .toList();

        setState(() {
          projects.clear();
          projects.addAll(updatedBranches);
        });
        print(projects);
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
    fetchproject();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconst.Mbg,
        title: Text('Projects'),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(projects[index]),
            // subtitle: Text('Subtitle for List Tile $index'),
            onTap: () {
              // Add your logic here for each ListTile onTap action
              // For example, navigate to a new page or perform an action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Details of ${projects[index]}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}