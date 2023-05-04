import 'package:flutter/material.dart';
import 'package:test_project/register_page.dart';
import 'login_page.dart';



class AuthSelectPage extends StatefulWidget {
  const AuthSelectPage({super.key});

  @override
  State<AuthSelectPage> createState() => _AuthSelectPageState();
}

class _AuthSelectPageState extends State<AuthSelectPage> {
  bool isLoginPage = true;

  void togglePage(){
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context){
    return isLoginPage ? LoginPage(onPressed: togglePage) : RegisterPage(onPressed: togglePage);
  }
}
