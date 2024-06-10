import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_final/db_functions/auth_function.dart';
import 'package:flutter_project_final/models/usermodel.dart';
import 'package:flutter_project_final/components/appButton.dart';
import 'package:flutter_project_final/components/apptext.dart';
import 'package:flutter_project_final/components/customtextformfield.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final _regKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
            key: _regKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: AppText(
                          data: 'Create an Account',
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //NAME--------------------------------------------------------------
                      CustomTextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]+')),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        controller: _nameController,
                        hintText: 'Enter Name',
                        labelText: 'Name',
                        labelstyle: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //UserName--------------------------------------------------------------
                      CustomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                        controller: _emailController,
                        hintText: 'Enter Email',
                        labelText: 'Email',
                        labelstyle: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //--APP TEXT PSWD--------------------------------------------------------
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
                        controller: _passwordController,
                        hintText: 'Enter Password',
                        labelText: 'Password',
                        labelstyle: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      //Phone-------------------------------------------------------------------
                      CustomTextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]')), // Example input formatter
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mobile Number is required';
                          }
                          if (value.length != 10) {
                            return 'Mobile Number must be 10 digits';
                          }
                          return null;
                        },
                        controller: _phoneController,
                        hintText: 'Enter PhoneNumber',
                        labelText: 'Phone',
                        labelstyle: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: AppButton(
                            height: 50,
                            width: 200,
                            color: Colors.blueAccent,
                            onTap: () async {
                              var uuid = const Uuid().v1();
                              if (_regKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });
                                UserModel user = UserModel(
                                    id: uuid,
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    name: _nameController.text,
                                    phone: _phoneController.text,
                                    status: 1);
                                final res =
                                    await authService.registerUser(user);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                        'Registration completed succesfully')));
                                Navigator.pop(context);
                                if (res == true) {
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: AppText(
                              data: 'Register',
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            data: 'Already have an account?',
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: AppText(
                              data: 'Login',
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
