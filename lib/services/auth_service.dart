import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService{
  //Google Sign In

  signInWithGoogle() async{
      //begin interactive sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      //obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      //create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      //once signed in, return the user
      return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
//   //begin interactive sign in process
//   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
//
//   //obtain auth details from request
//   final GoogleSignInAuthentication gAuth = await gUser!.authentication;
//
//   //create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: gAuth.accessToken,
//     idToken: gAuth.idToken,
//   );
//   //once signed in, return the user
//   return await FirebaseAuth.instance.signInWithCredential(credential);