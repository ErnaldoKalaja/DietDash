import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_project/database_service.dart';
import 'main.dart';

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static void signInEmail({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
    } on FirebaseAuthException catch (e){
      authError(e);   
    }
  }

  static void signUpEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
      ).then(
        (credential) {
          DatabaseService.registerEmail(
            userName: name, 
            email: email,
            userId: credential.user!.uid,
          );
        }
      );
    } on FirebaseAuthException catch (e){
      authError(e);   
    }
  }

  static void authError(FirebaseAuthException e){
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(e.code),
          content: const Text('Please try again'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void signOut(){
    FirebaseAuth.instance.signOut();
  }

  static signInGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    GoogleSignInAccount? user = await googleSignIn.signIn();
    
    GoogleSignInAuthentication auth = await user!.authentication;
    
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e){
      authError(e);   
    }
  }

}