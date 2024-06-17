import 'package:flutter/material.dart';

class CustomButtonAll extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double borderRadius;
  final IconData? icon;

  const CustomButtonAll({
    this.icon,
    Key? key,
    required this.label,
    required this.onPressed,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon),
          SizedBox(width: icon != null ? 8.0 : 0),
          Text(label),
        ],
      ),
    );
  }
}
