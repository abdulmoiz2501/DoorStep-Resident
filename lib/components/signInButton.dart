import 'package:flutter/material.dart';

import '../constants/colors.dart';
class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.065),
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.065),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.065),
      ),
      child: Center(
        child: Text(
          'Sign In',
          style: TextStyle(
            color: kTextColor,
            fontSize: MediaQuery.of(context).size.height * 0.025,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
