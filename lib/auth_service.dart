import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_project/database_service.dart';
import 'main.dart';

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final DatabaseService databaseService = DatabaseService();
  
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  void signInEmail({
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

  void signUpEmail({
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
          databaseService.registerEmail(
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

  void authError(FirebaseAuthException e){
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

  void signOut(){
    FirebaseAuth.instance.signOut();
    googleSignIn.disconnect();
  }

  void signInGoogle() async {
    GoogleSignInAccount? user = await googleSignIn.signIn();
    
    GoogleSignInAuthentication auth = await user!.authentication;
    
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential)
        .then(
          (credential) {
            var userId = credential.user!.uid;
            var email = credential.user!.email!;
            var userName = credential.user!.displayName!;
            databaseService.registerGoogle(
              userId: userId, 
              email: email, 
              userName: userName
            );
          }
        );

    } on FirebaseAuthException catch (e){
      authError(e);   
    }
  }

}