// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:print_services_app/components/my_logo.dart';
// import 'package:fypms_app/components/logo.dart';

import 'package:print_services_app/constant.dart';
import 'package:print_services_app/screens/home_page.dart';
import 'package:print_services_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/my_button.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();

  void _registerUser() async {
    ApiResponse response = await register(
      fullnameController.text,
      emailController.text,
      passwordController.text,
      confirmpassController.text,
    );
    if (response.error == null) {
      _saveAndRedirectHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  void _saveAndRedirectHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                // logo
                MyLogo(imagePath: 'lib/images/CBE_Logo.png'),
                SizedBox(
                  height: 25,
                ),
                // welcome back
                Text(
                  'Welcome To FYPMS APP',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                // regno
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        // level
                        TextFormField(
                          controller: fullnameController,
                          obscureText: false,
                          validator: (val) => val!.isEmpty ? 'Required' : null,
                          decoration: kinputDecoration('Full Name'),
                        ), // phone

                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          obscureText: false,
                          validator: (val) => val!.isEmpty ? 'Required' : null,
                          decoration: kinputDecoration('Email'),
                        ),
                        // password
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (val) => val!.isEmpty ? 'Required' : null,
                          decoration: kinputDecoration('Password'),
                        ),
                        // cpassword
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: confirmpassController,
                          obscureText: true,
                          validator: (val) => val!.isEmpty ? 'Required' : null,
                          decoration: kinputDecoration('Confirm Password'),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // sign in button
                        loading
                            ? Center(child: CircularProgressIndicator())
                            : MyButton(
                                label: 'Register',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = !loading;
                                      _registerUser();
                                    });
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                // not a member register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Login()),
                            (route) => false);
                      },
                      child: Text(
                        'Login Here!',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
