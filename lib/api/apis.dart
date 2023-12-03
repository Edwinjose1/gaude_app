// import 'dart:convert';

// import 'package:gaude_app/branch_response/branch_response.dart';
// import 'package:http/http.dart' as http;

// // Future<BranchResponse> getBranch({required String branchName}) async {
// //   final response =
// //       await http.get(Uri.parse('http://192.168.1.41:2000/api$branchName'));
// //       final _bodyAsJson=jsonDecode(response.body)as Map<String,dynamic>;

// //   final data=BranchResponse.fromJson(_bodyAsJson);
// //   return data;
// // }
// // static const String baseURL = 'http:// 192.168.1.41:2000/api/branch/get-branch';
//  Future<void> fetchEmployees() async {
//     final response = await http
//         .get(Uri.parse('https://cashbes.com/attendance/apis/employees'));

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       setState(() {
//         employees = (jsonData['data'] as List)
//             .map((employeeJson) => Employee.fromJson(employeeJson))
//             .toList();
//         print(employees.length);
//       });
//     } else {
//       // Handle error case here
//       print('Failed to fetch employees. Error: ${response.statusCode}');
//     }
//   }
