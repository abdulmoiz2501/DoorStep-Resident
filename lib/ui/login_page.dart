
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/components/signInButton.dart';
import 'package:project/components/square_tile.dart';
import 'package:project/components/textfield.dart';
import 'package:project/constants/colors.dart';

import '../components/progress_dialog.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signUserIn() async{
    ///Loading
    // Show the progress dialog before performing the task.
    ProgressDialogWidget.show(context, "Please wait...");


    ///Sign user in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Task completed. Hide the progress dialog.
      ProgressDialogWidget.hide(context);

    }on FirebaseAuthException catch (e){
      // Task completed. Hide the progress dialog.
      ProgressDialogWidget.hide(context);


      ///Wrong email
      if(e.code == 'user-not-found'){
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message:
            'The email you entered is not registered',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      ///Wrong password
      else if(e.code == 'wrong-password'){
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message:
            'The password you entered is incorrect',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      ///No internet
      else if(e.code == 'network-request-failed') {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message:
            'Please check your internet connection and try again',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.warning,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
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
                controlller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              //password
              MyTextField(
                controlller: passwordController,
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
                height: MediaQuery.of(context).size.height * 0.024,
              ),

              //google signin
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'lib/assets/images/google.png'),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              //not a user?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a user?",

                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.020,
                      color: kTextColor,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.015,
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.022,
                      color: kAccentColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
