

  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:http/http.dart' as http;

class AllClients extends StatefulWidget {
  @override
  State<AllClients> createState() => _AllClientsState();
}

class _AllClientsState extends State<AllClients> {
  List<String> clientnames = [];


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
          clientnames.clear(); // Clear the existing list
          clientnames
              .addAll(updatedclientlist); 
              print(clientnames);
              // Add the updated branches
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getclient();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconst.Mbg,
        title: Text('Clients'),
      ),
      body: ListView.builder(
        itemCount: clientnames.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(clientnames[index]),
            // subtitle: Text('Subtitle for List Tile $index'),
            onTap: () {
              // Add your logic here for each ListTile onTap action
              // For example, navigate to a new page or perform an action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Details of ${clientnames[index]}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}