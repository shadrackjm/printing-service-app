// ignore_for_file: prefer_const_constructors, unused_element, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:print_services_app/constant.dart';
import 'package:print_services_app/models/api_response.dart';
import 'package:print_services_app/models/user.dart';
import 'package:print_services_app/screens/login.dart';
import 'package:print_services_app/services/user_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  bool loading = true;
  File? _imageFile;
  final _picker = ImagePicker();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtNameController = TextEditingController();

  // implement the image picker
  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  //get user
  void getUser() async {
    ApiResponse response = await getUserDetails();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
        txtNameController.text = user!.fullname ?? '';
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  // update Profile
  void updateProfile() async {
    ApiResponse response =
        await updateUser(txtNameController.text, getStringImage(_imageFile));
    setState(() {
      loading = false;
    });
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40),
            child: ListView(
              children: [
                Center(
                  child: GestureDetector(
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          image: _imageFile == null
                              ? user!.image != null
                                  ? DecorationImage(
                                      image: NetworkImage('${user!.image}'),
                                      fit: BoxFit.cover)
                                  : null
                              : DecorationImage(
                                  image: FileImage(_imageFile ?? File('')),
                                  fit: BoxFit.cover),
                          color: Colors.amber),
                    ),
                    onTap: () {
                      getImage();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    decoration: kinputDecoration('Full Name'),
                    controller: txtNameController,
                    validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                textButton('Update', () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    updateProfile();
                  }
                })
              ],
            ),
          );
  }
}
