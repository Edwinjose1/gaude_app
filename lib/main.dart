import 'package:flutter/material.dart';
import 'package:gaude_app/Screens/home_screen.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Loginfo/loginpage.dart';
import 'package:gaude_app/Screens/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  // final BottomSheetController _bottomSheetController=Get.put(BottomSheetController());
  Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
