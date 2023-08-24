import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void signUserOut() async {
  try{
    await FirebaseAuth.instance.signOut();

    await GoogleSignIn().signOut();
  }
  catch(err){
    print('Sign out error is: $err');
  }

}