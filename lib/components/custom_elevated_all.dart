// import 'package:flutter/material.dart';

// class CustomButtonAll extends StatelessWidget {
//   final String label;
//   final VoidCallback onPressed;
//   final double borderRadius;
//   final IconData? icon;

//   const CustomButtonAll({
//     this.icon,
//     Key? key,
//     required this.label,
//     required this.onPressed,
//     this.borderRadius = 8.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (icon != null) Icon(icon),
//           SizedBox(width: icon != null ? 8.0 : 0),
//           Text(label),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomButtonAll extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double borderRadius;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;

  const CustomButtonAll({
    this.icon,
    Key? key,
    required this.label,
    required this.onPressed,
    this.borderRadius = 16.0,
    this.backgroundColor =
        const Color.fromRGBO(255, 255, 255, 0.1), // default glass white
    this.textColor = Colors.white, // default white text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

//glass
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      ).copyWith(
        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
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
// import 'package:flutter/material.dart';

// import 'dart:ui';

// class CustomButtonAll extends StatelessWidget {
//   final String label;
//   final VoidCallback onPressed;
//   final IconData? icon;
//   final double borderRadius;

//   const CustomButtonAll({
//     Key? key,
//     required this.label,
//     required this.onPressed,
//     this.icon,
//     this.borderRadius = 18.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(borderRadius),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//         child: InkWell(
//           onTap: onPressed,
//           splashColor: Colors.white24,
//           highlightColor: Colors.white10,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1), // semi-transparent
//               borderRadius: BorderRadius.circular(borderRadius),
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.3),
//                 width: 1.2,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.25),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (icon != null)
//                   Icon(
//                     icon,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 if (icon != null) const SizedBox(width: 8),
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.6,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
