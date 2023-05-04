import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_project/screens/grocery_screen.dart';
import 'package:test_project/screens/search_screen.dart';
import 'home_page.dart'; // Import home_page.dart

import 'auth_page.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Diet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange[500],
      ),
      home: AuthPage(),
      navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    SearchScreen(),
    GroceryScreen(),
    HomePage(), // Add HomePage to the list
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            label: 'Grocery',
          ),
          BottomNavigationBarItem(  // Add a new BottomNavigationBarItem for the home page
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}