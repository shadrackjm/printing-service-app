import 'package:flutter/material.dart';
import 'package:print_services_app/screens/login.dart';
import 'package:print_services_app/screens/profile.dart';
import 'package:print_services_app/screens/services_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currntIndex = 0;
  void _handleTap(context) {
    // go to menu page
    Navigator.pushNamed(context, '/menupage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Printing App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 34, 94, 122),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Printing App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Order History'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: currntIndex == 0
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black38),
                          borderRadius: BorderRadius.circular(12)
                              .copyWith(topLeft: Radius.zero),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.room_service),
                            Text(
                              'Welcome Choose Service You Want',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Services We Offer!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const ServiceScreen(),
                  ],
                ),
              ),
            )
          : const Profile(),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 16,
        selectedIconTheme: const IconThemeData(
          size: 20,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: currntIndex,
        onTap: (val) {
          setState(() {
            currntIndex = val;
          });
        },
      ),
    );
  }
}
