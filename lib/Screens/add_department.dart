import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Screens/widgets/animated_card.dart';
import 'package:gaude_app/Screens/widgets/department.dart';
import 'package:gaude_app/Screens/widgets/group_details.dart';
import 'package:gaude_app/branch_response/branch_response.dart';
import 'package:gaude_app/department_response/result.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class Department extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DepartmentState createState() => _DepartmentState();
}

class _DepartmentState extends State<Department>
    with SingleTickerProviderStateMixin {
  List<Result> departmentnames = [];
  List<BranchResponse> branchnames1 = [];
  List<String> branchNamesOnly = [];

  late Animation<double> _animation;
  late Animation<double> _animation2;

  void _showAddDepartmentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddDepartments();
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
    getBranch();
    fetchDepartment();
  }

  //////////////////////////////////////////////////////
  Future<void> getBranch() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/branch/get-branch'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<BranchResponse> updatedBranches = (jsonData['result'] as List)
            .map((branchJson) => BranchResponse.fromJson(branchJson))
            .toList();

        setState(() {
          branchnames1.clear(); // Clear the existing list
          branchnames1.addAll(updatedBranches); // Add the updated branches
        });
        branchNamesOnly =
            branchnames1.map((branch) => branch.branchName ?? '').toList();
        print("All branch names${branchNamesOnly}");
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }

/////////////////////////////////////////////
  List<int> extractBranchIds(String input) {
    RegExp regExp = RegExp(r'branch_id: (\d+)');
    Iterable<RegExpMatch> matches = regExp.allMatches(input);

    List<int> branchIds = [];
    for (RegExpMatch match in matches) {
      if (match.groupCount >= 1) {
        String id = match.group(1)!;
        branchIds.add(int.parse(id));
      }
    }
    return branchIds;
  }

  ////////////////////////////////////////////////////
  Future<void> fetchDepartment() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/department/get-department'));
      print("This is response ${response.body}\n");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        List<Result> updatedBranches = (jsonData['result'] as List)
            .map((departmentJson) => Result.fromJson(departmentJson))
            .toList();

        print(
            "...................................................................");
        print("hello${updatedBranches[1].branches}/n");
        print(
            "...................................................................");
        setState(() {
          departmentnames.clear(); // Clear the existing list
          departmentnames.addAll(updatedBranches); // Add the updated branches
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
          title: const Text('Department'),
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
                      _showAddDepartmentBottomSheet(context);
                    },
                    icon: const Icon(
                      Icons.playlist_add,
                      color: Colors.white,
                    ),
                    label: const Text(
                      ' Add Department',
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
                itemCount: departmentnames.length,
                itemBuilder: (context, index) {
                  // print(dep);
                  String name =
                      departmentnames[index].departmentName.toString() ??
                          'Unknown Branch';

                  String branchesString =
                      departmentnames[index].branches.toString();

                  List<int> branchIds = extractBranchIds(branchesString);
                  // print("daa mwonneee${branchIds}");
                  List<String> selectedBranchNames = branchIds.map((id) {
                    int index = id -
                        1; // Adjusting the index to match the list indexing
                    // print('ID: $id, Adjusted Index: $index');

                    if (index >= 0 && index < branchNamesOnly.length) {
                      return branchNamesOnly[index];
                    } else {
                      // print('Index out of range: $index');
                      return ''; // Return a default value or handle out-of-range indices
                    }
                  }).toList();

                  // print(selectedBranchNames);

                  //  = updatedBranches[index].branches
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
