import 'package:flutter/material.dart';

Widget customElevatedbutton({
  required VoidCallback onpressed,
  required String label,
  Color? backgroundColor,
  Color? foregroundColor,
  required Icon icon,
  required MaterialColor labelColor,
  required int width,
  required int height,
  // required MaterialColor foregroundColor,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 10, 47, 39),
      foregroundColor: Color.fromARGB(255, 249, 248, 248),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onpressed,
    child: Text(
      label,
      style: TextStyle(
        color: foregroundColor,
      ),
    ),
  );
}
