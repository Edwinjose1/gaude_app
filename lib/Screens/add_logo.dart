import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/logoresponse/logoresponse.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class AddLogoPage extends StatefulWidget {
  @override
  _AddLogoPageState createState() => _AddLogoPageState();
}

class _AddLogoPageState extends State<AddLogoPage> {
  File? _image;
  late String _imageUrl;
  late String imageId;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> logo = [];

  List<Logoresponse> logoImage = [];
  String?  stringimage;

  @override
  void initState() {
    super.initState();
    fetchlogo();

    // _animation = Tween<double>(begin: 0, end: 1).animate(_controller!)
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> fetchlogo() async {
    try {
      final response = await http.get(
        Uri.parse('http://${Colorconst.ipaddress}:2000/api/logo/get-logo'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<String> updatedlogo = (jsonData['result'] as List)
            .map((branchJson) => branchJson['logo_image'].toString())
            .toList();

        setState(() {
          logo.clear();
          logo.addAll(updatedlogo);
          print(logo[0]);
          setState(() {
            stringimage=logo[0];
          });
        });
      } else {
        // Handle error case here
      }
    } catch (e) {
      print('Error fetching branches: $e');
      // Handle error case here
    }
  }

// Future<void> _getImageUrl() async {
//     final String serverUrl = 'http://your_server_url'; // Replace with your server URL
//     final String endpoint = '/getimage/${widget.imageId}';
//     final Uri uri = Uri.parse('$serverUrl$endpoint');

//     try {
//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         setState(() {
//           _imageUrl = uri.toString();
//         });
//       } else {
//         // Handle error or show a default image
//         print('Failed to fetch image: ${response.statusCode}');
//       }
//     } catch (error) {
//       // Handle network error
//       print('Error fetching image: $error');
//     }
//   }

  void uploadImage() async {
    if (_image == null) {
      print('No image selected');
      return;
    }

    final url = 'http://${Colorconst.ipaddress}:2000/api/logo/add-logo';
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      final imageFile =
          await http.MultipartFile.fromPath('logo_image', _image!.path);
      request.files.add(imageFile);
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }



  void showAddingSnackbar({
    required String songName,
    required String message,
  }) {
    // Ensure there is a Scaffold ancestor in the widget tree
    final scaffold = _scaffoldKey.currentContext;
    if (scaffold != null) {
      ScaffoldMessenger.of(scaffold).showSnackBar(
        SnackBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.black,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                songName,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Image URL: http://${Colorconst.ipaddress}:2000$stringimage");

    print('......................................http://${Colorconst.ipaddress}:2000/uploads/1701445764393-IMG_20231107_102710.jpg');
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorconst.white,
        key: _scaffoldKey, // Add this key to the Scaffold
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  ' COMPANY LOGO',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _getImageFromGallery,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colorconst.Mbg,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: 
                         ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            
                            child: Image(fit: BoxFit.fill,image: NetworkImage("http://${Colorconst.ipaddress}:2000/uploads/1701249706012-IMG_20231107_102722.jpg"))
                          ),
                        // :  Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         Icons.add_photo_alternate,
                        //         size: 60,
                        //         color: Colors.grey,
                        //       ),
                              
                              // Text(
                              //   stringimage!,
                              //   style: TextStyle(fontSize: 18),
                              // )
                          //   ],
                          // ),
                  ),
                ),
                const SizedBox(height: 30),
                Visibility(
                  visible: _image != null,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      uploadImage();
                      showAddingSnackbar(
                          songName: "New Logo", message: "New Logo Added");
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: size.width * .05,
                      ),
                      height: size.width / 8,
                      width: size.width / 1.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colorconst.Mbg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Save Logo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
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
