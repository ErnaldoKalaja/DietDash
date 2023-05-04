import 'package:flutter/material.dart';

class LoginTextbox extends StatelessWidget {
  final String hintText; //shown when empty
  final TextEditingController controller; //text controller
  final bool obscureText; //hides typed text, default false
  final TextInputType keyboardType; //type of keyboard

  const LoginTextbox({
  super.key,
  required this.hintText,
  required this.controller,
  this.obscureText = false,
  this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10
      ),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.5,
            ),
          ),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
        ),
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }
}
