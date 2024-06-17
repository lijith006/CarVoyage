import 'package:flutter/material.dart';
import 'package:flutter_project_final/screens/brand_page.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:flutter_project_final/screens/notification_page.dart';

Widget buildCustomBottomAppBar({
  required BuildContext context,
  bool showHome = true,
  bool showNotification = false,
  bool showBrand = false,
  bool showSearch = false,
  VoidCallback? onSearchTap,
}) {
  return BottomAppBar(
    height: 70,
    color: Color.fromARGB(115, 50, 49, 49),
    shape: const CircularNotchedRectangle(),
    child: Row(
      children: [
        if (showHome)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            child: Container(
              height: 28,
              width: 28,
              child: Image.asset(
                'lib/icons/house.png',
                color: Colors.white,
              ),
            ),
          ),
        const Spacer(),
        if (showSearch)
          GestureDetector(
            onTap: onSearchTap,
            child: Container(
              height: 28,
              width: 28,
              child: Image.asset(
                'lib/icons/search.png',
                color: Colors.white,
              ),
            ),
          ),
        if (showNotification)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(),
                ),
              );
            },
            child: Container(
              height: 31,
              width: 31,
              child: Image.asset(
                'lib/icons/notification.png',
                color: Colors.white,
              ),
            ),
          ),
        SizedBox(
          width: 20,
        ),
        if (showBrand)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BrandPage(),
                ),
              );
            },
            child: Container(
              height: 31,
              width: 31,
              child: Image.asset(
                'lib/icons/brand-imagewhite.png',
                color: Colors.white,
              ),
            ),
          ),
      ],
    ),
  );
}
