// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:print_services_app/components/my_button.dart';
import 'package:print_services_app/components/my_logo.dart';
import 'package:print_services_app/components/square_tiles.dart';
import 'package:print_services_app/constant.dart';
import 'package:print_services_app/models/api_response.dart';
import 'package:print_services_app/models/user.dart';
import 'package:print_services_app/screens/home_page.dart';
import 'package:print_services_app/screens/register.dart';
import 'package:print_services_app/services/user_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response =
        await login(emailController.text, passwordController.text);
    if (response.error == null) {
      _saveAndRedirectHome(response.data as User);
    } else {
      setState(() {
        loading = false;
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
                  height: 50,
                ),

               // logo
                MyLogo(imagePath: 'lib/images/CBE_Logo.png'),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 30,
                ),
                // welcome back
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // email

                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          obscureText: false,
                          validator: (val) => val!.isEmpty ? 'Required' : null,
                          decoration: kinputDecoration('Email'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // password
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (val) => val!.isEmpty ? 'Required' : null,
                          decoration: kinputDecoration('Password'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // forgot
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // sign in button
                        loading
                            ? Center(child: CircularProgressIndicator())
                            : MyButton(
                                label: 'Sign In',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = !loading;
                                      _loginUser();
                                    });
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // google + apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),
                    SizedBox(
                      width: 10,
                    ),
                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                // not a member register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an Account?',
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
                            MaterialPageRoute(builder: (context) => Register()),
                            (route) => false);
                      },
                      child: Text(
                        'Register Here!',
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
