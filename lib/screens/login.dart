// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_project_final/db_functions/auth_function.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:flutter_project_final/screens/register_page.dart';
import 'package:flutter_project_final/components/appButton.dart';
import 'package:flutter_project_final/components/apptext.dart';
import 'package:flutter_project_final/components/customtextformfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

final _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 70,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //AppText METHODE----------------------------------------------
                      AppText(
                        data: 'LOGIN',
                        color: Colors.white,
                        size: 25,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                        controller: emailController,
                        hintText: 'Email',
                        labelText: 'Email',
                        labelstyle: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //APP TEXT PSWD-------------------------------------------
                      CustomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return "Password Should be greater than 6 characters";
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: passwordController,
                        hintText: 'Password',
                        labelText: 'Password',
                        labelstyle: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      //APP Button-------------------------------------------------------------
                      Center(
                        child: AppButton(
                            height: 50,
                            width: 200,
                            color: Colors.blueAccent,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });
                                final user = await authService.loginUser(
                                    emailController.text.trim(),
                                    passwordController.text);
                                Navigator.pop(context);
                                if (user != null) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                      (route) => false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('No user exists')));
                                }
                              }
                            },
                            child: AppText(
                              data: 'Login',
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
                            },
                            child: AppText(
                              data: "Register",
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
