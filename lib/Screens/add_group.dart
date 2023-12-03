import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Screens/widgets/group.dart';
import 'package:gaude_app/Screens/widgets/animated_card.dart';
import 'package:gaude_app/Screens/widgets/group_details.dart';
import 'package:gaude_app/employee_response/employee_response.dart';
import 'package:gaude_app/groupresponse/result.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;

// class Employee {
//   final int id;
//   final String name;

//   Employee({
//     required this.id,
//     required this.name,
//   });

//   @override
//   String toString() => name;
// }

class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> with SingleTickerProviderStateMixin {
  List<Result> groupnames = [];
  List<EmployeeResponse> employee1 = [];
  List<String> employeeNamesOnly = [];
  late Animation<double> _animation;
  late Animation<double> _animation2;

  void _showAddGroupBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddGroups();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    controller.forward();
    getEmployee();
    fetchgroup();
  }

  Future<void> getEmployee() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/employees/get-employee'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<EmployeeResponse> updatedemployeees = (jsonData['result'] as List)
            .map((employeeJson) => EmployeeResponse.fromJson(employeeJson))
            .toList();

        setState(() {
          employee1.clear(); // Clear the existing list
          employee1.addAll(updatedemployeees); // Add the updated employeees
        });
        employeeNamesOnly =
            employee1.map((employee) => employee.empName ?? '').toList();
        print("All employee names${employeeNamesOnly}");
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching employee: $e');
      // Handle error case here
    }
  }
  /////////////////////////////////////////////
  List<int> extractemployeeIds(String input) {

    RegExp regExp = RegExp(r'employee_id: (\d+)');
    Iterable<RegExpMatch> matches = regExp.allMatches(input);

    List<int> employeeIds = [];
    for (RegExpMatch match in matches) {
      if (match.groupCount >= 1) {
        String id = match.group(1)!;
        employeeIds.add(int.parse(id));
      }
    }
    print("##########${input}");
    return employeeIds;
  }

  ////////////////////////////////////////////////////

  ////////////////////////////////////////////////////
  Future<void>   fetchgroup() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/group/get-group'));
      print("This is response ${response.body}\n");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        List<Result> updatedemployeees = (jsonData['result'] as List)
            .map((groupJson) => Result.fromJson(groupJson))
            .toList();

        print(
            "...................................................................");
        print("hello${updatedemployeees[1].employees}/n");
        print(
            "...................................................................");
        setState(() {
          groupnames.clear(); // Clear the existing list
          groupnames.addAll(updatedemployeees); // Add the updated employeees
        });
      } else {}
    } catch (e) {
      print('Error fetching employee: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colorconst.white,
        appBar: AppBar(
          backgroundColor: Colorconst.Mbg,
          elevation: 0,
          title: const Text('Create Group'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showAddGroupBottomSheet(context);
                    },
                    icon: const Icon(
                      Icons.playlist_add,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Create Group',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                      backgroundColor: Colorconst.But2color,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: groupnames.length,
                itemBuilder: (context, index) {
                  // print(dep);
                  String name =
                      groupnames[index].groupName.toString() ??
                          'Unknown employee';

                  String employeesString =
                      groupnames[index].employees.toString();
                      
                  List<int> employeeIds = extractemployeeIds(employeesString);
                  // print("daa mwonneee${employeeIds}");
                  List<String> selectedemployeeNames = employeeIds.map((id) {
                    int index = id -
                  
                        1; // Adjusting the index to match the list indexing
                    // print('ID: $id, Adjusted Index: $index');

                    if (index >= 0 && index < employeeNamesOnly.length) {
                      return employeeNamesOnly[index];
                    } else {
                      // print('Index out of range: $index');
                      return ''; // Return a default value or handle out-of-range indices
                    }
                    
                  }).toList();

                  
                  String imagePath =
                      'https://flutterx.com/thumbnails/artifact-1';
                  return AnimatedCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GroupDetails(selectedEmployees: selectedemployeeNames),
                      ));
                    },
                    name: name,
                    imagePath: imagePath,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
