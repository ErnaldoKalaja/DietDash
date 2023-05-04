import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../services/auth_service.dart';
import '../components/login_button.dart';
import '../components/login_textbox.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({
  super.key,
  required this.onPressed,
  });

  final AuthService authService = AuthService();

  final Function()? onPressed;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp() {
    authService.signUpEmail(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text);
  }

  void signInGoogle() => authService.signInGoogle();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              // Background image
              Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      const Text(
                        "NutriGuide",
                        style: TextStyle(
                            fontSize: 60,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 100),
                      // Name Field
                      LoginTextbox(hintText: 'Name', controller: nameController),
                      // Email Field
                      LoginTextbox(
                        hintText: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      // Password Field
                      LoginTextbox(
                        hintText: 'Password (6 characters minimum)',
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 15),
                      LoginButton(
                        onPressed: signUp,
                        buttonText: "Create Account",
                      ),
                      const SizedBox(height: 30),
                      SignInButton(Buttons.GoogleDark, onPressed: signInGoogle),
                      const SizedBox(height: 20),
                      const Text("Already have an account?"),
                      ElevatedButton(
                          onPressed: onPressed,
                          child: const Text("Go to Login Page")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}