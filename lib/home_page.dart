import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';


class HomePage extends StatelessWidget{
  HomePage({super.key});

  void signOut() => AuthService.signOut();

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically.
              children: [
                const Text("Logged in"),
                ElevatedButton(
                  onPressed: signOut,
                  child: const Text("Log out"),
                ),
                Text(user.email!),
              ]
          )
      ),
    );
  }
}