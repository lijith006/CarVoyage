import 'package:flutter/material.dart';
import 'package:flutter_project_final/db_functions/auth_function.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:flutter_project_final/screens/login.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  Future<void> checkLoginState() async {
    await Future.delayed(Duration(seconds: 4));

    final authService = Provider.of<AuthService>(context, listen: false);

    final isLoggedIn = await authService.isUserLoggedIn();

    if (isLoggedIn) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Lottie.asset(
          'assets/Images/animations/car_logo_anim.json',
          repeat: true,
        ),
      ),
    );
  }
}
