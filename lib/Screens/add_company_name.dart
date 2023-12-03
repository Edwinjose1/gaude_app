import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Functions/functions.dart';
import 'package:gaude_app/companyname_response/companyname_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class CompanyNamePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CompanyNamePageState createState() => _CompanyNamePageState();
}

class _CompanyNamePageState extends State<CompanyNamePage> {
  List<CompanynameResponse> compnaynames = [];

  String companyName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcompanyname();
  }

  Future<void> getcompanyname() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${Colorconst.ipaddress}:2000/api/companyname/get-companyname'));
      print("${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<CompanynameResponse> updatednames = (jsonData['result'] as List)
            .map((branchJson) => CompanynameResponse.fromJson(branchJson))
            .toList();

        setState(() {
          compnaynames.clear(); // Clear the existing list
          compnaynames.addAll(updatednames);
          int length = compnaynames.length - 1;
          companyName = compnaynames[length].companyName!;
          // Add the updated branches
        });
        // companyName=companyName[0];
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branch: $e');
      // Handle error case here
    }
  }

  Future<void> addcompnayname({required String name}) async {
    var apiUrl =
        'http://${Colorconst.ipaddress}:2000/api/companyname/add-companyname';

    // Define the payload
    var payload = {
      'company_name': name,
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
        await getcompanyname(); // Fetch branches again after adding

        // Navigate back to the BranchPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CompanyNamePage()),
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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorconst.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const SizedBox(height: 40),
                Text(
                  companyName.isEmpty ? '' : companyName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://as1.ftcdn.net/v2/jpg/01/58/82/70/1000_F_158827023_i19bVTn4sGYNXC1r3e7fXtY6CShXVnI4.jpg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: size.width * .05,
                    ),
                    height: size.width / 8,
                    width: size.width / 1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Name Here......',
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 20.0),
                      ),
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() {
                          companyName = value;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    addcompnayname(name: companyName);
                    showAddingSnackbar(
                        context: context,
                        songName: "Company Name",
                        message: "New Name");
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(),
                    height: size.width / 8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colorconst.Mbg,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colorconst.Mbg,
                        width: 1.0,
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
