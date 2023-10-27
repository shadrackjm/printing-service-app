import 'package:flutter/material.dart';
import 'package:print_services_app/screens/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'printing App',
      theme: ThemeData(
          useMaterial3: true,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey[400],
            backgroundColor: const Color.fromARGB(255, 34, 94, 122),
          ),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 34, 94, 122),
          )),
      home: const Loading(),
    );
  }
}
