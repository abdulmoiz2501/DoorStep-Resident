import 'package:flutter/material.dart';
import 'package:project/components/signInButton.dart';
import 'package:project/components/square_tile.dart';
import 'package:project/components/textfield.dart';
import 'package:project/constants/colors.dart';

import '../auth/signUserIn.dart';

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
                color: kAccentColor,
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
                height: MediaQuery.of(context).size.height * 0.019,
              ),

              //forgot pass
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.065),
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

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.024,
              ),
              //signin
              SignInButton(
                onTap: signUserIn,
              ),
              //continue with

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.044,
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.025),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.2,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.025),
                      child: Text(
                        'Or continue with ',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.019,
                          color: kTextColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.2,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.044,
              ),

              //google signin
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'lib/assets/images/google.png'),
                ],

              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.044,
              ),

              //not a user?




            ],
          ),
        ),
      ),
    );
  }
}
