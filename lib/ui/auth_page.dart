import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/services/login_or_register.dart';

import 'home/home_page.dart';
import 'login_page.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        ///This will constantly check if the user is logged in or not
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            print('snapshot has data');
            return HomePage();
          }
          else if(snapshot.hasError)
            {
              print('snapshot has error');
              return  Scaffold(
                body: Center(
                  child: Text('Something went wrong'),
                ),
              );
            }
          //Is the user NOT logged in
          else{
            return LoginOrRegisterPage();
          }
        },

      ),
    );
  }
}
