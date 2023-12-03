import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Screens/widgets/animated_card.dart';
import 'package:gaude_app/Screens/widgets/designation.dart';
import 'package:gaude_app/Screens/widgets/group_details.dart';
import 'package:gaude_app/department_response/department_response.dart';
import 'package:gaude_app/designation/designation.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class Designation extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DesignationState createState() => _DesignationState();
}

class _DesignationState extends State<Designation>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late Animation<double> _animation2;

  List<DesignationModel> designationnames = [];
  List<DepartmentResponse> department1 = [];
  List<String> departmentNamesOnly = [];

  void _showAddDesignationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddDesignations();
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
    getDepartment();
    fetchDesignation();
  }

  //////////////////////////////////////////////////////
  Future<void> getDepartment() async {
    print("######");
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/department/get-department'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<DepartmentResponse> updateDepartment = (jsonData['result'] as List)
            .map(
                (departmentJson) => DepartmentResponse.fromJson(departmentJson))
            .toList();
        print(
            "##################################${updateDepartment}#############################################");
        setState(() {
          department1.clear(); // Clear the existing list
          department1.addAll(updateDepartment); // Add the updated branches
        });
        departmentNamesOnly = department1
            .map((department) => department.departmentName ?? '')
            .toList();
        print("All branch names${departmentNamesOnly}");
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }

/////////////////////////////////////////////
  List<int> extractDepartmentIds(String input) {
    RegExp regExp = RegExp(r'department_id: (\d+)');
    Iterable<RegExpMatch> matches = regExp.allMatches(input);

    List<int> departmentIds = [];
    for (RegExpMatch match in matches) {
      if (match.groupCount >= 1) {
        String id = match.group(1)!;
        departmentIds.add(int.parse(id));
      }
    }
    return departmentIds;
  }

  ////////////////////////////////////////////////////
  Future<void> fetchDesignation() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/designation/get-designation'));
      print("This is response ${response.body}\n");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        List<DesignationModel> updatedDepartment = (jsonData['result'] as List)
            .map((departmentJson) => DesignationModel.fromJson(departmentJson))
            .toList();

        print(
            "...................................................................");
        print("hello${updatedDepartment[1].departmentes}/n");
        print(
            "...................................................................");
        setState(() {
          designationnames.clear(); // Clear the existing list
          designationnames
              .addAll(updatedDepartment); // Add the updated branches
        });
      } else {}
    } catch (e) {
      print('Error fetching branch: $e');
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
          title: const Text('Designation'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showAddDesignationBottomSheet(context);
                    },
                    icon: const Icon(
                      Icons.playlist_add,
                      color: Colors.white,
                    ),
                    label: const Text(
                      ' Add Designation',
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
                itemCount: designationnames.length,
                itemBuilder: (context, index) {
                  // print(dep);
                  String name =
                      designationnames[index].designationName.toString() ??
                          'Unknown Branch';

                  String branchesString =
                      designationnames[index].departmentes.toString();

                  List<int> branchIds = extractDepartmentIds(branchesString);
                  // print("daa mwonneee${branchIds}");
                  List<String> selectedBranchNames = branchIds.map((id) {
                    int index = id -
                        1; // Adjusting the index to match the list indexing
                    // print('ID: $id, Adjusted Index: $index');

                    if (index >= 0 && index < departmentNamesOnly.length) {
                      return departmentNamesOnly[index];
                    } else {
                      // print('Index out of range: $index');
                      return ''; // Return a default value or handle out-of-range indices
                    }
                  }).toList();

                  // print(selectedBranchNames);
                  String imagePath =
                      'https://flutterx.com/thumbnails/artifact-1';
                  return AnimatedCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupDetails(
                                selectedEmployees: selectedBranchNames),
                          ));
                      // Handle onTap action for each card
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
