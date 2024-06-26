// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/components/bottom_app_bar.dart';
import 'package:flutter_project_final/components/custom_button.dart';
import 'package:flutter_project_final/screens/drawerMenu/aboutUs.dart';
import 'package:flutter_project_final/screens/drawerMenu/contacts.dart';
import 'package:flutter_project_final/screens/drawerMenu/privacy.dart';
import 'package:flutter_project_final/screens/drawerMenu/terms.dart';
import 'package:flutter_project_final/screens/dues_cars.dart';
import 'package:flutter_project_final/screens/login.dart';
import 'package:flutter_project_final/screens/add_cars.dart';
import 'package:flutter_project_final/screens/all_cars_list.dart';
import 'package:flutter_project_final/screens/rented_cars.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String version = '';

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = '${packageInfo.version}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(builder: (context) {
              return Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              );
            }),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: const Color.fromARGB(255, 34, 30, 30),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('Are you sure you want to SignOut?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    signout(context);
                                  },
                                  child: Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'))
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                  color: Colors.white),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Color.fromARGB(255, 43, 43, 43),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 50, 52),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Images/carvoyagepic.png',
                        width: 100,
                        height: 50,
                      ),
                      Text(
                        'Car Voyage',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.privacy_tip,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Privacy(),
                        ));
                  },
                ),
                ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      child: Image.asset(
                        'lib/icons/terms4.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    'Terms and Condition',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsAndConditionsPage(),
                        ));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.contact_support,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUsPage(),
                        ));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.policy_rounded,
                    color: Colors.white,
                  ),
                  title: Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutUsPage(),
                        ));
                  },
                ),
                SizedBox(
                  height: 190,
                ),
                Center(
                  child: Text(
                    'Version $version',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: buildCustomBottomAppBar(
          context: context,
          showNotification: true,
          showBrand: true,
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCars(),
                ));
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Color.fromARGB(115, 50, 49, 49),

        //body

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  child: Image.asset('assets/Images/hometest.png'),
                )),
                // ),
                const SizedBox(
                  height: 25,
                ),
                //Buttons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomButton(
                        width: double.infinity,
                        // width: 170,
                        height: 120,
                        icon: Icons.format_list_bulleted,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllCarList()),
                          );
                        },
                        text: 'Available\nCars',
                      ),
                    ),
                    SizedBox(width: 22),
                    Expanded(
                      child: CustomButton(
                        width: double.infinity,
                        // width: 170,
                        height: 120,
                        icon: Icons.car_rental,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RentedCar()),
                          );
                        },
                        text: 'Rented\nCars',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      width: 2,
                    ),
                    minimumSize: Size(362, 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DueCarsPAge(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range, size: 24, color: Colors.black),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Due Cars',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Signout function
  signout(BuildContext ctx) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    passwordController.clear();
    emailController.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => LoginScreen(),
        ),
        (route) => false);
  }
}
