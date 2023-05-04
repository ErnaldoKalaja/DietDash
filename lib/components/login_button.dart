import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {

  final Function()? onPressed; //function called when button pressed
  final String buttonText;

  const LoginButton({
  super.key,
  required this.onPressed,
  required this.buttonText,
  });

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(22,14,22,14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          )
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
