import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaude_app/Functions/functions.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Screens/widgets/animated_card.dart';
import 'package:gaude_app/Screens/widgets/textfield_button.dart';
import 'package:gaude_app/category_response/category_response.dart';
import 'package:http/http.dart' as http;

class Workcategory extends StatefulWidget {
  @override
  _WorkcategoryState createState() => _WorkcategoryState();
}

class _WorkcategoryState extends State<Workcategory>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  Animation<double>? _animation2;
  List<CategoryResponse> categoryNames = [];
  TextEditingController categoryController = TextEditingController();
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
    getcategory();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future<void> getcategory() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/category/get-category'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<CategoryResponse> updatedClasssification =
            (jsonData['result'] as List)
                .map((branchJson) => CategoryResponse.fromJson(branchJson))
                .toList();

        setState(() {
          categoryNames.clear(); // Clear the existing list
          categoryNames
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

  Future<void> addcategory({required String name}) async {
    var apiUrl =
        'http://${Colorconst.ipaddress}:2000/api/category/add-category';

    // Define the payload
    var payload = {
      'category_name': name,
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
        await getcategory(); // Fetch branches again after adding
        setState(() {
          categoryController
              .clear(); // Clear the text field after adding a branch
        });

        // Navigate back to the BranchPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Workcategory()),
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
          // brightness: Brightness.dark,
          elevation: 0,
          title: const Text('WORK  CATEGORY'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Textandbutton(
              hintText: "Enter New Branch",
              onButtonTap: () {
                addcategory(name: categoryController.text);
                setState(() {
                  // Clear the text field after adding a branch
                  categoryController.clear();
                });

                // Rebuild the page by fetching the updated list
              },
              controller: categoryController,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categoryNames.length,
                itemBuilder: (context, index) {
                  String name =
                      categoryNames[index].categoryName ?? 'Unknown Branch';
                  String imagePath =
                      'https://flutterx.com/thumbnails/artifact-1';
                  return AnimatedCard(
                    onTap: () {},
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
