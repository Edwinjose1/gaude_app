import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Screens/widgets/animated_card.dart';
import 'package:gaude_app/Screens/widgets/textfield_button.dart';
import 'package:http/http.dart' as http;
import 'package:gaude_app/branch_response/branch_response.dart';

// ignore: use_key_in_widget_constructors
class BranchPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BranchPageState createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage>
    with SingleTickerProviderStateMixin {
  List<BranchResponse> branchnames = [];
  TextEditingController branchController = TextEditingController();

  AnimationController? _controller;
  Animation<double>? _animation;
  Animation<double>? _animation2;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: 1).animate(_controller!);

    _controller!.forward();
    getBranch();
  }

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
          branchnames.clear(); // Clear the existing list
          branchnames.addAll(updatedBranches); // Add the updated branches
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }

  Future<void> addBranch({required String name}) async {
    var apiUrl = 'http://${Colorconst.ipaddress}:2000/api/branch/add-branch';

    // Define the payload
    var payload = {
      'branch_name': name,
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
        // If addition is successful, fetch branches again to update the list
        await getBranch(); // Fetch branches again after adding
        setState(() {
          branchController
              .clear(); // Clear the text field after adding a branch
        });

        // Navigate back to the BranchPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BranchPage()),
        );
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
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colorconst.Mbg,
          title: const Text('BRANCHES'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Textandbutton(
              hintText: "Enter New Branch",
              onButtonTap: () {
                addBranch(name: branchController.text);
                setState(() {
                  // Clear the text field after adding a branch
                  branchController.clear();
                });

                // Rebuild the page by fetching the updated list
              },
              controller: branchController,
            ),

//             Textandbutton(
//   hintText: "Enter New Branch",
//   onButtonTap: () {
//     addBranch(name: branchController.text);
//     setState(() {
//       // Clear the text field after adding a branch
//       branchController.clear();
//     });

//     // Rebuild the page by fetching the updated list
//     getBranch();
//   },
//   controller: branchController,
// ),

            Expanded(
              child: ListView.builder(
                itemCount: branchnames.length,
                itemBuilder: (context, index) {
                  String name =
                      branchnames[index].branchName ?? 'Unknown Branch';
                  String imagePath =
                      'https://flutterx.com/thumbnails/artifact-1';
                  return AnimatedCard(
                    onTap: () {
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
