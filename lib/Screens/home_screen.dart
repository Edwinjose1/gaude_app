import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaude_app/Screens/add_branch.dart';
import 'package:gaude_app/Screens/add_department.dart';
import 'package:gaude_app/Screens/add_designation.dart';
import 'package:gaude_app/Screens/add_group.dart';
import 'package:gaude_app/Screens/add_logo.dart';
import 'package:gaude_app/Constants/colorconst.dart';
import 'package:gaude_app/Screens/add_company_name.dart';
import 'package:gaude_app/Screens/add_new_client.dart';
import 'package:gaude_app/Screens/add_employee.dart';
import 'package:gaude_app/Screens/add_project_new.dart';
import 'package:gaude_app/Screens/add_work_catagory.dart';
import 'package:gaude_app/Screens/add_work_classification.dart';
import 'package:gaude_app/Screens/all_employees.dart';
import 'package:gaude_app/Screens/all_projects.dart';
import 'package:gaude_app/Screens/allclient.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> buttonNames = [
    "ADD LOGO",
    "COMPANY NAME",
    "ADD BRANCH",
    "ADD DEPARTMENT",
    "ADD DESIGNATION",
    "ADD EMPLOYEE",
    "GROUP NAME",
    "CHAT",
    "ADD CLIENT",
    "WORK CATEGORY",
    "WORK CLASSIFICATION",
    "CREATE PROJECT"
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    ))
    {
      throw "can not laucnch url";
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer:  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[



            DrawerHeader(
              decoration: BoxDecoration(
                color: Colorconst.Mbg,
              ),
              child: Text(
                'Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            
            SizedBox(height: 70,),



            ListTile(trailing: Icon(Icons.person),
            
              title: Text('Emloyees',style: TextStyle(fontSize: 20),),
              onTap: () {
                // Add your logic here for ListTile 1
                Navigator.push(context,MaterialPageRoute(builder: (context) => Allemployeepage(),)) ;// Close the drawer
              },
            ),
            ListTile(trailing: Icon(Icons.people),
              title: Text('Clients',style: TextStyle(fontSize: 20)),
              onTap: () {
                // Add your logic here for ListTile 2
                 Navigator.push(context,MaterialPageRoute(builder: (context) => AllClients(),)) ; // Close the drawer
              },
            ),
            ListTile(
              trailing: Icon(Icons.add_moderator_rounded),
              title: Text('Projects',style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => AllProjects(),)) ; // Close the drawer
              },
            ),
          ],
        ),
      ),
      
        backgroundColor: Colorconst.Mbg,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: Center(
                child: Text(
                  'SUPER ADMIN',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(.9),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 1.0,
                  mainAxisExtent: 80.0,
                ),
                itemCount: 8,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return MyElevatedButton(
                    name: buttonNames[index],
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      navigateToScreen(context, index);
                    },
                  );
                },
              ),
            ),
            const Divider(
              thickness: 2.0,
              color: Color.fromARGB(255, 110, 105, 105),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return MyElevatedButton(
                    name: buttonNames[index + 8],
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      navigateToScreen(context, index + 8);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddLogoPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompanyNamePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BranchPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Department()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Designation()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewEmployeeForm()),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Group()),
        );
        break;
      case 7:
        _launchURL('www.gaudesolutions.com');
        break;
      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Newclient()),
        );
        // Replace with your desired URL

        break;
      case 9:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Workcategory()),
        );
        break;
      case 10:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Workclassification()),
        );
      case 11:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewProjectForm()),
        );
        break;
      default:
      // Handle other cases or navigate to the desired screen
    }
  }
}

class MyElevatedButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  MyElevatedButton({required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(
          bottom: size.width * 0.06,
        ),
        height: size.width / 7,
        width: size.width / 3.90,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white.withOpacity(.9),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
