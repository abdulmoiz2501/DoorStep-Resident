import 'package:firebase_auth/firebase_auth.dart';
class UserId {

  final FirebaseAuth auth = FirebaseAuth.instance;

  UserId(){
    final User? user = auth.currentUser;
    final uid = user?.uid;
  }
  get uid{}

}