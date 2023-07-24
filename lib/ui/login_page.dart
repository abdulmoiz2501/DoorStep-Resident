import 'package:flutter/material.dart';
import 'package:project/components/signInButton.dart';
import 'package:project/components/textfield.dart';
import 'package:project/constants/colors.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              //logo
              Icon(
                Icons.lock,
                size: 100,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              //welcomeback
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.029,
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              //username

              MyTextField(
                controlller: widget.usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              //password
              MyTextField(
                controlller: widget.passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              //forgot pass
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.065),
                child: Row(
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: kTextColor),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),

              //signin
              SignInButton(),
              //continue with

              //google sinin

              //not a user?
            ],
          ),
        ),
      ),
    );
  }
}
