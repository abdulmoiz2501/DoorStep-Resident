import 'package:flutter/material.dart';
import 'package:project/ui/login_page.dart';

import '../ui/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  ///This is the page that will be shown to the user when they open the app
  bool showLoginPage = true;


  ///To toggle between login and register page
  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
        onSignUpClicked: togglePage,
      );
    } else{
      {
        return RegisterPage(
          onSignUpClicked: togglePage,
        );
      }
    }
  }
}
