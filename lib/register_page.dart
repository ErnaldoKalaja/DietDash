import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_service.dart';
import 'components/login_button.dart';
import 'components/login_textbox.dart';


class RegisterPage extends StatelessWidget{
  RegisterPage({
  super.key,
  required this.onPressed,
  });

  final Function()? onPressed;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp () {
    AuthService.signUpEmail(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text
    );
  }

  void signInGoogle () => AuthService.signInGoogle();

  @override
  Widget build(BuildContext context){
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Text("Register Page"),
                  const SizedBox(height: 100),
                  //Name Field
                  LoginTextbox(
                      hintText: 'Name',
                      controller: nameController
                  ),
                  //Email Field
                  LoginTextbox(
                    hintText: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  //Password Field
                  LoginTextbox(
                    hintText: 'Password (6 characters minimum)',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height:15),
                  LoginButton(
                    onPressed: signUp,
                    buttonText: "Create Account",
                  ),
                  const SizedBox(height:30),
                  SignInButton(Buttons.GoogleDark, onPressed: signInGoogle),
                  const SizedBox(height:20),
                  const Text("Already have an account?"),
                  ElevatedButton(
                      onPressed: onPressed,
                      child: const Text("Go to Login Page")
                  )

                ],
              ),
            ),
          ),
        )
    );
  }
}
