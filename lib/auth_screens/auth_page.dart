import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_page.dart';
import 'auth_select_page.dart';
import '../main.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>{
  User? user;

  @override
  void initState(){
    super.initState();
    checkAuthStatus();
  }

  void checkAuthStatus(){
    FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser){
      setState( () => {user = firebaseUser} );
    });
  }

  @override
  Widget build(BuildContext context){
    if (user == null){
      return AuthSelectPage();
    }else{
      return MyHomePage(); // Here's the change
    }
  }
}