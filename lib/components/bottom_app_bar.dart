import 'package:flutter/material.dart';
import 'package:flutter_project_final/components/page_transition.dart';
import 'package:flutter_project_final/screens/brand_page.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:flutter_project_final/screens/notification_page.dart';

Widget buildCustomBottomAppBar({
  bool isHome = false,
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
            onTap: isHome
                ? null
                : () {
                    Navigator.push(
                        context, PageTransition.fade(const HomeScreen()));
                  },
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => HomeScreen(),
            //     ),
            //   );
            // },
            child: Container(
              height: 28,
              width: 28,
              child: Image.asset(
                'lib/icons/house.png',
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(isHome ? 0.5 : 1.0),
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
                  context, PageTransition.fade(const NotificationPage()));
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
              Navigator.push(context, PageTransition.fade(const BrandPage()));
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
