import 'package:flutter/material.dart';
import 'package:flutter_project_final/screens/brand_page.dart';
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
                    color: Color.fromARGB(255, 77, 221, 82),
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
                color: Color.fromARGB(255, 147, 247, 150),
              ),
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
                    child: Center(
                      child: Text(
                        'Car Voyage',
                        style: TextStyle(
                          color: Color.fromARGB(255, 176, 227, 44),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 147, 247, 150),
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 147, 247, 150),
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
                    color: Color.fromARGB(255, 147, 247, 150),
                  ),
                  title: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 147, 247, 150),
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
                        color: Color.fromARGB(255, 147, 247, 150),
                      ),
                    ),
                  ),
                  title: Text(
                    'Terms and Condition',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 147, 247, 150),
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
                    color: Color.fromARGB(255, 147, 247, 150),
                  ),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 147, 247, 150),
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
                    color: Color.fromARGB(255, 147, 247, 150),
                  ),
                  title: Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 147, 247, 150),
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
        bottomNavigationBar: BottomAppBar(
          height: 70,
          color: Color.fromARGB(115, 50, 49, 49),
          shape: const CircularNotchedRectangle(),
          child: Row(
            children: [
              GestureDetector(
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
                    'lib/icons/house.png',
                    color: Color.fromARGB(255, 147, 247, 150),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrandPage(),
                      ));
                },
                child: Container(
                  height: 31,
                  width: 31,
                  child: Image.asset(
                    'lib/icons/brand-imagewhite.png',
                    color: Color.fromARGB(255, 147, 247, 150),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 147, 247, 150),
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

//---------------------------------------------------------------------------
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
                child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              child: Image.asset('assets/Images/home.jpg'),
            )),
            const SizedBox(
              height: 30,
            ),
            //buttons---------------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton.icon(
                label: const Text(
                  'Available Cars',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 147, 247, 150)),
                ),
                icon: const Icon(
                  Icons.format_list_bulleted,
                  size: 29,
                  color: Color.fromARGB(255, 147, 247, 150),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllCarList(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 78, 76, 76),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton.icon(
                label: const Text(
                  'Rented Cars',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 147, 247, 150)),
                ),
                icon: const Icon(
                  Icons.car_rental,
                  size: 29,
                  color: Color.fromARGB(255, 147, 247, 150),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RentedCar()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 78, 76, 76),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton.icon(
                label: const Text(
                  'Due Cars',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 147, 247, 150)),
                ),
                icon: const Icon(
                  Icons.date_range_outlined,
                  size: 29,
                  color: Color.fromARGB(255, 147, 247, 150),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DueCarsPAge(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 78, 76, 76),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),

            //buttons-------------------------------------------------------------------------------------------------------------
          ]),
        ),
      ),
    );
  }

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
