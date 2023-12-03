import 'package:flutter/material.dart';
import 'package:gaude_app/Constants/colorconst.dart';

// class Textandbutton extends StatefulWidget {
//   final String hintText;
//   final VoidCallback onButtonTap;

//   const Textandbutton({
//     Key? key,
//     required this.hintText,
//     required this.onButtonTap,
//   }) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _TextandbuttonState createState() => _TextandbuttonState();
// }

// class _TextandbuttonState extends State<Textandbutton> {
//   String companyName = '';

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 250,
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: widget.hintText,
//                 filled: true,
//                 fillColor: Colors.grey[300],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 16.0,
//                   horizontal: 20.0,
//                 ),
//               ),
//               textAlign: TextAlign.center,
//               onChanged: (value) {
//                 setState(() {
//                   companyName = value;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 16),
//           ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStatePropertyAll(Colorconst.But2color),
//             ),
//             onPressed: widget.onButtonTap,
//             child: const Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
// }
class Textandbutton extends StatelessWidget {
  final String hintText;
  final VoidCallback onButtonTap;
  final TextEditingController controller; // Add this line

  const Textandbutton({
    Key? key,
    required this.hintText,
    required this.onButtonTap,
    required this.controller, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SizedBox(
            width: 250,
            child: TextField(
              controller: controller, // Use the provided controller
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colorconst.But2color),
            ),
            onPressed: onButtonTap,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
