import 'package:flutter/material.dart';

const baseURL = 'http://192.168.43.175:8000/api';
const loginURL = '$baseURL/login';
const registerURL = '$baseURL/register';
const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const serviceURL = '$baseURL/services';
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something Went Wrong';

InputDecoration kinputDecoration(String hintText) {
  return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      fillColor: Colors.grey.shade200,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[500]));
}

TextButton textButton(String label, Function onPressed) {
  return TextButton(
    onPressed: () => onPressed(),
    style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
            (states) => const Color.fromARGB(255, 34, 94, 122)),
        padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(vertical: 10))),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
