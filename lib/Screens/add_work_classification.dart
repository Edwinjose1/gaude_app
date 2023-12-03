import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Functions/functions.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Screens/widgets/animated_card.dart';
import 'package:gaude_app/Screens/widgets/textfield_button.dart';
import 'package:gaude_app/classification_response/classification_response.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class Workclassification extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _WorkclassificationState createState() => _WorkclassificationState();
}

class _WorkclassificationState extends State<Workclassification>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  Animation<double>? _animation2;
  List<ClassificationResponse> classificationNames = [];
  TextEditingController classificationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));

    _controller!.forward();
    getclassification();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future<void> getclassification() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/classification/get-classification'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<ClassificationResponse> updatedClasssification =
            (jsonData['result'] as List)
                .map(
                    (branchJson) => ClassificationResponse.fromJson(branchJson))
                .toList();

        setState(() {
          classificationNames.clear(); // Clear the existing list
          classificationNames
              .addAll(updatedClasssification); // Add the updated branches
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }

  Future<void> addClassification({required String name}) async {
    var apiUrl =
        'http://${Colorconst.ipaddress}:2000/api/classification/add-classification';

    // Define the payload
    var payload = {
      'classification_name': name,
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
        await getclassification(); // Fetch branches again after adding
        setState(() {
          classificationController
              .clear(); // Clear the text field after adding a branch
        });

        // Navigate back to the BranchPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Workclassification()),
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Colorconst.But2color,
          elevation: 0,
          title: const Text('WORK CLASSIFICATION'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Textandbutton(
              hintText: "Enter New Branch",
              onButtonTap: () {
                addClassification(name: classificationController.text);
                setState(() {
                  // Clear the text field after adding a branch
                  classificationController.clear();
                });

                // Rebuild the page by fetching the updated list
              },
              controller: classificationController,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: classificationNames.length,
                itemBuilder: (context, index) {
                  String name = classificationNames[index].classificationName ??
                      'Unknown Branch';
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
