import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim()
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Password reset link sent! Please check your email.'),
          );
        },
      );

    } on FirebaseAuthException catch (e) {
      String errorMessage = 'The email address you entered does not exist.';
      if (e.code == 'invalid-email') {
        errorMessage = 'The email address you entered is not valid. Please enter a valid email.';
      }
       showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errorMessage),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Forgot Password', style: TextStyle(
          color: Colors.white,
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Enter your email address below. We will send you a reset password link.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'CircularStd-Book',
              fontSize: 15,
            ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.065),
            child: TextFormField(
            obscureText: false,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kWhite,
            ),
              borderRadius: BorderRadius.circular(20.0),
            ),
           focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(
           color: kAccentColor3,
            ),
             borderRadius: BorderRadius.circular(20.0),
            ),
           fillColor: kTextBoxColor,
           filled: true,
           hintText: 'Email',
           hintStyle: TextStyle(
             color:kHintTextColor,
          ),
          ),
          ),
          ),
          SizedBox(height: 10),
          MaterialButton(onPressed: passwordReset,
          child:Text('Reset password'),
          color: kTextBoxColor,
          ),
        ],
      ),
      );
  }
}